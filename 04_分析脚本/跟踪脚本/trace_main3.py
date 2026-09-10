import struct, re
from unicorn import *
from unicorn.x86_const import *
import capstone

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
mu.mem_map(0x80000000,0x100000)     # host callback
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

calls=[]; scratch=[0x40010000]
def alloc(n):
    n=max(n,0x40); p=scratch[0]; scratch[0]=(p+n+0xfff)&~0xfff
    mu.mem_write(p,b'\0'*((n+0xfff)&~0xfff)); return p

NA={"RegOpenKeyExA":5,"RegQueryValueExA":6,"RegCloseKey":1,"GetWindowsDirectoryA":2,
 "GetVolumeInformationA":8,"GetLogicalDriveStringsA":2,"MessageBoxA":4,"GlobalAlloc":2,
 "HeapAlloc":3,"GetModuleFileNameA":3,"LoadLibraryA":1,"GetProcAddress":2,
 "GetTickCount":0,"GetLastError":0,"SetLastError":1,"lstrlenA":1,"CloseHandle":1,
 "GetVersion":0,"MultiByteToWideChar":6,"WideCharToMultiByte":8,"CreateFileA":7,
 "GetFileAttributesA":1,"VirtualAlloc":4,"VirtualFree":3,"TlsAlloc":0,"TlsFree":1,
 "TlsSetValue":2,"TlsGetValue":1,"InitializeCriticalSection":1,"GetCurrentThreadId":0,
 "FindResourceExA":4,"LoadResource":2,"LoadStringA":4,"SendMessageA":4,"GlobalFree":1,
 "GlobalLock":1,"GlobalUnlock":1,"GlobalSize":1,"GetStartupInfoA":1,"GetCommandLineA":0,
 "GetCurrentProcess":0,"GetACP":0,"GetCPInfo":2,"IsBadReadPtr":2,"IsBadWritePtr":2,
 "HeapCreate":3,"HeapDestroy":1,"HeapFree":3,"HeapReAlloc":4,"InterlockedIncrement":1,
 "InterlockedDecrement":1,"CreateEventA":4,"SetEvent":1,"WaitForSingleObject":2,
 "EnterCriticalSection":1,"LeaveCriticalSection":1,"DeleteCriticalSection":1,
 "TlsFree2":1,"ExitProcess":1,"GetModuleHandleA":1,"RegSetValueExA":6,
 "RegCreateKeyExA":9,"LoadCursorA":2,"LoadBitmapA":2,"GetSysColorBrush":1,
 "RegisterClassA":1,"UnregisterClassA":2,"CreateWindowExA":12,"DestroyWindow":1,
 "GetDC":1,"ReleaseDC":2,"BeginPaint":2,"EndPaint":2,"GetClientRect":2,
 "InvalidateRect":3,"UpdateWindow":1,"SetTimer":4,"KillTimer":2,"PeekMessageA":5,
 "DispatchMessageA":1,"DefWindowProcA":4,"SetWindowLongA":3,"GetWindowLongA":2,
 "CallWindowProcA":5,"GetParent":1,"GetDlgItem":2,"SetFocus":1,"GetFocus":0,
 "ShowWindow":2,"SetWindowTextA":2,"GetWindowTextA":3,"GetWindowRect":2,
 "ScreenToClient":2,"ClientToScreen":2,"GetAsyncKeyState":1,"GetCursorPos":1,
 "SetCursor":1,"GetCursor":0,"LoadIconA":2,"SendMessageA2":4}

def hook(mu,addr,size,user):
    # internal operator new / delete / string helpers
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
            calls.append(f"RegOpenKeyExA({cstr(args[1])!r})")
        elif name=="RegQueryValueExA":
            vn=cstr(args[1]); calls.append(f"  query {vn!r}")
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
            calls.append(f"*** MSGBOX {cstr(args[1])!r} | {cstr(args[2])!r}"); r=1
        elif name in ("GlobalAlloc","HeapAlloc","VirtualAlloc"): r=alloc(args[1] if na>1 else 0x1000)
        elif name=="GetModuleFileNameA":
            p=b'C:\\VST\\LM4-MarkII.dll\0'; mu.mem_write(args[1],p); r=len(p)-1
        elif name=="LoadLibraryA": r=0x70010000
        elif name=="lstrlenA": r=len(cstr(args[0]))
        elif name=="GetTickCount": r=12345
        elif name=="GetCommandLineA": r=0x40015000
        elif name=="GetModuleHandleA": r=IB
        elif name in ("CloseHandle",): r=1
        elif name=="GetACP": r=1252
        mu.reg_write(UC_X86_REG_EAX,r&0xffffffff)
        mu.reg_write(UC_X86_REG_ESP,esp+4+4*na)
        mu.reg_write(UC_X86_REG_EIP,ret)
        return
    if addr==HOSTCB:
        esp=mu.reg_read(UC_X86_REG_ESP)
        ret=struct.unpack('<I',mu.mem_read(esp,4))[0]
        op=struct.unpack('<I',mu.mem_read(esp+8,4))[0]
        if op==1:   # audioMasterVersion
            r=2400
        else:
            r=0
        calls.append(f"audioMaster(opcode={op}) -> {r}")
        mu.reg_write(UC_X86_REG_EAX,r)
        mu.reg_write(UC_X86_REG_ESP,esp+4+6*4)
        mu.reg_write(UC_X86_REG_EIP,ret)
        return

HOSTCB=0x80000000
mu.hook_add(UC_HOOK_CODE,hook)

md=capstone.Cs(capstone.CS_ARCH_X86,capstone.CS_MODE_32)
tr=[]
def hooktr(mu,addr,size,user):
    if 0x70000000<=addr<0x70080000 or addr==HOSTCB: return
    tr.append(addr)
    if len(tr)>6000: tr.pop(0)
mu.hook_add(UC_HOOK_CODE,hooktr)

esp=0x500ff000
mu.mem_write(esp,struct.pack('<I',0x7fff0000))
mu.mem_write(esp+4,struct.pack('<I',HOSTCB))
mu.reg_write(UC_X86_REG_ESP,esp)

print("=== main() ===")
try:
    mu.emu_start(0x1001b8e0,0x7fff0000,count=1_000_000_000,timeout=900*1000*1000)
except UcError as e:
    print("UC ERROR:",e,"EIP=%#x"%mu.reg_read(UC_X86_REG_EIP))
rv=mu.reg_read(UC_X86_REG_EAX)
print("main() ->",hex(rv))
print()
print("--- last 40 exec ---")
for a in tr[-40:]:
    try:
        ins=next(md.disasm(bytes(mu.mem_read(a,16)),a))
        print(f"{a:#010x}  {ins.mnemonic:8} {ins.op_str}")
    except: print(f"{a:#010x} ??")
print()
print("--- calls ---")
for c in calls: print("  ",c)
