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
mu.mem_map(0x50000000,0x200000)   # stack
mu.mem_map(0x30000000,0x10000000)  # heap
mu.mem_map(0x70000000,0x40000)    # api
mu.mem_map(0x40000000,0x100000)   # file view
mu.mem_write(0x40000000,data)

APIS=["LoadLibraryA","GetProcAddress","GetModuleHandleA","GetModuleFileNameA",
      "CreateFileA","CreateFileMappingA","MapViewOfFile","UnmapViewOfFile",
      "CloseHandle","VirtualProtect","GetCurrentProcess","FlushInstructionCache",
      "GlobalAlloc","GlobalFree","ExitProcess","MessageBoxA","wsprintfA",
      "GetDlgItem","SetBkColor","GetOpenFileNameA","RegCreateKeyExA",
      "ShellExecuteA","RevokeDragDrop"]
api_slots={}
for i,n in enumerate(APIS): api_slots[0x70000000+i*16]=n
NAME2ADDR={v:k for k,v in api_slots.items()}
IAT={0x102a80a0:"LoadLibraryA",0x102a80a4:"GetProcAddress",
     0x102a80ac:"GetDlgItem",0x102a80b4:"SetBkColor",
     0x102a80bc:"GetOpenFileNameA",0x102a80c4:"RegCreateKeyExA",
     0x102a80cc:"ShellExecuteA",0x102a80d4:"RevokeDragDrop"}
for va,n in IAT.items(): mu.mem_write(va,struct.pack('<I',NAME2ADDR[n]))

def rc(a,mx=256):
    if not (0x1000<a<0x80000000): return b''
    try:
        out=b''
        for i in range(mx):
            c=mu.mem_read(a+i,1)[0]
            if c==0: break
            out+=bytes([c])
        return out
    except: return b''

NARGS={"LoadLibraryA":1,"GetProcAddress":2,"GetModuleHandleA":1,"GetModuleFileNameA":3,
 "CreateFileA":7,"CreateFileMappingA":6,"MapViewOfFile":5,"UnmapViewOfFile":1,
 "CloseHandle":1,"VirtualProtect":4,"GetCurrentProcess":0,"FlushInstructionCache":3,
 "GlobalAlloc":2,"GlobalFree":1,"ExitProcess":1,"MessageBoxA":4,"wsprintfA":0,
 "GetDlgItem":2,"SetBkColor":2,"GetOpenFileNameA":1,"RegCreateKeyExA":9,
 "ShellExecuteA":6,"RevokeDragDrop":1}
halloc=[0x31000000]
ev=[]
LZ1=IMGBASE+0x2a8fd2

def hook(mu,addr,size,user):
    if addr==LZ1:
        eax=mu.reg_read(UC_X86_REG_EAX); edx=mu.reg_read(UC_X86_REG_EDX)
        ebx=mu.reg_read(UC_X86_REG_EBX); ecx=mu.reg_read(UC_X86_REG_ECX)
        ev.append(("LZ1 src=%#x dst=%#x size=%#x win=%#x"%(eax,edx,ebx,ecx),))
        return
    if 0x70000000<=addr<0x70040000:
        name=api_slots.get(addr)
        if name is None: return
        esp=mu.reg_read(UC_X86_REG_ESP)
        ret=struct.unpack('<I',mu.mem_read(esp,4))[0]
        args=[struct.unpack('<I',mu.mem_read(esp+4+4*i,4))[0] for i in range(6)]
        s=[rc(a) for a in args[:2]]
        r=0
        if name=="LoadLibraryA": r=0x70010000
        elif name=="GetProcAddress":
            r=NAME2ADDR.get(s[1].decode('latin-1','replace'),0)
            if r==0: ev.append(("MISSING PROC",s[1]))
        elif name=="GlobalAlloc":
            r=halloc[0]; halloc[0]=(r+((args[1]+0xffff)&~0xffff))
            ev.append(("GlobalAlloc",hex(args[1]),hex(r)))
        elif name=="GetModuleHandleA": r=IMGBASE
        elif name=="MapViewOfFile": r=0x40000000
        elif name=="CreateFileA": r=0x5678
        elif name=="CreateFileMappingA": r=0x1234
        elif name=="VirtualProtect":
            ev.append(("VirtualProtect",hex(args[0]),hex(args[1]),"prot=%#x"%args[2]))
            if args[3]:
                try: mu.mem_write(args[3],struct.pack('<I',0x40))
                except: pass
            r=1
        elif name=="GetModuleFileNameA":
            try: mu.mem_write(args[1],b'C:\\VST\\LM4-MarkII.dll\0')
            except: pass
            r=22
        elif name=="GetCurrentProcess": r=0xffffffff
        elif name in ("UnmapViewOfFile","CloseHandle","FlushInstructionCache","GlobalFree"): r=1
        elif name=="ExitProcess":
            ev.append(("ExitProcess",args[0])); mu.emu_stop(); return
        elif name=="MessageBoxA":
            ev.append(("MessageBox",s[0],s[1])); mu.emu_stop(); return
        mu.reg_write(UC_X86_REG_EAX,r)
        mu.reg_write(UC_X86_REG_ESP,esp+4+4*NARGS.get(name,0))
        mu.reg_write(UC_X86_REG_EIP,ret)
        return

mu.hook_add(UC_HOOK_CODE,hook)

esp=0x500ff000
mu.mem_write(esp-12,struct.pack('<IIII',0x7fff0000,IMGBASE,1,0))
mu.reg_write(UC_X86_REG_ESP,esp-12)

# stop when we leave the packer's own .neolit region (i.e. jump to real .text)
PACKLO=IMGBASE+0x2a8000; PACKHI=IMGBASE+0x2b0000
state={'oep':None}
def hook2(mu,addr,size,user):
    if 0x70000000<=addr<0x70040000: return
    if not (PACKLO<=addr<PACKHI):
        state['oep']=addr
        mu.emu_stop()
mu.hook_add(UC_HOOK_CODE,hook2)

try:
    mu.emu_start(IMGBASE+ENTRY,0x7fff0000,count=3_000_000_000,timeout=900*1000*1000)
except UcError as e:
    print("UC ERROR:",e,"EIP=%#x"%mu.reg_read(UC_X86_REG_EIP))

print("final EIP %#x  ESP %#x"%(mu.reg_read(UC_X86_REG_EIP),mu.reg_read(UC_X86_REG_ESP)))
print("---- events (%d) ----"%len(ev))
for e in ev[-30:]: print("  ",e)
print("OEP:", state['oep'] and hex(state['oep']))

img=bytes(mu.mem_read(IMGBASE,IMGSIZE))
open('unpacked2.bin','wb').write(img)
print("wrote unpacked2.bin",len(img))
