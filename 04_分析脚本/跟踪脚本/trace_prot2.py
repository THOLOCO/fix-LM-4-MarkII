import struct, re
from unicorn import *
from unicorn.x86_const import *

img=open('unpacked2.bin','rb').read()
IB=0x10000000

# ---- rebuild thunk addr -> api name (same order emu7.py used) ----
src=open('emu7.py').read()
m=re.search(r'APIS = \{(.*?)\n\}', src, re.S)
entries=re.findall(r'"([A-Za-z_0-9]+)":\(', m.group(1))
auto=re.findall(r'AUTO-PROC (\S+)', open('emu7.out').read())
thunk2name={}
for i,n in enumerate(entries): thunk2name[0x70000000+i*16]=n
base=0x70000000+len(entries)*16
for i,n in enumerate(auto): thunk2name[base+i*16]=n

mu=Uc(UC_ARCH_X86,UC_MODE_32)
mu.mem_map(IB,0x300000); mu.mem_write(IB,img)
mu.mem_map(0x50000000,0x200000)
mu.mem_map(0x60000000,0x1000000)
mu.mem_map(0x70000000,0x80000)

NARGS={"RegOpenKeyExA":5,"RegQueryValueExA":6,"RegCloseKey":1,"RegCreateKeyExA":9,
 "RegSetValueExA":6,"GetWindowsDirectoryA":2,"GetVolumeInformationA":8,
 "GetLogicalDriveStringsA":2,"GetFileAttributesA":1,"CreateFileA":7,"FindFirstFileA":2,
 "FindNextFileA":2,"FindClose":1,"GetModuleFileNameA":3,"LoadLibraryA":1,
 "GetProcAddress":2,"MessageBoxA":4,"GlobalAlloc":2,"LocalAlloc":2,"HeapAlloc":3,
 "MultiByteToWideChar":6,"WideCharToMultiByte":8,"SetLastError":1,"GetLastError":0,
 "Sleep":1,"GetTickCount":0,"CloseHandle":1,"lstrlenA":1,"LoadStringA":4,
 "FindResourceExA":4,"LoadResource":2,"GetVersion":0,"GetCurrentThreadId":0,
 "TlsAlloc":0,"TlsFree":1,"TlsSetValue":2,"TlsGetValue":1,"InitializeCriticalSection":1,
 "EnterCriticalSection":1,"LeaveCriticalSection":1,"DeleteCriticalSection":1,
 "CreateEventA":4,"SetEvent":1,"WaitForSingleObject":2,"CreateThread":6,
 "InterlockedIncrement":1,"InterlockedDecrement":1,"GetStartupInfoA":1,"ExitProcess":1,
 "GetCurrentProcess":0,"FlushInstructionCache":3,"VirtualAlloc":4,"VirtualFree":3,
 "GetFileTime":2,"CompareFileTime":2,"SetFilePointer":4,"SetEndOfFile":1,"ReadFile":5,
 "WriteFile":5,"GetFileSize":2,"CreateDirectoryA":2,"DeleteFileA":1,"GetTempPathA":2,
 "OpenFile":3,"_lclose":1,"GlobalFree":1,"GlobalLock":1,"GlobalUnlock":1,"GlobalSize":1,
 "GlobalMemoryStatus":1,"CreateFileMappingA":6,"MapViewOfFile":5,"UnmapViewOfFile":1,
 "HeapFree":3,"HeapReAlloc":4,"GetSysColorBrush":1,"RegisterClassA":1,"DispatchMessageA":1,
 "GetClipboardData":1,"EmptyClipboard":0,"SetClipboardData":2,"OpenClipboard":1,
 "CloseClipboard":0,"IsClipboardFormatAvailable":1,"SetCursor":1,"GetCursor":0,
 "SetMapMode":2,"CreateFontIndirectA":1,"DPtoLP":3,"CreateSolidBrush":1,"GetMapMode":1,
 "CreateBitmap":5,"GetCurrentObject":2,"MoveToEx":4,"SetBkMode":2,"LineTo":3,"Arc":9,
 "CreatePenIndirect":1,"GetTextExtentPoint32A":3,"CreateBrushIndirect":1,
 "FindExecutableA":3,"DragQueryFileA":4,"CoCreateInstance":5,"OleUninitialize":0,
 "RegisterDragDrop":2,"LoadBitmapA":2,"FillRect":2,"DrawTextA":5,"UnregisterClassA":2,
 "GetDoubleClickTime":0,"SetWindowLongA":3,"SetFocus":1,"CreateWindowExA":12,
 "GetWindowTextA":3,"DestroyWindow":1,"GetWindowRect":2,"TrackPopupMenu":7,
 "AppendMenuA":4,"DestroyMenu":1,"CreatePopupMenu":0,"PeekMessageA":5,"GetWindowLongA":2,
 "CallWindowProcA":5,"GetParent":1,"GetDlgItem":2,"SendMessageA":4,"PostMessageA":4,
 "GetAsyncKeyState":1,"GetCursorPos":1,"SetWindowTextA":2,"LoadCursorA":2,
 "GetUpdateRect":3,"DefWindowProcA":4,"SetBkColor":2,"SetTextColor":2,"DeleteObject":1,
 "GetObjectA":3,"DeleteDC":1,"SelectObject":2,"CreateCompatibleDC":1,
 "CreateCompatibleBitmap":3,"BitBlt":9,"GetStockObject":1,"ShellExecuteA":6,
 "GetOpenFileNameA":1,"GetSaveFileNameA":1,"OleInitialize":1,"RevokeDragDrop":1,
 "DeleteCriticalSection":1}

