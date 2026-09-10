import struct, re
from unicorn import *
from unicorn.x86_const import *

img=open('unpacked2.bin','rb').read()
IB=0x10000000

# ---------- exact thunk addr -> api name, taken from the unpacked image ----------
# iat_map.txt has 176 slots; unresolved ones are '?0xADDR' where ADDR is the thunk.
slot2name={}
for line in open('thunkmap.txt'):
    a,n=line.split(None,1)
    slot2name[int(a,16)]=n.strip()
print("thunks mapped:",len(slot2name))

mu=Uc(UC_ARCH_X86,UC_MODE_32)
mu.mem_map(IB,0x300000); mu.mem_write(IB,img)
mu.mem_map(0x40000000,0x200000)
mu.mem_map(0x50000000,0x400000)
mu.mem_map(0x60000000,0x4000000)
mu.mem_map(0x70000000,0x80000)
TEB=0x7efdd000; mu.mem_map(TEB,0x2000)
mu.mem_write(TEB,struct.pack('<I',0xffffffff))
mu.mem_write(TEB+0x2c,struct.pack('<I',0x7efdf000)); mu.mem_map(0x7efdf000,0x4000)
mu.msr_write(0xC0000100,TEB)

REG={'SetupID':b'1082593784-1898402330-2418652173-2326646239\0',
     'SetupSysID':b'3B3C3B3A393F403B3C39\0',
     'ProductId':b'00330-80000-00000-AA123\0'}

def cstr(a,mx=260):
    try:
        o=b''
        for i in range(mx):
            c=mu.mem_read(a+i,1)[0]
            if c==0: break
            o+=bytes([c])
        return o.decode('latin-1','replace')
    except: return ''

calls=[]; scratch=[0x40010000]
def alloc(n):
    n=max(n,0x40)
    p=scratch[0]; scratch[0]=(p+n+0xfff)&~0xfff
    mu.mem_write(p,b'\0'*((n+0xfff)&~0xfff)); return p

# operator new / malloc stubs inside the image
NEW_FNS={0x100f7006:1, 0x100f7320:1, 0x100f735d:1}   # new(size) etc.
NA={"RegOpenKeyExA":5,"RegQueryValueExA":6,"RegCloseKey":1,"GetWindowsDirectoryA":2,
 "GetVolumeInformationA":8,"GetLogicalDriveStringsA":2,"MessageBoxA":4,"GlobalAlloc":2,
 "HeapAlloc":3,"GetModuleFileNameA":3,"LoadLibraryA":1,"GetProcAddress":2,
 "GetTickCount":0,"GetLastError":0,"SetLastError":1,"lstrlenA":1,"CloseHandle":1,
 "GetVersion":0,"MultiByteToWideChar":6,"WideCharToMultiByte":8,"CreateFileA":7,
 "GetFileAttributesA":1,"VirtualAlloc":4,"VirtualFree":3,"TlsAlloc":0,"TlsFree":1,
 "TlsSetValue":2,"TlsGetValue":1,"InitializeCriticalSection":1,"GetCurrentThreadId":0,
 "FindResourceExA":4,"LoadResource":2,"LoadStringA":4,"SendMessageA":4,"GlobalFree":1}

