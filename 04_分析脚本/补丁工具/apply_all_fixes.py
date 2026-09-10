#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
LM-4 MarkII —— 全部修补一键生成
LM-4 MarkII — full patch generator

用法 / Usage:
    python3 apply_all_fixes.py LM4-MarkII_原始.dll LM4-MarkII_修补后.dll

依赖 / Requires: Python 3 标准库（zlib / hashlib）

================================================================
本脚本共修补 4 类问题 / This script fixes 4 classes of issues
================================================================

① DEP 崩溃（壳内，3 字节）
   NeoLite 壳解压后用 VirtualProtect 把 .text 设成 PAGE_READWRITE(0x04)，
   现代 Windows 开启 DEP 后跳到入口点即崩溃。
   文件偏移 0x3A16 / 0x3AA8 / 0x3D3C : 0x04 -> 0x40

② 安装校验静默失败（压缩流内，1 字节）
   main() 里校验失败会返回 NULL，且错误框因字符串资源 ID 不存在而弹不出来。
   .text 流内偏移 0x13968（VA 0x1001B968）: 75 35 -> EB 35 (jne -> jmp)

③ MIDI 端口 / 鼓垫参数崩溃（压缩流内，64 字节）
   0x10016120 是「按索引取程序/鼓垫对象」，直接解引用 [this+0x184] 而无空值检查。
   改写为空值安全版本：保留索引范围检查；[this+0x184] 为空时回退到
   [this+0x188]（第 0 个）；两者都为空则安全返回 0。

④ Tune 旋钮崩溃（压缩流内，24 字节）
   鼓垫 Tune 路径在写完 Octave/Tune Coarse/Tune Fine 之后调用
   0x100F4020（更新音高），把 [this+0x1dc]（采样管理器）当参数传入，
   但**没有做空值检查**。该函数入口第一条就是 mov edx,[ecx+0x2ac]，
   于是读取 0x000002AC 而崩溃。
   全局 M.Tune 的同款路径（0x14882）是有检查的，作者只漏了这一条。
   在 0x10014A68 处插入 jecxz 跳过该通知调用。