calls=[]
def cstr(a,mx=260):
    try:
        o=b''
        for i in range(mx):
            c=mu.mem_read(a+i,1)[0]
            if c==0: break
            o+=bytes([c])
        return o.decode('latin-1','replace')
    except: return ''

def hook(mu,addr,size,user):
    if 0x70000000<=addr<0x70080000:
        name=thunk2name.get(addr)
        if name is None:
            # unknown thunk -> just return 0
            esp=mu.reg_read(UC_X86_REG_ESP)
            ret=struct.unpack('<I',mu.mem_read(esp,4))[0]
            mu.reg_write(UC_X86_REG_EAX,0)
            mu.reg_write(UC_X86_REG_EIP,ret)
            return
        na=NARGS.get(name,0)
        esp=mu.reg_read(UC_X86_REG_ESP)
        ret=struct.unpack('<I',mu.mem_read(esp,4))[0]
        args=[struct.unpack('<I',mu.mem_read(esp+4+4*i,4))[0] for i in range(na)]
        r=0
        if name=="RegOpenKeyExA":
            calls.append(f"RegOpenKeyExA(root={args[0]:#x}, key={cstr(args[1])!r}, sub={cstr(args[2])!r})")
            r=0
        elif name=="RegQueryValueExA":
            calls.append(f"  RegQueryValueExA(value={cstr(args[1])!r}, type={args[3]:#x})")
            r=2
        elif name=="RegCloseKey": r=0
        elif name=="GetWindowsDirectoryA":
            p=b'C:\\WINDOWS\0'
            try: mu.mem_write(args[0],p)
            except: pass
            r=len(p)-1
            calls.append(f"GetWindowsDirectoryA -> {cstr(args[0])!r}")
        elif name=="GetVolumeInformationA":
            try:
                mu.mem_write(args[1],b'STEINBERG\0')
                mu.mem_write(args[3],struct.pack('<I',0x464c14dc))
                mu.mem_write(args[5],struct.pack('<I',0))
                mu.mem_write(args[6],b'FAT32\0')
            except: pass
            r=1
            calls.append(f"GetVolumeInformationA(root={cstr(args[0])!r}) -> serial 0x464c14dc")
        elif name=="GetLogicalDriveStringsA":
            try: mu.mem_write(args[1],b'C:\\\0\0')
            except: pass
            r=4
            calls.append("GetLogicalDriveStringsA -> 'C:\\'")
        elif name=="GetFileAttributesA":
            calls.append(f"GetFileAttributesA({cstr(args[0])!r})")
            r=0xFFFFFFFF
        elif name=="CreateFileA":
            calls.append(f"CreateFileA({cstr(args[0])!r})")
            r=0xFFFFFFFF
        elif name=="GetModuleFileNameA":
            p=b'C:\\VST\\LM4-MarkII.dll\0'
            try: mu.mem_write(args[1],p)
            except: pass
            r=len(p)-1
        elif name=="LoadLibraryA": r=0x70010000
        elif name=="GetProcAddress": r=0
        elif name in ("GlobalAlloc","LocalAlloc","HeapAlloc"):
            r=0x60000000+0x20000*len(calls)
            try: mu.mem_write(r,b'\0'*0x20000)
            except: pass
        elif name=="MessageBoxA":
            calls.append(f"*** MessageBoxA({cstr(args[1])!r} | {cstr(args[2])!r})")
            r=1
        elif name=="GetVersion": r=0x0a280105
        elif name=="GetTickCount": r=12345
        elif name=="GetLastError": r=0
        elif name in ("CloseHandle","DeleteFileA","FindClose"): r=1
        elif name=="lstrlenA": r=len(cstr(args[0]))
        else: r=0
        mu.reg_write(UC_X86_REG_EAX,r&0xffffffff)
        mu.reg_write(UC_X86_REG_ESP,esp+4+4*na)
        mu.reg_write(UC_X86_REG_EIP,ret)
        return

mu.hook_add(UC_HOOK_CODE,hook)

obj=0x60080000
mu.mem_write(obj,b'\0'*0x3000)
esp=0x500ff000
mu.mem_write(esp,struct.pack('<I',0x7fff0000))
mu.reg_write(UC_X86_REG_ESP,esp)
mu.reg_write(UC_X86_REG_ECX,obj)

print("=== calling 0x1001e6c0 (protection check) ===")
try:
    mu.emu_start(0x1001e6c0,0x7fff0000,count=500_000_000,timeout=600*1000*1000)
except UcError as e:
    print("UC ERROR:",e,"EIP=%#x"%mu.reg_read(UC_X86_REG_EIP))
print("EAX =",hex(mu.reg_read(UC_X86_REG_EAX)),"(0=FAIL, 1=PASS)")
print()
print("---- API calls ----")
for c in calls: print(" ",c)
