#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
LM-4 MarkII 补丁生成脚本
Patch generator for LM-4 MarkII

用法 / Usage:
    python3 apply_patch.py LM4-MarkII_原始.dll  LM4-MarkII_修补后.dll

依赖 / Requires: Python 3 (标准库 zlib / hashlib 即可，无需第三方包)

修补内容 / What it patches
  1) 壳把 .text 段设成 PAGE_READWRITE(0x04) 导致 DEP 崩溃
     改为 PAGE_EXECUTE_READWRITE(0x40)
       文件偏移 0x3A16 / 0x3AA8 / 0x3D3C : 04 -> 40
  2) main() 里的安装校验失败会静默返回 NULL
     把条件跳转改成无条件跳转
       .text 压缩流内偏移 0x13968 : 75 35 -> EB 35
       (VA 0x1001B968, jne -> jmp)
"""
import sys, zlib, hashlib

# ---- 常量 ----
STUB_PATCHES = [
    (0x3A16, 0x04, 0x40),   # VirtualProtect 段权限循环
    (0x3AA8, 0x04, 0x40),   # 资源段
    (0x3D3C, 0x04, 0x40),   # 重定位表
]
TEXT_STREAM_OFF   = 0x7E0B     # .text 压缩流在文件中的偏移
TEXT_STREAM_LIMIT = 0x46597    # 压缩流长度上限
LICENSE_OFF       = 0x13968    # 校验跳转在解压后 .text 中的偏移
LICENSE_OLD       = b'\x75\x35'
LICENSE_NEW       = b'\xEB\x35'
EXPECTED_MD5      = '29b5a2eaff617264fa589164ed23d4a0'


def main():
    if len(sys.argv) != 3:
        print(__doc__)
        return 1
    src, dst = sys.argv[1], sys.argv[2]
    data = bytearray(open(src, 'rb').read())

    md5 = hashlib.md5(data).hexdigest()
    print("输入文件 : %s" % src)
    print("大小     : %d 字节" % len(data))
    print("MD5      : %s" % md5)
    if md5 != EXPECTED_MD5:
        print("警告     : MD5 与预期不符（预期 %s）" % EXPECTED_MD5)
        print("           继续执行，但请确认输入文件正确。")

    # ---- 补丁 1-3：壳内硬编码的段权限 ----
    print("\n[1/2] 修补壳内段权限 (3 字节)")
    for off, old, new in STUB_PATCHES:
        cur = data[off]
        if cur != old:
            print("  偏移 %#06x 期望 %#04x，实际 %#04x —— 跳过" % (off, old, cur))
            continue
        data[off] = new
        print("  偏移 %#06x : %#04x -> %#04x   OK" % (off, old, new))

    # ---- 补丁 4：安装校验（需要解压/重压缩 .text 流）----
    print("\n[2/2] 修补安装校验跳转（压缩流内）")
    dec = zlib.decompressobj()
    text = bytearray(dec.decompress(data[TEXT_STREAM_OFF:TEXT_STREAM_OFF + TEXT_STREAM_LIMIT]))
    print("  .text 流解压后 : %d 字节 (%#x)" % (len(text), len(text)))
    if len(text) != 0xF9000:
        print("  错误：解压大小异常，输入文件可能不是预期的版本。")
        return 2

    cur = bytes(text[LICENSE_OFF:LICENSE_OFF + 2])
    if cur != LICENSE_OLD:
        print("  偏移 %#x 期望 %s，实际 %s —— 跳过" % (LICENSE_OFF, LICENSE_OLD.hex(), cur.hex()))
    else:
        text[LICENSE_OFF:LICENSE_OFF + 2] = LICENSE_NEW
        print("  偏移 %#x : %s -> %s   OK (VA 0x1001B968)" % (LICENSE_OFF, LICENSE_OLD.hex(), LICENSE_NEW.hex()))

    # 重新压缩，必须不超过原长度
    co = zlib.compressobj(9, zlib.DEFLATED, 15, 7, zlib.Z_DEFAULT_STRATEGY)
    stream = co.compress(bytes(text)) + co.flush()
    print("  重压缩后      : %d 字节，上限 %d" % (len(stream), TEXT_STREAM_LIMIT))
    if len(stream) > TEXT_STREAM_LIMIT:
        print("  错误：压缩结果超出上限，无法原地替换。")
        return 3
    pad = TEXT_STREAM_LIMIT - len(stream)
    data[TEXT_STREAM_OFF:TEXT_STREAM_OFF + TEXT_STREAM_LIMIT] = stream + b'\x00' * pad
    print("  写回压缩流，补零 %d 字节" % pad)

    open(dst, 'wb').write(data)
    out_md5 = hashlib.md5(data).hexdigest()
    print("\n输出文件 : %s" % dst)
    print("大小     : %d 字节" % len(data))
    print("MD5      : %s" % out_md5)
    print("预期 MD5 : 58934923d98769019be0519cfecaab20")
    print("结果     : %s" % ("一致 OK" if out_md5 == '58934923d98769019be0519cfecaab20' else "不一致"))
    return 0


if __name__ == '__main__':
    sys.exit(main())
