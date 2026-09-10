import struct
from unicorn import *
from unicorn.x86_const import *
import capstone

FILE='LM4-MarkII.dll'
data=open(FILE,'rb').read()
pe=struct.unpack_from('<I',data,0x3c)[0]
nsec=struct.unpack_from('<H',data,pe+6)[0]; optsz=struct.unpack_from('<H',data,pe+20)[0]
opt=pe+24
IMGBASE=struct.unpack_from('<I',data,opt+28)[0]; IMGSIZE=struct.unpack_from('<I',data,opt+56)[0]
ENTRY=struct.unpack_from('<I',data,opt+16)[0]
SO=pe+24+optsz

mu=Uc(UC_ARCH_X86,UC_MODE_32)
mu.mem_map(IMGBASE,(IMGSIZE+0x200000+0xfff)&~0xfff)
for i in range(nsec):
    o=SO+i*40
    vs,va,rs,ra=struct.unpack_from('<IIII',data,o+8)
    if rs: mu.mem_write(IMGBASE+va,data[ra:ra+rs])
    if vs>rs: mu.mem_write(IMGBASE+va+rs,b'\0'*(vs-rs))
mu.mem_write(IMGBASE,data[:0x8000])
mu.mem_map(0x50000000,0x200000)    # stack
mu.mem_map(0x30000000,0x10000000)  # heap
mu.mem_map(0x70000000,0x80000)     # api thunks
mu.mem_map(0x40000000,0x100000)    # file view
mu.mem_write(0x40000000,data)

