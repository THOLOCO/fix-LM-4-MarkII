import struct, zlib
from unicorn import *
from unicorn.x86_const import *
import capstone

IB = 0x10000000
img = bytearray(open('../../03_内存镜像/unpacked_image.bin','rb').read())

# 应用 MIDI 补丁到镜像
MIDI_RVA = 0x16120
d = open('apply_all_fixes.py','rb').read()
# 直接从补丁脚本里取新代码
import re
src = d.decode('utf-8')
m = re.search(r'MIDI_NEW = bytes\.fromhex\((.*?)\)\nMIDI_NEW', src, re.S)
hexstr = ''.join(re.findall(r'"([0-9a-f]+)"', m.group(1)))
MIDI_NEW = bytes.fromhex(hexstr) + b'\x90'*(0x40 - len(bytes.fromhex(hexstr)))
print("MIDI 新代码 %d 字节" % len(MIDI_NEW))
img[MIDI_RVA:MIDI_RVA+0x40] = MIDI_NEW

mu = Uc(UC_ARCH_X86, UC_MODE_32)
mu.mem_map(IB, 0x300000); mu.mem_write(IB, bytes(img))
mu.mem_map(0x20000000, 0x100000)   # 栈
mu.mem_map(0x30000000, 0x100000)   # 测试数据
mu.mem_map(0x40000000, 0x100000); mu.mem_map(0x7fff0000, 0x10000)

STUB = 0x40000000
CALLED = 0x30000000
mu.mem_write(STUB, b'\x8b\xc4\xc3')     # mov eax,esp; ret  (记录到 eax)

md = capstone.Cs(capstone.CS_ARCH_X86, capstone.CS_MODE_32)

def call_targeted(obj, index, label):
    """调用 0x10016120，ecx=obj，栈上压入 index"""
    esp = 0x200f0000
    mu.mem_write(CALLED, b'\x00'*16)
    # 栈：返回地址 0x7fff0000，然后参数 index
    mu.mem_write(esp, struct.pack('<II', 0x7fff0000, index))
    mu.reg_write(UC_X86_REG_ESP, esp)
    mu.reg_write(UC_X86_REG_ECX, obj)
    mu.reg_write(UC_X86_REG_EBP, 0x200ff000)
    try:
        mu.emu_start(IB+0x16120, 0x7fff0000, count=10000)
        eax = mu.reg_read(UC_X86_REG_EAX)
        esp_after = mu.reg_read(UC_X86_REG_ESP)
        print("  %-42s 返回 eax=%#010x  (无异常)" % (label, eax))
        return eax, esp_after
    except UcError as e:
        print("  %-42s ★ 崩溃: %s" % (label, e))
        return None, None

def mk_object(active, first):
    """构造假对象：+0x184 = active, +0x188 = first"""
    o = 0x30010000
    mu.mem_write(o, b'\x00'*0x400)
    mu.mem_write(o+0x184, struct.pack('<I', active))
    mu.mem_write(o+0x188, struct.pack('<I', first))
    return o

def mk_program():
    """构造假程序对象 + 虚表，vtbl[0x8c/4] 指向 STUB"""
    p = 0x30020000
    vt = 0x30030000
    for i in range(0x100):
        mu.mem_write(vt+i*4, struct.pack('<I', STUB))
    mu.mem_write(vt+0x8c, struct.pack('<I', STUB))
    mu.mem_write(p, struct.pack('<I', vt))
    return p

prog = mk_program()

print("="*72)
print("  补丁后 0x10016120 单元测试")
print("="*72)

# 用例 1：正常（active 非空）
o1 = mk_object(prog, prog)
call_targeted(o1, 3, "① [0x184] 有效")

# 用例 2：active 为空，first 有效 → 应回退成功
o2 = mk_object(0, prog)
call_targeted(o2, 5, "② [0x184]=NULL, [0x188] 有效 → 回退")

# 用例 3：两者都为空 → 应安全返回 0
o3 = mk_object(0, 0)
call_targeted(o3, 7, "③ 都为空 → 安全返回")

# 用例 4：索引越界
o4 = mk_object(prog, prog)
call_targeted(o4, 0x20, "④ 索引 0x20 越界 → 返回 0")
call_targeted(o4, 0xFFFFFFFF, "⑤ 索引 -1 → 返回 0")

print()
print("="*72)
print("  对照：补丁前的原始函数")
print("="*72)
img2 = bytearray(open('../../03_内存镜像/unpacked_image.bin','rb').read())
mu2 = Uc(UC_ARCH_X86, UC_MODE_32)
mu2.mem_map(IB, 0x300000); mu2.mem_write(IB, bytes(img2))
mu2.mem_map(0x20000000, 0x100000); mu2.mem_map(0x30000000, 0x100000); mu2.mem_map(0x40000000, 0x100000); mu2.mem_map(0x7fff0000, 0x10000)
mu2.mem_write(0x40000000, b'\x8b\xc4\xc3')
def mk2(o, active, first):
    mu2.mem_write(o, b'\x00'*0x400)
    mu2.mem_write(o+0x184, struct.pack('<I', active)); mu2.mem_write(o+0x188, struct.pack('<I', first))
    return o
mu2.mem_write(0x30020000, struct.pack('<I', 0x30030000))
for i in range(0x100): mu2.mem_write(0x30030000+i*4, struct.pack('<I',0x40000000))
o = mk2(0x30010000, 0, 0x30020000)
esp = 0x200f0000
mu2.mem_write(esp, struct.pack('<II', 0x7fff0000, 3))
mu2.reg_write(UC_X86_REG_ESP, esp); mu2.reg_write(UC_X86_REG_ECX, o); mu2.reg_write(UC_X86_REG_EBP, 0x200ff000)
try:
    mu2.emu_start(IB+0x16120, 0x7fff0000, count=10000)
    print("  原函数 [0x184]=NULL : 未崩溃（意外）")
except UcError as e:
    print("  原函数 [0x184]=NULL : ★ 崩溃 -> %s" % e)
