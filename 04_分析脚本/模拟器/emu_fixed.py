import struct
from unicorn import *
from unicorn.x86_const import *

FILE="LM4-MarkII_fixed.dll"
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
mu.mem_map(0x50000000,0x200000)
mu.mem_map(0x30000000,0x10000000)
mu.mem_map(0x70000000,0x80000)
mu.mem_map(0x40000000,0x100000)
mu.mem_write(0x40000000,data)

APIS={"LoadLibraryA":(1,0x70010000),"GetProcAddress":(2,-1),"GetModuleHandleA":(1,IMGBASE),
 "GetModuleFileNameA":(3,-2),"CreateFileA":(7,0x5678),"CreateFileMappingA":(6,0x1234),
 "MapViewOfFile":(5,0x40000000),"UnmapViewOfFile":(1,1),"CloseHandle":(1,1),
 "VirtualProtect":(4,-3),"GetCurrentProcess":(0,0xffffffff),"FlushInstructionCache":(3,1),
 "GlobalAlloc":(2,-4),"GlobalFree":(1,0),"ExitProcess":(1,-9),"MessageBoxA":(4,-9),
 "wsprintfA":(0,0)}
api_slots={}
for i,(n,v) in enumerate(APIS.items()): api_slots[0x70000000+i*16]=n
NAME2ADDR={n:a for a,n in api_slots.items()}
IAT={0x102a80a0:"LoadLibraryA",0x102a80a4:"GetProcAddress"}
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

halloc=[0x30010000]
ev=[]
def hook(mu,addr,size,user):
    if 0x70000000<=addr<0x70080000:
        name=api_slots.get(addr)
        if name is None: return
        na,rt=APIS[name]
        esp=mu.reg_read(UC_X86_REG_ESP)
        ret=struct.unpack('<I',mu.mem_read(esp,4))[0]
        args=[struct.unpack('<I',mu.mem_read(esp+4+4*i,4))[0] for i in range(na)]
        s=[rc(a) for a in args]
        r=0
        if name=="GetProcAddress":
            k=s[1].decode('latin-1','replace'); r=NAME2ADDR.get(k,0)
            if r==0:
                slot=0x70000000+len(api_slots)*16
                api_slots[slot]=k; NAME2ADDR[k]=slot; APIS[k]=(0,0); r=slot
        elif rt==-2:
            p=b'C:\\VST\\LM4-MarkII.dll\0'
            try: mu.mem_write(args[1],p)
            except: pass
            r=len(p)-1
        elif rt==-3:
            PROT={0x01:'NOACCESS',0x02:'READONLY',0x04:'READWRITE',0x08:'WRITECOPY',
                  0x10:'EXECUTE',0x20:'EXECUTE_READ',0x40:'EXECUTE_READWRITE',0x80:'EXECUTE_WRITECOPY'}
            ev.append("VirtualProtect(addr=%#010x size=%#x new=%#x(%s)) from ret=%#010x"%(args[0],args[1],args[2],PROT.get(args[2],'?'),ret))
            if args[3]:
                try: mu.mem_write(args[3],struct.pack('<I',0x04))
                except: pass
            r=1
        elif rt==-4:
            r=halloc[0]; halloc[0]=(r+((args[1]+0xffff)&~0xffff))
        elif rt==-9:
            ev.append("%s %s"%(name,[x for x in s[:2] if x])); mu.emu_stop(); return
        else:
            r=rt
        mu.reg_write(UC_X86_REG_EAX,r&0xffffffff)
        mu.reg_write(UC_X86_REG_ESP,esp+4+4*na)
        mu.reg_write(UC_X86_REG_EIP,ret)
        return

mu.hook_add(UC_HOOK_CODE,hook)
esp=0x500ff000
mu.mem_write(esp-12,struct.pack('<IIII',0x7fff0000,IMGBASE,1,0))
mu.reg_write(UC_X86_REG_ESP,esp-12)
PACKLO=IMGBASE+0x2a8000; PACKHI=IMGBASE+0x2b0000
def hook2(mu,addr,size,user):
    if 0x70000000<=addr<0x70080000: return
    if not (PACKLO<=addr<PACKHI):
        ev.append("OEP -> %#x"%addr); mu.emu_stop()
mu.hook_add(UC_HOOK_CODE,hook2)

try:
    mu.emu_start(IMGBASE+ENTRY,0x7fff0000,count=6_000_000_000,timeout=2400*1000*1000)
except UcError as e:
    print("UC ERROR:",e,"EIP=%#x"%mu.reg_read(UC_X86_REG_EIP))

print("---- events ----")
for e in ev: print("  ",e)
open('emu8.events','w').write("\n".join(ev))