================================================================
"""
import sys, zlib, hashlib, struct

# ==================== ① 壳内段权限 ====================
STUB_PATCHES = [
    (0x3A16, 0x04, 0x40),
    (0x3AA8, 0x04, 0x40),
    (0x3D3C, 0x04, 0x40),
]

# ==================== .text 压缩流参数 ====================
TEXT_STREAM_OFF   = 0x7E0B
TEXT_STREAM_LIMIT = 0x46597
TEXT_BASE_RVA     = 0x8000        # .text 在文件中的 RVA（VA = 0x10000000 + RVA）

# ==================== ② 安装校验 ====================
LICENSE_OFF = 0x13968             # .text 流内偏移 = 0x1001B968 - 0x10008000
LICENSE_OLD = b'\x75\x35'
LICENSE_NEW = b'\xEB\x35'

# ==================== ③ MIDI / 鼓垫参数 ====================
MIDI_RVA  = 0x16120
MIDI_SIZE = 0x40
MIDI_OLD = bytes.fromhex(
    "558bec83ec0c8b450885c07c0583f8127e0833c08be55dc20400"
    "578904248b89840100008b118b828c000000ffd08be55dc20400"
    "8db6000000008dbf00000000"
)
MIDI_NEW = bytes.fromhex(
    "55"                  # push ebp
    "8bec"                # mov  ebp, esp
    "8b4508"              # mov  eax, [ebp+8]      ; 索引
    "83f812"              # cmp  eax, 0x12
    "7726"                # ja   失败分支          ; >18 或负数
    "50"                  # push eax               ; 内部虚调用的参数
    "8bc1"                # mov  eax, ecx          ; eax = this
    "8b8884010000"        # mov  ecx, [eax+0x184]  ; 当前活动程序
    "85c9"                # test ecx, ecx
    "750a"                # jnz  调用分支
    "8b8888010000"        # mov  ecx, [eax+0x188]  ; 回退：第 0 个程序
    "85c9"                # test ecx, ecx
    "740f"                # jz   失败分支
    "8b11"                # mov  edx, [ecx]
    "ff928c000000"        # call dword ptr [edx+0x8c]
    "8be5"                # mov  esp, ebp
    "5d"                  # pop  ebp
    "c20400"              # ret  4
    "90"                  # nop
    "8be5"                # 失败分支: mov esp, ebp
    "5d"                  # pop  ebp
    "33c0"                # xor  eax, eax
    "c20400"              # ret  4
)
MIDI_NEW = MIDI_NEW + b'\x90' * (MIDI_SIZE - len(MIDI_NEW))

# ==================== ④ Tune 旋钮 ====================
# 压缩流内偏移 = 0x10014A68 - 0x10008000
TUNE_RVA  = 0x14A68
TUNE_SIZE = 0x18                  # 0x14A68..0x14A80 = 24 字节
TUNE_OLD = bytes.fromhex(
    "8b45cc"                      # mov  eax, [ebp-0x34]        ; this
    "8b88dc010000"                # mov  ecx, [eax+0x1dc]      ; 采样管理器（可能为空）
    "53"                          # push ebx                   ; zone 对象
    "e8a9f50d00"                  # call 0x100f4020            ; 内部解引用 ecx → 崩溃
    "e938ffffff"                  # jmp  0x100149b4            ; 循环继续
    "8d742600"                    # lea  esi, [esi]            ; 对齐填充
)
TUNE_NEW = bytes.fromhex(
    "8b45cc"                      # mov  eax, [ebp-0x34]
    "8b88dc010000"                # mov  ecx, [eax+0x1dc]
    "e306"                        # jecxz 跳过调用             ; ★ 新增：空值保护
    "53"                          # push ebx
    "e8a7f50d00"                  # call 0x100f4020
    "e936ffffff"                  # jmp  0x100149b4
    "9090"                        # nop nop
)


def main():
    if len(sys.argv) != 3:
        print(__doc__)
        return 1
    src, dst = sys.argv[1], sys.argv[2]
    data = bytearray(open(src, 'rb').read())
    print("输入: %s  (%d 字节)  MD5 %s" % (src, len(data), hashlib.md5(data).hexdigest()))

    # ---------- ① 壳内段权限 ----------
    print("\n[1/5] 壳内段权限 0x04 -> 0x40")
    for off, old, new in STUB_PATCHES:
        if data[off] == old:
            data[off] = new
            print("    偏移 %#06x : %#04x -> %#04x  OK" % (off, old, new))
        else:
            print("    偏移 %#06x : 已是 %#04x，跳过" % (off, data[off]))

    # ---------- 解压 .text ----------
    print("\n[2/5] 解压 .text 压缩流")
    dec = zlib.decompressobj()
    text = bytearray(dec.decompress(data[TEXT_STREAM_OFF:TEXT_STREAM_OFF + TEXT_STREAM_LIMIT]))
    print("    %d 字节 (%#x)" % (len(text), len(text)))
    if len(text) != 0xF9000:
        print("    错误：解压尺寸异常，输入文件可能不是预期的版本")
        return 2

    def apply(name, rva, size, old, new):
        off = rva - TEXT_BASE_RVA
        cur = bytes(text[off:off + size])
        if cur == new:
            print("    %-26s %#08x : 已修补，跳过" % (name, rva))
            return True
        if cur != old:
            print("    %-26s %#08x : ★ 原字节不符" % (name, rva))
            print("        期望 %s" % old.hex())
            print("        实际 %s" % cur.hex())
            return False
        text[off:off + size] = new
        print("    %-26s %#08x : %d 字节已重写  OK" % (name, rva, size))
        return True

    # ---------- ③④ 与 ② ----------
    print("\n[3/5] .text 内补丁")
    ok = True
    ok &= apply("安装校验跳转",      0x1B968, 2,  LICENSE_OLD, LICENSE_NEW)
    ok &= apply("MIDI/鼓垫参数空值保护", MIDI_RVA, MIDI_SIZE, MIDI_OLD, MIDI_NEW)
    ok &= apply("Tune 空值保护",       TUNE_RVA, TUNE_SIZE, TUNE_OLD, TUNE_NEW)
    if not ok:
        print("\n中止：有补丁无法应用")
        return 3

    # ---------- 重新压缩 ----------
    print("\n[4/5] 重新压缩 .text 流")
    co = zlib.compressobj(9, zlib.DEFLATED, 15, 7, zlib.Z_DEFAULT_STRATEGY)
    stream = co.compress(bytes(text)) + co.flush()
    print("    %d 字节，上限 %d" % (len(stream), TEXT_STREAM_LIMIT))
    if len(stream) > TEXT_STREAM_LIMIT:
        print("    错误：超出上限，无法原地替换")
        return 4
    pad = TEXT_STREAM_LIMIT - len(stream)
    data[TEXT_STREAM_OFF:TEXT_STREAM_OFF + TEXT_STREAM_LIMIT] = stream + b'\x00' * pad
    print("    写回压缩流，补零 %d 字节" % pad)

    # ---------- 输出 ----------
    open(dst, 'wb').write(data)
    print("\n[5/5] 完成")
    print("输出: %s  (%d 字节)  MD5 %s" % (dst, len(data), hashlib.md5(data).hexdigest()))
    return 0


if __name__ == '__main__':
    sys.exit(main())
