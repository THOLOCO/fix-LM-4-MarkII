================================================================
  Steinberg LM-4 MarkII — 逆向分析报告
  Reverse Engineering Report
  整理 & 修补：TOLOC
  技术分析 & 二进制修补：DeepSeek
================================================================

【中文】

----------------------------------------------------------------
0. 一句话结论
----------------------------------------------------------------
这个 DLL 用 NeoLite 加壳，壳在解压完成后把整个 .text 代码段
设成 PAGE_READWRITE（不可执行）。现代 Windows 默认开启 DEP，
壳跳到入口点即触发访问冲突，宿主只能报"插件有问题"。
另外插件 main() 里还有一层安装校验，失败时静默返回 NULL。
两处共 4 个字节的修补即可解决。

----------------------------------------------------------------
1. 文件结构（加壳后）
----------------------------------------------------------------
文件偏移            内容
0x0000 - 0x2FFF     占位数据（几乎全 0，诱饵）
0x3000 - 0x5FFF     .neolit 壳代码（NeoLite EP-!）
0x6000 - 0x8D5D7    加壳的原始文件（zlib 压缩流 + 头部）

关键：PE 头里 .text 的 RawAddress = 0、RawSize = 0xf9000，
即指针指回文件头自己 —— 真正的代码段在磁盘上一个字节都没有。
这不是可加载的 PE，而是 NeoLite 的压缩容器。

段表（加壳后）：
  .text     VA=0x008000 VS=0x0f9000 RA=0x000000 RS=0x0f9000 ch=0xc0000080
  .rdata    VA=0x101000 VS=0x002000 RA=0x000000 RS=0x002000 ch=0x40000080
  .data     VA=0x103000 VS=0x082384 RA=0x000000 RS=0x007000 ch=0xc0000080
  .data1    VA=0x186000 VS=0x01c000 RA=0x000000 RS=0x01c000 ch=0xc0000080
  _DATA     VA=0x1a2000 VS=0x001000 RA=0x001000 RS=0x001000 ch=0xc0000040
  .rsrc     VA=0x1a3000 VS=0x0f72c8 RA=0x002000 RS=0x001000 ch=0x40000040
  Oreloc    VA=0x29b000 VS=0x00d000 RA=0x000000 RS=0x00d000 ch=0x42000080
  .neolit   VA=0x2a8000 VS=0x0061fa RA=0x003000 RS=0x002000 ch=0xe0000020
  .reloc    VA=0x2af000 VS=0x0000dc RA=0x005000 RS=0x001000 ch=0x42000040

----------------------------------------------------------------
2. 壳的执行流程
----------------------------------------------------------------
1) DllMain (VA 0x102a81fa) -> 跳转到 0x102a82a5
2) 解密壳内 API 字符串（每字节 XOR 0xFF）
   kernel32: LoadLibraryA GetProcAddress GetModuleHandleA
             GetModuleFileNameA CreateFileA CreateFileMappingA
             MapViewOfFile UnmapViewOfFile CloseHandle
             VirtualProtect GetCurrentProcess FlushInstructionCache
             GlobalAlloc GlobalFree ExitProcess
   user32:   MessageBoxA wsprintfA
   错误串:   "Not enough memory to load."
             "This file has been corrupted."
             "Unable to read this file."
             "Unable to locate DLL: "
             "Unable to locate exported function "
             "Required relocations are missing"
3) CreateFileA + CreateFileMappingA + MapViewOfFile 映射自身
   校验文件头魔数 0x04181996
4) 用内嵌解压器解出第二级解压器，覆盖到 .neolit 段
5) 从覆盖层里的原始 PE 头解出真正的镜像，写回 ImageBase + 各段 VA
   实测解压流：
     src=0x400060c4 dst=0x102a9b0a size=0x26f0   (第二级解压器)
     src=0x400079ff dst=0x102ac1fa size=0x1800
     src=0x40007e0b dst=0x10008000 size=0xf9000   (.text)
     src=0x4004e3a2 dst=0x10101000 size=0x2000    (.rdata)
     src=0x4004efae dst=0x10103000 size=0x7000    (.data)
     src=0x40050757 dst=0x10186000 size=0x1c000   (.data1)
     src=0x400539ba dst=0x101a2000 size=0x1000    (_DATA)
     src=0x4005448a dst=0x101a4000 size=0xf62c2   (.rsrc)
     src=0x4008bab5 dst=0x1029b000 size=0xd000    (Oreloc)
     src=0x4008baff dst=0x102ac1fa size=0x5577
