import struct
from unicorn import *
from unicorn.x86_const import *
import capstone

IB = 0x10000000
ORIG = open('../../03_内存镜像/unpacked_image.bin','rb').read()

# 补丁字节（24 字节，替换 0x14A68..0x14A80）
NEW = bytes.fromhex("8b45cc8b88dc010000e30653e8a7f50d00e936ffffff9090")

def run(img, label, mgr_null):
    mu = Uc(UC_ARCH_X86, UC_MODE_32)
    mu.mem_map(IB, 0x300000); mu.mem_write(IB, bytes(img))
    mu.mem_map(0x20000000, 0x100000)      # 栈
    mu.mem_map(0x30000000, 0x100000)      # 测试数据
    mu.mem_map(0x40000000, 0x10000)       # 桩
    mu.mem_map(0x7fff0000, 0x10000)       # 哨兵返回

    # 桩：返回 0
    mu.mem_write(0x40000000, b'\x33\xc0\xc3')      # xor eax,eax; ret

    THIS = 0x30010000
    ZONE = 0x30020000
    FAKEOBJ = 0x30030000
    MGR  = 0x30040000
    VT_OBJ = 0x30050000
    VT_MGR = 0x30060000

    for name, adr in (("this",THIS),("zone",ZONE),("fake",FAKEOBJ),("mgr",MGR),
                      ("vt_obj",VT_OBJ),("vt_mgr",VT_MGR)):
        mu.mem_write(adr, b'\x00'*0x1000)

    # fake obj vtable: [0x1c] = 返回 0 的桩（循环计数=0）
    mu.mem_write(FAKEOBJ, struct.pack('<I', VT_OBJ))
    mu.mem_write(VT_OBJ+0x1c, struct.pack('<I', 0x40000000))

    # this+0x1dc
    mu.mem_write(THIS+0x1dc, struct.pack('<I', 0 if mgr_null else MGR))
    # mgr+0x2ac = 0 → 0x100f4020 会走 je 返回
    mu.mem_write(MGR+0x2ac, struct.pack('<I', 0))

    EBP = 0x200ff000
    ESP = 0x200fe000
    mu.mem_write(EBP,   struct.pack('<I', 0x20000000))   # 保存的 ebp
    mu.mem_write(EBP+4, struct.pack('<I', 0x7fff0000))   # 哨兵返回地址
    mu.mem_write(EBP-0x34, struct.pack('<I', THIS))      # ★ this = [ebp-0x34]
    mu.reg_write(UC_X86_REG_EBP, EBP)
    mu.reg_write(UC_X86_REG_ESP, ESP)
    mu.reg_write(UC_X86_REG_EBX, ZONE)      # zone 对象
    mu.reg_write(UC_X86_REG_ESI, FAKEOBJ)   # 循环用
    mu.reg_write(UC_X86_REG_EDI, 0)

    try:
        mu.emu_start(IB+0x14a68, 0x7fff0000, count=100000)
        print("  %-42s ✅ 正常返回（未崩溃）" % label)
        return True
    except UcError as e:
        eip = mu.reg_read(UC_X86_REG_EIP)
        print("  %-42s ★ 崩溃: %s" % (label, e))
        print("       EIP = %#x  (RVA %#x)" % (eip, eip-IB))
        return False

print("="*76)
print("  Tune 路径 0x14A68 处：[this+0x1dc] 为空时是否崩溃")
print("="*76)
print()
print("【原版】")
run(ORIG, "① [this+0x1dc] = NULL  (← 崩溃现场)", True)
run(ORIG, "② [this+0x1dc] 有效", False)
print()
img_new = bytearray(ORIG); img_new[0x14a68:0x14a80] = NEW
print("【补丁后】")
run(img_new, "③ [this+0x1dc] = NULL  (← 应安全跳过)", True)
run(img_new, "④ [this+0x1dc] 有效（不应误伤）", False)
