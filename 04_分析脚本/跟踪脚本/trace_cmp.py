import struct
from unicorn import *
from unicorn.x86_const import *

img=open('unpacked2.bin','rb').read()
IB=0x10000000
thunk2name={}
for line in open('thunkmap.txt'):
    a,n=line.split(None,1); thunk2name[int(a,16)]=n.strip()

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
def cstr(a,mx=200):
    try:
        o=b''
        for i in range(mx):
            c=mu.mem_read(a+i,1)[0]
            if c==0: break
            o+=bytes([c])
        return o.decode('latin-1','replace')
    except: return ''

scratch=[0x40010000]
def alloc(n):
    n=max(n,0x40); p=scratch[0]; scratch[0]=(p+n+0xfff)&~0xfff
    mu.mem_write(p,b'\0'*((n+0xfff)&~0xfff)); return p

NA={"RegOpenKeyExA":5,"RegQueryValueExA":6,"RegCloseKey":1,"GetWindowsDirectoryA":2,
 "GetVolumeInformationA":8,"MessageBoxA":4,"GlobalAlloc":2,"HeapAlloc":3,
 "GetModuleFileNameA":3,"LoadLibraryA":1,"GetProcAddress":2,"GetTickCount":0,
 "GetLastError":0,"SetLastError":1,"lstrlenA":1,"CloseHandle":1,"GetVersion":0,
 "MultiByteToWideChar":6,"WideCharToMultiByte":8,"CreateFileA":7,"GetFileAttributesA":1,
 "VirtualAlloc":4,"TlsAlloc":0,"TlsFree":1,"TlsSetValue":2,"TlsGetValue":1,
 "InitializeCriticalSection":1,"GetCurrentThreadId":0,"GlobalFree":1}

seen=[]
def hook(mu,addr,size,user):
    if addr in (0x100f7006,0x100f7320):
        esp=mu.reg_read(UC_X86_REG_ESP)
        ret=struct.unpack('<I',mu.mem_read(esp,4))[0]
        sz=struct.unpack('<I',mu.mem_read(esp+4,4))[0]
        r=alloc(sz)
        mu.reg_write(UC_X86_REG_EAX,r); mu.reg_write(UC_X86_REG_ESP,esp+4)
        mu.reg_write(UC_X86_REG_EIP,ret); return
    if addr==0x100f7014:
        esp=mu.reg_read(UC_X86_REG_ESP)
        ret=struct.unpack('<I',mu.mem_read(esp,4))[0]
        mu.reg_write(UC_X86_REG_EAX,0); mu.reg_write(UC_X86_REG_ESP,esp+4)
        mu.reg_write(UC_X86_REG_EIP,ret); return
    if 0x70000000<=addr<0x70080000:
        name=thunk2name.get(addr)
        esp=mu.reg_read(UC_X86_REG_ESP)
        ret=struct.unpack('<I',mu.mem_read(esp,4))[0]
        if name is None:
            mu.reg_write(UC_X86_REG_EAX,0); mu.reg_write(UC_X86_REG_EIP,ret); return
        na=NA.get(name,0)
        args=[struct.unpack('<I',mu.mem_read(esp+4+4*i,4))[0] for i in range(na)]
        r=0
        if name=="RegOpenKeyExA":
            if na>=5: mu.mem_write(args[4],struct.pack('<I',0x1234))
            seen.append(f"RegOpenKeyExA({cstr(args[1])!r})")
        elif name=="RegQueryValueExA":
            vn=cstr(args[1]); seen.append(f"  query {vn!r}")
            v=REG.get(vn)
            if v:
                mu.mem_write(args[3],struct.pack('<I',1))
                mu.mem_write(args[4],v)
                mu.mem_write(args[5],struct.pack('<I',len(v)))
                r=0
            else: r=2
        elif name=="GetWindowsDirectoryA":
            mu.mem_write(args[0],b'C:\\WINDOWS\0'); r=10
        elif name=="GetVolumeInformationA":
            mu.mem_write(args[1],b'STEINBERG\0')
            mu.mem_write(args[3],struct.pack('<I',0x464c14dc))
            mu.mem_write(args[5],struct.pack('<I',0))
            mu.mem_write(args[6],b'FAT32\0'); r=1
        elif name=="MessageBoxA":
            seen.append(f"*** MSGBOX {cstr(args[1])!r} | {cstr(args[2])!r}"); r=1
        elif name in ("GlobalAlloc","HeapAlloc","VirtualAlloc"): r=alloc(args[1] if na>1 else 0x1000)
        elif name=="GetModuleFileNameA":
            p=b'C:\\VST\\LM4-MarkII.dll\0'; mu.mem_write(args[1],p); r=len(p)-1
        elif name=="LoadLibraryA": r=0x70010000
        elif name=="lstrlenA": r=len(cstr(args[0]))
        elif name=="GetTickCount": r=12345
        mu.reg_write(UC_X86_REG_EAX,r&0xffffffff)
        mu.reg_write(UC_X86_REG_ESP,esp+4+4*na)
        mu.reg_write(UC_X86_REG_EIP,ret)
        return

# instrument the comparison
def hook2(mu,addr,size,user):
    if addr==0x1001eaa5:     # just after sprintf
        ebp=mu.reg_read(UC_X86_REG_EBP)
        buf_computed=bytes(mu.mem_read(ebp-0x84,64)).split(b'\0')[0]
        buf_reg=bytes(mu.mem_read(ebp-0x104,64)).split(b'\0')[0]
        seen.append(f"COMPARE computed=%r  registry(decrypted)=%r"%(buf_computed,buf_reg))
    if addr==0x1001e820:     # hash(obj)
        seen.append(f"hash(obj) called; obj[0:16]={bytes(mu.mem_read(mu.reg_read(UC_X86_REG_ECX),16)).hex()}")
mu.hook_add(UC_HOOK_CODE,hook)
mu.hook_add(UC_HOOK_CODE,hook2)

esp=0x500ff000
# base ctor
mu.mem_write(esp,struct.pack('<I',0x7fff0000)); mu.reg_write(UC_X86_REG_ESP,esp)
mu.emu_start(0x1001e2f0,0x7fff0000,count=10_000_000)
# main ctor
obj=alloc(0x1000)
mu.mem_write(esp,struct.pack('<I',0x7fff0000))
mu.mem_write(esp+4,struct.pack('<I',0x10188120))
mu.reg_write(UC_X86_REG_ESP,esp); mu.reg_write(UC_X86_REG_ECX,obj)
mu.emu_start(0x1001e5f0,0x7fff0000,count=10_000_000)
seen.append(f"obj[0:16] after ctor = {bytes(mu.mem_read(obj,16)).hex()}")
# check
mu.mem_write(esp,struct.pack('<I',0x7fff0000)); mu.reg_write(UC_X86_REG_ESP,esp)
mu.reg_write(UC_X86_REG_ECX,obj)
try:
    mu.emu_start(0x1001e6c0,0x7fff0000,count=200_000_000,timeout=300*1000*1000)
except UcError as e:
    seen.append(f"UC ERR {e} EIP={mu.reg_read(UC_X86_REG_EIP):#x}")
seen.append(f"check returned {mu.reg_read(UC_X86_REG_EAX):#x}")
for s in seen: print(s)