6) 处理导入表、重定位、TLS
7) VirtualProtect 设置段权限  ← ★ 问题在这里
8) jmp eax 跳转到 ImageBase + OEP (0x100f8559)

----------------------------------------------------------------
3. 问题 1：DEP 违规
----------------------------------------------------------------
壳内设置段权限的循环（VA 0x102a89dc 起）：

  0x102a89e5  add  edx, eax                  ; 段基址
  0x102a8a11  lea  eax, [ebp-0x46]
  0x102a8a14  push eax                       ; lpflOldProtect
  0x102a8a15  push 4                         ; ★ flNewProtect = PAGE_READWRITE
  0x102a8a17  push [ebp+0x4e]                ; dwSize
  0x102a8a1a  push [ebp-0x42]                ; lpAddress
  0x102a8a1d  lea  ebx, [ebp-0x42]
  0x102a8a20  call [ebp+0x6e]                ; VirtualProtect

实测（模拟器日志）：
  VirtualProtect(0x10008000 size=0xf9000 new=0x4(READWRITE))   ← .text
  VirtualProtect(0x10101000 size=0x2000  new=0x4(READWRITE))
  VirtualProtect(0x10103000 size=0x7000  new=0x4(READWRITE))
  VirtualProtect(0x10186000 size=0x1c000 new=0x4(READWRITE))
  VirtualProtect(0x101a2000 size=0x1000  new=0x4(READWRITE))
  VirtualProtect(0x101a4000 size=0xf62c2 new=0x4(READWRITE))
  VirtualProtect(0x1029b000 size=0xd000  new=0x4(READWRITE))

之后有一段"按段特性决定权限"的逻辑（VA 0x102a8a43）：
  desc.flags = [esi+4] & 0x80000000      ; 描述符标志 bit31
  sec.chars  = [edi+0x24] & 0x80000000   ; 段特性 bit31
  cmp / je   -> 相等就保持旧权限
  不相等且 desc.flags & 0x20 -> 设 0x20 (EXECUTE_READ)

实测输出：
  SEC .text     desc.flags=0x60000020 sec.chars=0xc0000080 -> code -> EXECUTE_READ
  SEC .rdata    desc.flags=0x40000040 sec.chars=0x40000080 -> EQUAL
  SEC .data     desc.flags=0xc0000040 sec.chars=0xc0000080 -> EQUAL
  ...

即：壳算出了 .text 应该是 EXECUTE_READ（0x20），
但紧接着的 "mov [ebp-0x36], 0x20" 因为比较结果为"相等"而被跳过，
最终保留了硬编码的 4（PAGE_READWRITE）。

2003 年 32 位进程默认关闭 DEP，页保护里的"不可执行"位被 CPU 忽略，
所以当年正常。现代 DAW 全部启用 DEP，跳转到 OEP 即崩溃。

修补：
  文件偏移 0x3a16 : 0x04 -> 0x40   (PAGE_EXECUTE_READWRITE)
  文件偏移 0x3aa8 : 0x04 -> 0x40
  文件偏移 0x3d3c : 0x04 -> 0x40

----------------------------------------------------------------
4. 问题 2：安装校验静默失败
----------------------------------------------------------------
main() 里的校验分支（VA 0x1001b95c）：

  0x1001b95e  call 0x1001e6c0        ; 安装校验
  0x1001b963  movsx eax, al
  0x1001b966  test eax, eax
  0x1001b968  jne  0x1001b99f        ; 通过则继续
  0x1001b96a  call 0x1001eb10        ; 失败：弹错误框
  0x1001b984  xor  eax, eax          ; 返回 NULL

校验算法（0x1001e6c0 / 0x1001ec90 / 0x1001ef10 / 0x1001f020）：
  1. 构造函数从内置 CRC32 表生成 16 字节固定密钥（与机器无关）
  2. 校验时：密钥 XOR 0xAA -> CRC32 -> +1 -> sprintf("%u")
     得到固定字符串 "2523069250"
  3. 读 HKLM\Software\Steinberg\LM4-MarkII 的 SetupSysID
  4. 每个字节做 (b - 8) XOR 1
  5. 结果必须等于 "2523069250"