# name -> (nargs, restype)
APIS = {
 "LoadLibraryA":(1,0x70010000),
 "GetProcAddress":(2,-1),          # special
 "GetModuleHandleA":(1,IMGBASE),
 "GetModuleFileNameA":(3,-2),
 "CreateFileA":(7,0x5678),
 "CreateFileMappingA":(6,0x1234),
 "MapViewOfFile":(5,0x40000000),
 "UnmapViewOfFile":(1,1),
 "CloseHandle":(1,1),
 "VirtualProtect":(4,-3),
 "GetCurrentProcess":(0,0xffffffff),
 "FlushInstructionCache":(3,1),
 "GlobalAlloc":(2,-4),
 "GlobalFree":(1,0),
 "LocalAlloc":(2,-4),
 "LocalFree":(1,0),
 "HeapAlloc":(3,-4),
 "HeapCreate":(3,0x30000000),
 "HeapDestroy":(1,1),
 "ExitProcess":(1,-9),
 "MessageBoxA":(4,-9),
 "wsprintfA":(0,0),
 "GetLogicalDriveStringsA":(2,-5),
 "GetDriveTypeA":(1,3),
 "GetVolumeInformationA":(8,1),
 "GetLastError":(0,0),
 "SetLastError":(1,0),
 "Sleep":(1,0),
 "GetTickCount":(0,12345),
 "QueryPerformanceCounter":(1,1),
 "QueryPerformanceFrequency":(1,1),
 "GetVersion":(0,0x0a280105),
 "GetVersionExA":(1,1),
 "GetSystemInfo":(1,0),
 "GetSystemDirectoryA":(2,-5),
 "GetWindowsDirectoryA":(2,-5),
 "GetTempPathA":(2,-5),
 "SetFilePointer":(4,0),
 "SetEndOfFile":(1,1),
 "GetFileSize":(2,0),
 "ReadFile":(5,-6),
 "WriteFile":(5,-6),
 "DeleteFileA":(1,1),
 "CreateDirectoryA":(2,1),
 "FindFirstFileA":(2,-1),
 "FindNextFileA":(2,0),
 "FindClose":(1,1),
 "GetFileAttributesA":(1,0x20),
 "MultiByteToWideChar":(6,0),
 "WideCharToMultiByte":(8,0),
 "lstrlenA":(1,0),
 "lstrcpyA":(2,0),
 "lstrcatA":(2,0),
 "GetModuleHandleW":(1,IMGBASE),
 "LoadLibraryW":(1,0x70010000),
 "RegOpenKeyExA":(5,2),
 "RegQueryValueExA":(6,2),
 "RegCloseKey":(1,0),
 "RegSetValueExA":(6,0),
 "RegDeleteKeyA":(2,0),
 "RegDeleteValueA":(2,0),
 "RegEnumKeyExA":(8,259),
 "GetOpenFileNameA":(1,1),
 "GetSaveFileNameA":(1,1),
 "CommDlgExtendedError":(0,0),
 "GetDlgItem":(2,0x100),
 "SetDlgItemTextA":(3,1),
 "GetDlgItemTextA":(4,1),
 "SendDlgItemMessageA":(5,0),
 "SendMessageA":(4,0),
 "PostMessageA":(4,1),
 "SetBkColor":(2,0),
 "SetTextColor":(2,0),
 "CreateCompatibleDC":(1,0x1000),
 "CreateCompatibleBitmap":(3,0x1000),
 "SelectObject":(2,0x1000),
 "DeleteObject":(1,1),
 "DeleteDC":(1,1),
 "GetObjectA":(3,0),
 "GetStockObject":(1,0x1000),
 "CreateFontA":(14,0x1000),
 "TextOutA":(5,1),
 "BitBlt":(9,1),
 "StretchBlt":(11,1),
 "SetStretchBltMode":(2,1),
 "GetDIBits":(7,1),
 "SetDIBitsToDevice":(12,1),
 "ShellExecuteA":(6,42),
 "SHGetFileInfoA":(5,1),
 "OleInitialize":(1,0),
 "CoInitialize":(1,0),
 "RevokeDragDrop":(1,0),
 "RegCreateKeyExA":(9,0),
 "InitCommonControls":(0,0),
 "GetSystemMetrics":(1,0),
 "ScreenToClient":(2,1),
 "ClientToScreen":(2,1),
 "GetClientRect":(2,1),
 "InvalidateRect":(3,1),
 "UpdateWindow":(1,1),
 "BeginPaint":(2,0x1000),
 "EndPaint":(2,1),
 "GetDC":(1,0x1000),
 "ReleaseDC":(2,1),
 "SetTimer":(4,1),
 "KillTimer":(2,1),
 "GetKeyState":(1,0),
 "GetAsyncKeyState":(1,0),
 "timeGetTime":(0,1234),
 "midiOutOpen":(5,0),
 "midiOutClose":(1,0),
 "midiOutShortMsg":(2,0),
 "midiOutLongMsg":(2,0),
 "midiOutGetNumDevs":(0,1),
 "midiOutGetDevCapsA":(3,0),
 "timeGetDevCaps":(2,0),
 "timeBeginPeriod":(1,0),
 "timeEndPeriod":(1,0),
 "CreateThread":(6,0x1000),
 "GetExitCodeThread":(2,1),
 "WaitForSingleObject":(2,0),
 "SetEvent":(1,1),
 "CreateEventA":(4,0x1000),
 "InitializeCriticalSection":(1,0),
 "EnterCriticalSection":(1,0),
 "LeaveCriticalSection":(1,0),
 "DeleteCriticalSection":(1,0),
 "InterlockedIncrement":(1,1),
 "InterlockedDecrement":(1,0),
 "InterlockedExchange":(2,0),
 "GetCurrentThreadId":(0,1),
 "TlsAlloc":(0,1),
 "TlsFree":(1,1),
 "TlsSetValue":(2,1),
 "TlsGetValue":(1,0),
 "RtlUnwind":(4,0),
 "RaiseException":(4,-9),
 "SetUnhandledExceptionFilter":(1,0),
 "UnhandledExceptionFilter":(1,1),
 "GetStartupInfoA":(1,0),
 "_lclose":(1,0),
 "_lopen":(2,0),
 "_lread":(3,0),
 "_lwrite":(3,0),
 "_llseek":(3,0),
 "memcpy":(3,0),
 "memset":(3,0),
 "malloc":(1,-4),
 "free":(1,0),
}

api_slots={}
for i,(n,v) in enumerate(APIS.items()):
    api_slots[0x70000000+i*16]=n
NAME2ADDR={n:a for a,n in api_slots.items()}

IAT={0x102a80a0:"LoadLibraryA",0x102a80a4:"GetProcAddress",
     0x102a80ac:"GetDlgItem",0x102a80b4:"SetBkColor",
     0x102a80bc:"GetOpenFileNameA",0x102a80c4:"RegCreateKeyExA",
     0x102a80cc:"ShellExecuteA",0x102a80d4:"RevokeDragDrop"}
for va,n in IAT.items():
    if n in NAME2ADDR: mu.mem_write(va,struct.pack('<I',NAME2ADDR[n]))

def rc(a,mx=260):
    if not (0x1000<a<0x80000000): return b''
    try:
        out=b''
        for i in range(mx):
            c=mu.mem_read(a+i,1)[0]
            if c==0: break
            out+=bytes([c])
        return out
    except: return b''

def wstr(a,mx=260):
    if not (0x1000<a<0x80000000): return b''
    try:
        out=b''
        for i in range(mx):
            c=mu.mem_read(a+i*2,2)
            if c==b'\0\0': break
            out+=c
        return out.decode('utf-16-le','replace').encode('latin-1','replace')
    except: return b''