def hook(mu,addr,size,user):
    # stub operator new / free inside the image
    if addr==0x100f7006 or addr==0x100f7320:
        esp=mu.reg_read(UC_X86_REG_ESP)
        ret=struct.unpack('<I',mu.mem_read(esp,4))[0]
        sz=struct.unpack('<I',mu.mem_read(esp+4,4))[0]
        r=alloc(sz)
        calls.append(f"operator new({sz}) -> {r:#x}")
        mu.reg_write(UC_X86_REG_EAX,r)
        mu.reg_write(UC_X86_REG_ESP,esp+8)
        mu.reg_write(UC_X86_REG_EIP,ret)
        return
    if 0x70000000<=addr<0x70080000:
        name=slot2name.get(addr)
        esp=mu.reg_read(UC_X86_REG_ESP)
        ret=struct.unpack('<I',mu.mem_read(esp,4))[0]
        if name is None:
            calls.append(f"(unknown thunk {addr:#x}) -> 0")
            mu.reg_write(UC_X86_REG_EAX,0); mu.reg_write(UC_X86_REG_EIP,ret); return
        na=NA.get(name,0)
        args=[struct.unpack('<I',mu.mem_read(esp+4+4*i,4))[0] for i in range(na)]
        r=0
        if name=="RegOpenKeyExA":
            if na>=5: mu.mem_write(args[4],struct.pack('<I',0x1234))
            calls.append(f"RegOpenKeyExA(hive={args[0]:#x}, key={cstr(args[1])!r}, sub={cstr(args[2])!r})")
        elif name=="RegQueryValueExA":
            vn=cstr(args[1]); calls.append(f"  RegQueryValueExA(value={vn!r})")
            v=REG.get(vn)
            if v:
                mu.mem_write(args[3],struct.pack('<I',1))   # lpType = REG_SZ
                mu.mem_write(args[4],v)                     # lpData
                mu.mem_write(args[5],struct.pack('<I',len(v)))# lpcbData
                r=0
            else:
                r=2
        elif name=="GetWindowsDirectoryA":
            mu.mem_write(args[0],b'C:\\WINDOWS\0'); r=10
            calls.append("GetWindowsDirectoryA -> 'C:\\WINDOWS'")
        elif name=="GetVolumeInformationA":
            mu.mem_write(args[1],b'STEINBERG\0')
            mu.mem_write(args[3],struct.pack('<I',0x464c14dc))
            mu.mem_write(args[5],struct.pack('<I',0))
            mu.mem_write(args[6],b'FAT32\0'); r=1
            calls.append("GetVolumeInformationA -> ok")
        elif name=="MessageBoxA":
            calls.append(f"*** MSGBOX title={cstr(args[1])!r} text={cstr(args[2])!r}"); r=1
        elif name in ("GlobalAlloc","HeapAlloc","VirtualAlloc"):
            r=alloc(args[1] if na>1 else 0x1000)
        elif name=="GetModuleFileNameA":
            p=b'C:\\VST\\LM4-MarkII.dll\0'; mu.mem_write(args[1],p); r=len(p)-1
        elif name=="LoadLibraryA": r=0x70010000
        elif name=="lstrlenA": r=len(cstr(args[0]))
        elif name=="GetTickCount": r=12345
        elif name in ("CloseHandle",): r=1
        mu.reg_write(UC_X86_REG_EAX,r&0xffffffff)
        mu.reg_write(UC_X86_REG_ESP,esp+4+4*na)
        mu.reg_write(UC_X86_REG_EIP,ret)
        return

mu.hook_add(UC_HOOK_CODE,hook)

esp=0x500ff000
# ---- 1) base ctor: builds CRC table ----
print("=== 1) base ctor 0x1001e2f0 ===")
mu.mem_write(esp,struct.pack('<I',0x7fff0000))
mu.reg_write(UC_X86_REG_ESP,esp)
try:
    mu.emu_start(0x1001e2f0,0x7fff0000,count=10_000_000,timeout=60*1000*1000)
except UcError as e: print("  err",e,hex(mu.reg_read(UC_X86_REG_EIP)))
print("  CRC table @0x10109700:",bytes(mu.mem_read(0x10109700,16)).hex())
print("  table @0x10109300    :",bytes(mu.mem_read(0x10109300,16)).hex())

# ---- 2) ctor ----
obj=alloc(0x1000)
print("=== 2) ctor 0x1001e5f0 (ecx=obj) ===")
mu.mem_write(esp,struct.pack('<I',0x7fff0000))
mu.mem_write(esp+4,struct.pack('<I',0x10188120))   # "Software\Steinberg\LM4-MarkII"
mu.reg_write(UC_X86_REG_ESP,esp)
mu.reg_write(UC_X86_REG_ECX,obj)
try:
    mu.emu_start(0x1001e5f0,0x7fff0000,count=10_000_000,timeout=60*1000*1000)
except UcError as e: print("  err",e,hex(mu.reg_read(UC_X86_REG_EIP)))
print("  key @0x10109680:",bytes(mu.mem_read(0x10109680,24)).hex())
print("  obj[0..0x10]  :",bytes(mu.mem_read(obj,0x10)).hex())

# ---- 3) protection check ----
print("=== 3) protection check 0x1001e6c0 (ecx=obj) ===")
mu.mem_write(esp,struct.pack('<I',0x7fff0000))
mu.reg_write(UC_X86_REG_ESP,esp)
mu.reg_write(UC_X86_REG_ECX,obj)
try:
    mu.emu_start(0x1001e6c0,0x7fff0000,count=50_000_000,timeout=120*1000*1000)
except UcError as e: print("  err",e,"EIP",hex(mu.reg_read(UC_X86_REG_EIP)))
rv=mu.reg_read(UC_X86_REG_EAX)
print("  >>> returns",hex(rv),"(0=FAIL / 1=PASS)")
print()
print("---- calls ----")
for c in calls: print("  ",c)
