================================================================
  Steinberg LM-4 MarkII — 逆向分析包
  Reverse Engineering Package
  整理 & 修补：TOLOC
  技术分析 & 二进制修补：DeepSeek
================================================================

【中文】

----------------------------------------------------------------
这个包里有什么
----------------------------------------------------------------
01_原始与修补/
    补丁清单.txt               6 处修补的完整说明
                               （DLL 不在仓库内，见下方"关于 DLL"）

02_反汇编/
    壳代码/                    NeoLite 壳的反汇编（14 个文件）
    解壳后/                    解壳镜像的反汇编（16 个文件）

03_内存镜像/
    unpacked_image.bin         完整解壳后的内存镜像（2.75 MB）
    内存布局.txt               段布局、关键地址表、压缩流位置

04_分析脚本/
    模拟器/                    Unicorn 模拟器（跑壳、验证补丁）
    跟踪脚本/                  执行跟踪（构造函数、校验、main）
    补丁工具/apply_all_fixes.py  ★ 一键复现（全部 6 处修补）
    补丁工具/单元测试_*.py        Unicorn 单元测试

05_预设路径修复/
    预设文件路径改写与验证工具
    README_参考方案与致谢.txt   ★ 已有的第三方方案（2021 年）

06_用户文档/
    README_LM4.txt             面向使用者的中英双语说明

07_MIDI崩溃修复/
    修复报告_MIDI崩溃.txt      MIDI 端口崩溃（含鼓垫参数）的根因与修复
08_Tune崩溃修复/
    修复报告_Tune崩溃.txt      鼓垫 Tune 旋钮崩溃的根因与修复
09_DEP说明/
    DEP说明_通俗版.txt         ★ 面向非技术读者的 DEP 解释（中英双语）
                               —— 可直接转发给他人
10_注册表说明/
    注册表说明.txt             ★ 插件需要的注册表项（重要！）
    LM4-MarkII_注册表.reg      ★ 一键导入（含 32/64 位两个视图）

README_逆向分析.txt            技术报告（问题原理、修补细节、格式分析）

----------------------------------------------------------------
关于 DLL（重要）
----------------------------------------------------------------
本仓库**不包含** DLL 文件（原版与修补版都没有），原因是版权。

复现方法：自备原版 LM-4 MarkII 的 LM4-MarkII.dll，然后在
04_分析脚本/补丁工具/ 目录下运行：

    python3 apply_all_fixes.py 原始.dll 输出.dll

脚本会校验输入、打上全部 6 处补丁、再校验输出。

已知校验值：
    原始 DLL    MD5 29b5a2eaff617264fa589164ed23d4a0   579,032 字节
    修补后 DLL  MD5 9f48c98171df2efcbf4fbec8901eafef   579,032 字节

如果脚本报「原字节不符」，说明你的原版与本文档分析的版本不同。

同样地，03_内存镜像/unpacked_image.bin 也不在仓库内，
可由 04_分析脚本/模拟器/emu7.py 生成（详见 README.md）。

----------------------------------------------------------------
从哪开始看
----------------------------------------------------------------
1. 只想用插件         -> 06_用户文档/README_LM4.txt
2. 想知道改了什么     -> README_逆向分析.txt + 01_原始与修补/补丁清单.txt
3. 想自己复现补丁     -> 04_分析脚本/补丁工具/apply_patch.py
4. 想继续深挖         -> 02_反汇编/ + 03_内存镜像/内存布局.txt

----------------------------------------------------------------
补丁一键复现
----------------------------------------------------------------
    python3 apply_patch.py LM4-MarkII_原始.dll 输出.dll

需要 Python 3（只用标准库 zlib / hashlib）。
脚本会自动验证输入 MD5，修补 4 个字节，并校验输出 MD5。
实测可精确复现出 MD5 = 58934923d98769019be0519cfecaab20

----------------------------------------------------------------
技术要点速览
----------------------------------------------------------------
问题 1  DEP 违规
  壳（NeoLite）解压后用 VirtualProtect 把整个 .text 设成
  PAGE_READWRITE（0x04，不可执行）。2003 年 32 位进程默认关闭
  DEP 所以没事；现代 Windows 开启 DEP 后跳到 OEP 即崩溃。
  修补：0x04 -> 0x40（3 处）