halloc=[0x30010000]
ev=[]
LZ1=IMGBASE+0x2a8fd2

def hook(mu,addr,size,user):
    if addr==LZ1:
        eax=mu.reg_read(UC_X86_REG_EAX); edx=mu.reg_read(UC_X86_REG_EDX)
        ebx=mu.reg_read(UC_X86_REG_EBX); ecx=mu.reg_read(UC_X86_REG_ECX)
        ev.append("LZ1 src=%#x dst=%#x size=%#x win=%#x"%(eax,edx,ebx,ecx))
        return
    if 0x70000000<=addr<0x70080000:
        name=api_slots.get(addr)
        if name is None:
            ev.append("UNKNOWN THUNK %#x"%addr); mu.emu_stop(); return
        na,rt=APIS[name]
        esp=mu.reg_read(UC_X86_REG_ESP)
        ret=struct.unpack('<I',mu.mem_read(esp,4))[0]
        args=[struct.unpack('<I',mu.mem_read(esp+4+4*i,4))[0] for i in range(na)]
        s=[rc(a) for a in args]
        w=[wstr(a) for a in args]
        r=0
        if name=="GetProcAddress":
            key=s[1].decode('latin-1','replace')
            r=NAME2ADDR.get(key,0)
            if r==0:
                # auto-register unknown proc so we can keep going
                slot=0x70000000+len(api_slots)*16
                api_slots[slot]=key; NAME2ADDR[key]=slot
                APIS[key]=(0,0)
                r=slot
                ev.append("AUTO-PROC %s"%key)
        elif rt==-2:   # GetModuleFileNameA
            p=b'C:\\VST\\LM4-MarkII.dll\0'
            try: mu.mem_write(args[1],p)
            except: pass
            r=len(p)-1
        elif rt==-3:   # VirtualProtect
            if len(args)>3:
                try: mu.mem_write(args[3],struct.pack('<I',0x40))
                except: pass
            r=1
        elif rt==-4:   # alloc
            sz=args[1] if len(args)>1 else 0x1000
            r=halloc[0]; halloc[0]=(r+((sz+0xffff)&~0xffff))
        elif rt==-5:   # returns string
            if name=="GetLogicalDriveStringsA":
                st=b'C:\\\0\0'
                try: mu.mem_write(args[1],st)
                except: pass
                r=len(st)
            else:
                st=b'C:\\WINDOWS\0'
                try: mu.mem_write(args[1],st)
                except: pass
                r=len(st)
        elif rt==-6:   # ReadFile/WriteFile
            try: mu.mem_write(args[3],struct.pack('<I',0))
            except: pass
            r=0
        elif rt==-9:
            ev.append("%s %s"%(name, [x for x in (s[0],s[1]) if x]))
            mu.emu_stop(); return
        else:
            r=rt
        if name in ("ExitProcess","MessageBoxA","RaiseException"):
            ev.append("%s args=%s"%(name,s))
            mu.emu_stop(); return
        mu.reg_write(UC_X86_REG_EAX,r&0xffffffff)
        mu.reg_write(UC_X86_REG_ESP,esp+4+4*na)
        mu.reg_write(UC_X86_REG_EIP,ret)
        return

mu.hook_add(UC_HOOK_CODE,hook)

esp=0x500ff000
mu.mem_write(esp-12,struct.pack('<IIII',0x7fff0000,IMGBASE,1,0))
mu.reg_write(UC_X86_REG_ESP,esp-12)

PACKLO=IMGBASE+0x2a8000; PACKHI=IMGBASE+0x2b0000
state={'oep':None}
def hook2(mu,addr,size,user):
    if 0x70000000<=addr<0x70080000: return
    if not (PACKLO<=addr<PACKHI):
        state['oep']=addr
        ev.append("LEFT PACKER -> %#x"%addr)
        mu.emu_stop()
mu.hook_add(UC_HOOK_CODE,hook2)

try:
    mu.emu_start(IMGBASE+ENTRY,0x7fff0000,count=6_000_000_000,timeout=3000*1000*1000)
except UcError as e:
    print("UC ERROR:",e,"EIP=%#x"%mu.reg_read(UC_X86_REG_EIP))

print("final EIP %#x"%mu.reg_read(UC_X86_REG_EIP))
print("---- events (%d) ----"%len(ev))
for e in ev[-60:]: print("  ",e)
print("OEP:", state['oep'] and hex(state['oep']))
img=bytes(mu.mem_read(IMGBASE,IMGSIZE))
open('unpacked2.bin','wb').write(img)
print("wrote unpacked2.bin",len(img))