实测验证（用安装日志里的真实值）：
  SetupSysID (REG_BINARY) = 3B 3C 3B 3A 39 3F 40 3B 3C 39
  解密后 = "2523069250"
  期望值 = "2523069250"    -> 通过

但实际加载失败，说明注册表值与安装器写入的不一致
（可能被存成 REG_SZ 文本，或值被改写）。

关键：错误提示框本身弹不出来。
  代码请求字符串资源 ID 128，但插件资源表里只有
  16496 / 16528 / 16576 / 16640 / 49312 这几个 ID。
  LoadStringA 失败 -> 跳过 MessageBoxA -> 静默失败。
  这就是"没有错误框、但加载失败"的原因。

修补：
  0x1001b968 : 75 35 -> EB 35   (jne -> jmp，无条件走成功分支)

----------------------------------------------------------------
5. 修补清单（共 4 字节）
----------------------------------------------------------------
文件偏移      原值    新值    说明
0x3a16        0x04 -> 0x40    壳：.text 设为可执行
0x3aa8        0x04 -> 0x40    壳：同上
0x3d3c        0x04 -> 0x40    壳：同上
.text 内      75 35 -> EB 35  跳过安装校验
  (VA 0x1001b968，压缩流内偏移 0x13968)

注意：第 4 处位于压缩流内部。修改后需重新压缩 .text 流并保证
长度不超过原来的 0x46597 字节。使用 zlib level=9, memLevel=7,
默认策略可压缩到 287998 字节（原 288151），可原地替换。

----------------------------------------------------------------
6. 预设文件（.fxp / .fxb）格式
----------------------------------------------------------------
FXP（单个预设）：
  CcnK + ver(4) + FPCh + fxID("LM42") + fxVer(4) + nParam(4)
  + prgLen(4) + ... + 程序名(28) + ... + HaPa 块...

FXB（音色库）：
  CcnK + ver(4) + FBCh + fxID + fxVer(4) + nParam(4) + ...

  HaPa 块 = 一个程序（Kit），块与块之间直接拼接，无分隔符。
  程序名位于块起始 + 0x7c 处，最长 28 字节。

  实测 Wizoo 库 10 个块：
    [ 0] 0x0084a0 size=66222   ' 01 Gator Kit'
    [ 1] 0x01874e size=66352   ' 02 Headbangers Kit'
    ...
    [ 9] 0x0ad8a0 size=469448  ' 10 Mini Kit'

路径字段：
  每个采样记录里存的是【绝对路径】+ NUL + 采样名 + NUL。
  插件不做任何按文件名搜索（唯一的 FindFirstFileA 是文件对话框用的）。
  所以路径不对就永远加载不了。

  原始路径（别人机器上的）：
    C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\
    Start Menu\Programs\Steinberg\LM-4 MarkII\...
  已全部改写为：
    C:\Program Files (x86)\Steinberg\VstPlugins\LM-4 MarkII\...
  共修正 2071 处，覆盖 33 个文件。

----------------------------------------------------------------
7. 已修补 / 未修补一览
----------------------------------------------------------------
已修补（共 6 处，详见 01_原始与修补/补丁清单.txt）

  1) 加载即崩 —— NeoLite 壳把 .text 设为 PAGE_READWRITE
     文件偏移 0x3A16 / 0x3AA8 / 0x3D3C : 0x04 -> 0x40
     （详见本报告第 3 节）

  2) 加载失败且静默返回 NULL —— main() 内安装校验
     VA 0x1001B968 : 75 35 -> EB 35  (jne -> jmp)
     （详见本报告第 4 节）

  3) 分配 MIDI 输入端口后崩溃
     崩溃点 RVA 0x16144（mov edx,[ecx]，ecx = [this+0x184] = NULL）。
     0x10016120 被 19 处调用，其中只有 9 处检查返回值；
     改为在函数内部做成空值安全（[this+0x184] 为空时回退到
     [this+0x188]，两者都空则安全返回 0），19 个调用点全部安全。
     ★ 详见 07_MIDI崩溃修复/修复报告_MIDI崩溃.txt

     附带：该函数同样服务于**鼓垫参数**（索引 % 8 == 4 的各类参数），
     所以这一类崩溃一并解决。

  4) 调整鼓垫 Tune 旋钮崩溃
     鼓垫 Tune 路径 0x10014A68 把 [this+0x1DC]（采样管理器）传给
     0x100F4020 前未判空，而后者首条有效指令即 mov edx,[ecx+0x2AC]。
     全局 M. Tune 的同款路径（0x1488E）是有判空的，作者只漏了这条。
     修补：在 0x10014A68 插入 jecxz 保护（24 字节原地替换）。
     ★ 详见 08_Tune崩溃修复/修复报告_Tune崩溃.txt