问题 2  安装校验静默失败
  main() 里的校验失败时返回 NULL，宿主拿不到 AEffect。
  而错误框因字符串资源 ID 不存在而弹不出来。
  修补：jne -> jmp（1 处，在压缩流内部）

已解决
  · 分配 MIDI 输入端口后崩溃 —— 07_MIDI崩溃修复/
  · 调整鼓垫 Tune 旋钮崩溃 —— 08_Tune崩溃修复/

**预设路径已经有现成方案**
  2021 年就有 https://github.com/nulla2011/fix-LM-4-MarkII 解决了
  同一个问题（预设里存死的绝对路径）。本仓库的重点是 DLL 的
  二进制修补，预设路径属附带产物。
  对照与致谢见 05_预设路径修复/README_参考方案与致谢.txt

**分发插件时不要忘记注册表**
  实测：某些电脑上即使使用修补后的 DLL，插件仍会被宿主禁用；
  导入 10_注册表说明/ 下的 .reg 后恢复正常。
  详见 10_注册表说明/注册表说明.txt

未解决问题
  · 程序名上限 20 个（硬编码 cmp eax, 0x14）
  · 手动加载的 .fxb 不注册程序名
  · 两个 .fxb 手工合并无效（索引表需重算）

----------------------------------------------------------------
免责声明
----------------------------------------------------------------
本包仅用于对 2003 年已停止支持的软件进行兼容性修复与学习研究。
LM-4 MarkII 及相关音色内容的版权归 Steinberg Media Technologies
及相应权利人所有。请勿用于商业分发。

================================================================
【English】

  Compiled & patched by: TOLOC
  Analysis & binary patching: DeepSeek

  NOTE: If there is any discrepancy between the Chinese and English
  versions, the Chinese version shall prevail.

----------------------------------------------------------------
Package contents
----------------------------------------------------------------
01_原始与修补/          original and patched DLL + patch list
02_反汇编/              disassembly (packer stub / unpacked image)
03_内存镜像/            full unpacked memory image + layout notes
04_分析脚本/            emulator, tracing scripts, patch tool
05_预设路径修复/        preset path fixing tools
                        (see README_参考方案与致谢.txt for prior art)
06_用户文档/            end-user README (bilingual)

README_逆向分析.txt     technical report

----------------------------------------------------------------
Where to start
----------------------------------------------------------------
1. Just want to use it     -> 06_用户文档/README_LM4.txt
2. Want to know the patch  -> README_逆向分析.txt + 补丁清单.txt
3. Want to reproduce it    -> 04_分析脚本/补丁工具/apply_patch.py
4. Want to dig deeper      -> 02_反汇编/ + 03_内存镜像/内存布局.txt

----------------------------------------------------------------
Reproduce the patch
----------------------------------------------------------------
    python3 apply_patch.py LM4-MarkII_原始.dll output.dll

Requires Python 3 (standard library only).
The script verifies the input MD5, patches 4 bytes, recompresses the
.text stream and validates the output MD5
(58934923d98769019be0519cfecaab20).

----------------------------------------------------------------
Summary of the two issues
----------------------------------------------------------------
1) DEP violation: the NeoLite stub sets the whole .text section to
   PAGE_READWRITE (0x04). Fine in 2003 (DEP off), fatal on modern
   Windows. Patch: 0x04 -> 0x40 in three places.

2) Silent installation-check failure inside main(): returns NULL, and
   the error dialog cannot appear because the requested string
   resource ID does not exist. Patch: jne -> jmp (1 byte inside the
   compressed .text stream).

Unresolved: MIDI input port crash, 20-program limit, no program names
for manually loaded banks, manual bank merging does not work.

----------------------------------------------------------------
Disclaimer
----------------------------------------------------------------
This package is for compatibility fixing and study of software that
was discontinued in 2003. LM-4 MarkII and its content are copyright
Steinberg Media Technologies and respective owners. Do not
redistribute commercially.

================================================================
