import capstone, os

d = open('/data/data/com.termux/files/home/lm4/unpacked2.bin','rb').read()
IB = 0x10000000
md = capstone.Cs(capstone.CS_ARCH_X86, capstone.CS_MODE_32)

OUT = 'dump'
os.makedirs(OUT, exist_ok=True)

def dump(rva, size, name, title):
    lines = []
    lines.append("; " + "="*70)
    lines.append("; %s" % title)
    lines.append("; RVA %#x .. %#x   VA %#x .. %#x   (%d bytes)" % (rva, rva+size, IB+rva, IB+rva+size, size))
    lines.append("; " + "="*70)
    lines.append("")
    n = 0
    for ins in md.disasm(d[rva:rva+size], IB+rva):
        b = ' '.join('%02x' % x for x in d[ins.address-IB:ins.address-IB+ins.size])
        lines.append("%08x  %-24s %-8s %s" % (ins.address, b, ins.mnemonic, ins.op_str))
        n += 1
    open(os.path.join(OUT, name), 'w').write("\n".join(lines) + "\n")
    print("  %-34s %5d 条指令  (%d 字节)" % (name, n, size))

print("生成反汇编:")
dump(0x1b8e0, 0x2c0, 'main_VSTPluginMain.asm',      'main() —— VST 插件入口 (导出函数)')
dump(0x1b8a0, 0x60,  'export_thunk.asm',           '导出跳转 thunk')
dump(0xf8480, 0x100, 'DllMain.asm',                'DllMain')
dump(0xf8559, 0x100, 'CRT_startup.asm',            'CRT 启动')
dump(0x1e6c0, 0x450, 'license_check.asm',          '安装校验 (授权检查)')
dump(0x1ec90, 0x230, 'license_drive_serial.asm',   '安装校验 —— 卷序列号/注册表')
dump(0x1ef10, 0x100, 'license_key_derive.asm',     '密钥派生')
dump(0x1f020, 0x90,  'registry_read.asm',          '注册表读取封装')
dump(0x21180, 0x210, 'vst_dispatcher_low.asm',     'VST dispatcher (opcode 0..0x18)')
dump(0x21d90, 0x6c0, 'vst_dispatcher_high.asm',    'VST dispatcher (opcode 0x19..0x44)')
dump(0x140a0, 0x80,  'effGetProgramNameIndexed.asm','effGetProgramNameIndexed (20 个上限)')
dump(0x13ef0, 0x180, 'startup_load_bank.asm',      '启动加载默认音色库')
dump(0xec750, 0x2a0, 'load_bank.asm',              'Bank 加载 (解析 fxb)')
dump(0xee140, 0x420, 'parse_bank.asm',             'Bank 解析核心')
dump(0x13a60, 0x3e0, 'AEffect_ctor.asm',           'AEffect 构造')
dump(0x16120, 0x40,  'midi_program_name.asm',      '★ MIDI 程序名查询 (崩溃点 0x16144)')
dump(0x13ef0, 0x20,  '_probe.asm',                 'probe')