未修补

  1) 程序名上限 20 个
     硬编码在 effGetProgramNameIndexed：
       0x100140b4  cmp eax, 0x14      ; 索引 >= 20 返回失败
       0x100140c0  mov ecx, [ecx + eax*4 + 0x188]   ; 20 个槽位
     Bank 解析处也有同样限制：
       0x100ee3b1  cmp eax, 0x14

  2) 手动加载的 .fxb 不显示程序名
     插件只在"启动加载默认库"路径（RVA 0x10013ef0）注册程序名，
     手动 Open bank file... 路径（RVA 0xe6740）不注册。

  3) 0xEDB42 处工厂返回值缺少 NULL 检查
     bank 初始化 0xED6E0 内：
       0xEDB37  mov eax, [edx+0x70]
       0xEDB3A  call eax
       0xEDB42  mov [edx+ebx*4+0x188], ecx   ; 未判空就存入
     当前已在读取端（0x10016120）兜底，源头未改。

  4) 两个 .fxb 无法通过拼接块来合并
     除头部程序数外，块之间的索引/偏移表也需重算，不建议手工合并。

8. 包内文件说明
----------------------------------------------------------------
【本仓库不包含任何可执行文件】

  原版与修补后的 DLL 均不在仓库内（版权原因）。
  自备原版 DLL 后可一键复现：
      python3 04_分析脚本/补丁工具/apply_all_fixes.py 原始.dll 输出.dll
  已知校验值：
      原始      MD5 29b5a2eaff617264fa589164ed23d4a0   579,032 字节
      修补后    MD5 9f48c98171df2efcbf4fbec8901eafef   579,032 字节

  解壳后的内存镜像同理不在仓库内，可由 04_分析脚本/模拟器/emu7.py 生成。

01_原始与修补/
  补丁清单.txt                 6 处修补的完整字节级说明

02_反汇编/壳代码/
  01_entry.asm                 壳入口与调度
  04_loader_main.asm           主加载器
  06_section_protect.asm       ★ 段权限设置循环（DEP 问题所在）
  11_lz_decompress.asm         自定义 LZ77 解压器
  …（共 14 个）

02_反汇编/解壳后/
  main_VSTPluginMain.asm       VST 入口（导出 main）
  DllMain.asm / CRT_startup.asm
  license_check.asm            安装校验（问题 2）
  license_drive_serial.asm     卷序列号/注册表读取
  license_key_derive.asm       密钥派生
  vst_dispatcher_low.asm       VST opcode 0..0x18
  vst_dispatcher_high.asm      VST opcode 0x19..0x44
  effGetProgramNameIndexed.asm 程序名查询（20 上限）
  startup_load_bank.asm        启动加载默认库
  load_bank.asm / parse_bank.asm  bank 解析
  AEffect_ctor.asm             AEffect 构造
  midi_program_name.asm        ★ MIDI 程序名查询（问题 3 的崩溃点）
  …（共 16 个）

03_内存镜像/
  内存布局.txt                 段布局、关键地址表、压缩流位置
  说明_如何生成镜像.txt        如何用 emu7.py 生成 unpacked_image.bin

04_分析脚本/
  模拟器/                      Unicorn 模拟器（跑壳、导出镜像）
  跟踪脚本/                    执行跟踪（构造函数、校验、main）
  补丁工具/
    apply_all_fixes.py         ★ 一键复现全部 6 处修补
    apply_patch.py             早期版本（仅段权限 + 安装校验）
    单元测试_MIDI补丁.py        ★ 问题 3 的 Unicorn 单元测试
    单元测试_Tune崩溃.py        ★ 问题 4 的 Unicorn 单元测试
    gen_dump.py / gen_stub_dump.py   反汇编生成脚本

