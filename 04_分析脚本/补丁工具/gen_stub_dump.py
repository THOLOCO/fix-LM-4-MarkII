import capstone, os

d = open('/data/data/com.termux/files/home/lm4/LM4-MarkII.dll','rb').read()
# .neolit: VA 0x102a8000, raw 0x3000
BASE = 0x102a8000
RAW  = 0x3000
md = capstone.Cs(capstone.CS_ARCH_X86, capstone.CS_MODE_32)

OUT = 'dump/壳代码'
os.makedirs(OUT, exist_ok=True)

def dump(va, size, name, title):
    off = RAW + (va - BASE)
    lines = []
    lines.append("; " + "="*70)
    lines.append("; %s" % title)
    lines.append("; VA %#x .. %#x   file %#x .. %#x   (%d bytes)" % (va, va+size, off, off+size, size))
    lines.append("; " + "="*70)
    lines.append("")
    n = 0
    for ins in md.disasm(d[off:off+size], va):
        b = ' '.join('%02x' % x for x in d[ins.address-BASE+RAW:ins.address-BASE+RAW+ins.size])
        lines.append("%08x  %-24s %-8s %s" % (ins.address, b, ins.mnemonic, ins.op_str))
        n += 1
    open(os.path.join(OUT, name), 'w').write("\n".join(lines) + "\n")
    print("  %-30s %4d 条  (%d 字节)" % (name, n, size))

print("壳代码反汇编:")
dump(0x102a81fa, 0x30,  '01_entry.asm',            'DllMain 入口')
dump(0x102a82a5, 0x40,  '02_entry_dispatch.asm',   '入口调度')
dump(0x102a82d9, 0x30,  '03_encrypted_strings.asm','加密字符串数据（XOR 0xFF）')
dump(0x102a8625, 0x2b0, '04_loader_main.asm',      '主加载器')
dump(0x102a88cc, 0x60,  '05_decompress_calls.asm', '解压调用点')
dump(0x102a8930, 0x1a0, '06_section_protect.asm',  '★ 段权限设置循环（DEP 问题）')
dump(0x102a8e04, 0xc0,  '07_reloc_apply.asm',      '重定位应用')
dump(0x102a8e6e, 0x60,  '08_reloc_walk.asm',       '重定位遍历')
dump(0x102a8ecd, 0x20,  '09_str_decrypt.asm',      '字符串解密（XOR 0xFF）')
dump(0x102a8fd2, 0x80,  '10_decompress.asm',       '解压器入口')
dump(0x102a907e, 0x700, '11_lz_decompress.asm',    'LZ77 解压核心')
dump(0x102a8dee, 0x20,  '12_jump_to_oep.asm',      '跳转到 OEP')
dump(0x102a848a, 0x60,  '13_error_dialog.asm',     '错误提示')
dump(0x102a8203, 0x20,  '14_api_slots.asm',        'API 函数槽')