05_预设路径修复/
  预设文件绝对路径改写与验证工具

06_用户文档/
  README_LM4.txt               面向使用者的中英双语说明

07_MIDI崩溃修复/
  修复报告_MIDI崩溃.txt        问题 3 的根因与修复（中英双语）

08_Tune崩溃修复/
  修复报告_Tune崩溃.txt        问题 4 的根因与修复（中英双语）

================================================================
【English】

  Compiled & patched by: TOLOC
  Analysis & binary patching: DeepSeek

  NOTE: If there is any discrepancy between the Chinese and English
  versions, the Chinese version shall prevail.

----------------------------------------------------------------
0. TL;DR
----------------------------------------------------------------
The DLL is packed with NeoLite. After unpacking, the stub sets the
whole .text section to PAGE_READWRITE (non-executable). Modern Windows
enables DEP by default, so jumping to the entry point raises an access
violation and the host reports a generic plugin error.
There is also a built-in installation check inside main() that fails
silently and returns NULL. Four bytes of patching fix both issues.

----------------------------------------------------------------
1. File layout (packed)
----------------------------------------------------------------
  Offset            Content
  0x0000 - 0x2FFF   placeholder data (mostly zeros, decoy)
  0x3000 - 0x5FFF   .neolit stub (NeoLite EP-!)
  0x6000 - 0x8D5D7  packed original (zlib streams + header)

In the PE header, .text has RawAddress = 0 and RawSize = 0xf9000,
i.e. the pointer points back at the file header itself. The real code
section occupies zero bytes on disk. This is not a loadable PE but a
NeoLite compression container.

----------------------------------------------------------------
2. Stub execution flow
----------------------------------------------------------------
1) DllMain (VA 0x102a81fa) -> jmp 0x102a82a5
2) Decrypt embedded API names (each byte XOR 0xFF)
3) CreateFileA + CreateFileMappingA + MapViewOfFile on itself,
   validate magic 0x04181996
4) Decompress a second-stage decompressor into .neolit
5) Decompress the original image using the embedded PE header and
   write it back to ImageBase + section VAs
6) Fix imports, relocations, TLS
7) VirtualProtect to set section permissions   <- the bug
8) jmp eax to ImageBase + OEP (0x100f8559)

----------------------------------------------------------------
3. Issue 1: DEP violation
----------------------------------------------------------------
The permission loop pushes a hard-coded 4 (PAGE_READWRITE):
  0x102a8a15  push 4

A later branch computes the correct value (EXECUTE_READ for code
sections) but is skipped because the comparison happens to be equal,
so the hard-coded 4 survives.

Patched:
  0x3a16, 0x3aa8, 0x3d3c : 0x04 -> 0x40 (PAGE_EXECUTE_READWRITE)

----------------------------------------------------------------
4. Issue 2: silent installation check failure
----------------------------------------------------------------
  0x1001b95e  call 0x1001e6c0    ; license check
  0x1001b966  test eax, eax
  0x1001b968  jne  0x1001b99f    ; pass -> continue
  0x1001b984  xor  eax, eax      ; fail -> return NULL

The check derives a fixed string "2523069250" from a built-in CRC table
and compares it against a decoded registry value
(HKLM\Software\Steinberg\LM4-MarkII\SetupSysID, each byte (b-8) XOR 1).

The error dialog never appears: the requested string resource ID (128)
does not exist, LoadStringA fails and MessageBoxA is skipped.
Hence a silent failure.

Patched:
  0x1001b968 : 75 35 -> EB 35   (jne -> jmp)

----------------------------------------------------------------
5. Patch summary (4 bytes total)
----------------------------------------------------------------
  0x3a16        0x04 -> 0x40    stub: make .text executable
  0x3aa8        0x04 -> 0x40    stub: same
  0x3d3c        0x04 -> 0x40    stub: same
  0x1001b968    75 35 -> EB 35  skip license check
                (compressed stream offset 0x13968)

The fourth byte lives inside the compressed .text stream, so the
stream has to be recompressed within its original size (0x46597).
zlib level 9, memLevel 7, default strategy yields 287998 bytes.

----------------------------------------------------------------
6. Preset file format
----------------------------------------------------------------
FXP / FXB are Steinberg private chunk formats.
  CcnK + ver + (FBCh | FPCh) + fxID("LM42") + fxVer + ...
  HaPa block = one program (kit); blocks are concatenated directly.
  Program name sits at block start + 0x7c, max 28 bytes.

Sample paths are stored as absolute paths; the plugin performs no
filename-based search, so a wrong path means the sample never loads.

----------------------------------------------------------------
7. Fixed / not fixed
----------------------------------------------------------------
Fixed (6 patches in total -- see 01_原始与修补/补丁清单.txt)

  1) Crash on load -- the NeoLite stub sets .text to PAGE_READWRITE
     file offsets 0x3A16 / 0x3AA8 / 0x3D3C : 0x04 -> 0x40
     (see section 3 of this report)

  2) Load failure with no error dialog -- the installation check in
     main() returns NULL silently
     VA 0x1001B968 : 75 35 -> EB 35  (jne -> jmp)
     (see section 4 of this report)

  3) Crash after assigning a MIDI input port
     Fault at RVA 0x16144 (mov edx,[ecx] with ecx = [this+0x184] = NULL).
     0x10016120 is called from 19 sites, only 9 of which check the
     return value; it was rewritten to be null-safe internally
     (falls back to [this+0x188] when [this+0x184] is null, and returns
     0 safely when both are null), making all 19 call sites safe.
     * See 07_MIDI崩溃修复/修复报告_MIDI崩溃.txt

     Note: the same function also serves **pad parameters**
     (any parameter index where index % 8 == 4), so that class of
     crash is covered too.

  4) Crash when turning a pad's Tune knob
     The pad Tune path at 0x10014A68 passes [this+0x1DC] (the sample
     manager) to 0x100F4020 without a null check, while that function
     starts with mov edx,[ecx+0x2AC]. The global M. Tune path
     (0x1488E) does check; only this one was missed.
     Fix: a jecxz guard inserted at 0x10014A68 (24 bytes, in place).
     * See 08_Tune崩溃修复/修复报告_Tune崩溃.txt

Not fixed

  1) Hard-coded limit of 20 programs
       0x100140b4  cmp eax, 0x14      ; index >= 20 fails
       0x100140c0  mov ecx, [ecx + eax*4 + 0x188]
     The bank parser has the same limit at 0x100ee3b1.

  2) Manually loaded banks do not register program names
     Names are only registered on the startup path (RVA 0x10013ef0),
     not on the manual "Open bank file..." path (RVA 0xe6740).

  3) Missing null check at 0xEDB42
     Inside bank init 0xED6E0 the factory result is stored into the
     program array without a null check. Currently guarded on the read
     side (0x10016120); the source is unchanged.

  4) Merging two .fxb banks by concatenating blocks does not work
     The index/offset tables also need recomputing. Not recommended.

----------------------------------------------------------------
8. Package contents
----------------------------------------------------------------
This repository contains **no executable files**.

  The original and patched DLLs are not included (copyright).
  Reproduce the patch from your own original DLL:
      python3 04_分析脚本/补丁工具/apply_all_fixes.py input.dll output.dll
  Known checksums:
      original  MD5 29b5a2eaff617264fa589164ed23d4a0   579,032 bytes
      patched   MD5 9f48c98171df2efcbf4fbec8901eafef   579,032 bytes

  The unpacked memory image is likewise not included; generate it with
  04_分析脚本/模拟器/emu7.py.

01_原始与修补/            patch list (byte-level, all 6 patches)
02_反汇编/                disassembly
  壳代码/                 NeoLite stub (entry, decompressor, section perms)
  解壳后/                 VST entry, dispatcher, bank parser, license check
03_内存镜像/              layout notes + how to generate the image
04_分析脚本/
  模拟器/                 Unicorn emulator (run the stub, dump the image)
  跟踪脚本/               execution tracing
  补丁工具/               apply_all_fixes.py + unit tests
05_预设路径修复/          preset path fixing tools
06_用户文档/              end-user README (bilingual)
07_MIDI崩溃修复/          issue 3 report (bilingual)
08_Tune崩溃修复/          issue 4 report (bilingual)

================================================================
