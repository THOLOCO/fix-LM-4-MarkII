================================================================
  Steinberg LM-4 MarkII — 使用说明 / README
  32-bit VST2 Drum Sampler · Patched for modern DAWs
================================================================

【中文】

  整理 & 修补：TOLOC
  技术分析 & 二进制修补：DeepSeek


----------------------------------------------------------------
一、这是什么
----------------------------------------------------------------
Steinberg LM-4 MarkII，2003 年的 32 位 VST2 鼓采样器。
原版在现代 DAW（FL Studio / Cubase / Reaper 等）里无法加载，
本目录里的 LM4-MarkII.dll 已经修补，可以直接使用。

它需要 32 位宿主（或用桥接器把 32 位插件接进 64 位宿主）。

----------------------------------------------------------------
二、修补了什么
----------------------------------------------------------------
问题 1：壳把代码段设成不可执行
  原 DLL 被 NeoLite 加壳。壳解压后用 VirtualProtect 把整个 .text
  代码段设成 PAGE_READWRITE（可读可写但不可执行）。2003 年 32 位
  进程默认关闭 DEP，所以当年没事；现代 Windows 全部启用 DEP，
  壳跳到入口点就立刻触发访问冲突，宿主只能报"插件有问题"。

  修补：3 个字节，把硬编码的 0x04 改成 0x40（PAGE_EXECUTE_READWRITE）
    文件偏移 0x3a16 / 0x3aa8 / 0x3d3c

问题 2：自带的安装校验失败，且静默返回 NULL
  插件在 main() 里会做授权校验（读注册表 + 卷序列号）。校验失败时
  返回 NULL，宿主拿不到 AEffect，只能报"请确保正确安装"。
  而错误提示框本身弹不出来——代码请求的字符串资源 ID 不存在，
  LoadStringA 失败后跳过了 MessageBoxA，所以是静默失败。

  修补：1 个字节，把条件跳转改成无条件跳转
    0x1001b968 : 75 35 -> EB 35  (jne -> jmp)

----------------------------------------------------------------
三、目录结构
----------------------------------------------------------------
本目录（默认位置）：
  C:\Program Files (x86)\Steinberg\VstPlugins\LM-4 MarkII\

  LM4-MarkII.dll              修补后的插件（用这个）
  LM4-MarkII.dlld             原版备份（后缀已改，DAW 不会扫到）
  lm4mkIIdef.fxb              默认音色库 = Wizoo 10 个 Kit
  bkup.fxb                    原厂默认库（10 Mini Kit）备份

  01 Gator Kit.fxp  + 01 Gator Kit\        Wizoo Processed Studio Kits
  02 Headbangers Kit.fxp + 02 HeadBangers Kit\
  ... 03 ~ 09 ...
  10 Mini Kit.fxp + 10 Mini Kit\

  Wizoo Kits - Part2\Processed Studio Kits\   同上 10 个 Kit 的另一份
  Steinberg Kits\Vinyl Kits\                  黑胶 Kit（5 个 fxp + fxb）
  Steinberg Kits\LM4 original Kits\           原厂 10 个 Drumset
  BitBeats Kits\BitBeats Preset & Samples\    BitBeats（10 个 fxp + fxb）
  Set_Power Drums\                            4 个 LM4 脚本 txt + 采样

----------------------------------------------------------------
四、怎么用
----------------------------------------------------------------
1) 启动时自动加载
   插件启动会读同目录下的 lm4mkIIdef.fxb。
   现在这个文件是 Wizoo Processed Studio Kits（10 个 Kit），
   所以打开插件后 Program 列表里能看到：
     01 Gator Kit / 02 Headbangers Kit / 03 Loop Kit / 04 Reso Kit /
     05 Compressor Kit / 06 Mod Kit / 07 Big Arena Kit /
     08 Metallic Grunge Kit / 09 Small Ambience Kit / 10 Mini Kit
   直接用 Program 上下箭头切换即可。

2) 加载其他预设
   把 .fxp（单个 Kit）或 .fxb（音色库）拖到插件窗口上，
   或在宿主里用 Open preset file... / Open bank file...
   注意：手动加载的 .fxb 可能显示为 program0 / program1...
   （插件只在"启动加载默认库"这条路径上注册程序名，
     手动加载路径不注册，这是插件本身的限制，不是文件坏了）

3) 采样找不到怎么办
   .fxp / .fxb 里存的是绝对路径。当前所有预设都指向：
     C:\Program Files (x86)\Steinberg\VstPlugins\LM-4 MarkII\...
   所以只要采样文件夹在这个位置就不用管。
   万一报"Some Audio File(s) could not be found"：
     → 在插件界面上【右键点某个鼓垫】（不是右键空白处）
     → 选 Search in Directories...
     → 指向存放 .aif / .wav 的文件夹
   注意：这个菜单项只在插件检测到采样缺失时才出现。

4) 导入 Power Drums 脚本
   Set_Power Drums\ 里有 4 个 txt（LM4/LM9 Script 格式）。
   在插件界面【右键】→ Import LM4/LM9 Script... → 选 txt
   然后同样用右键鼓垫 → Search in Directories...
   指向 Set_Power Drums\Bitbeats Power Drums\

----------------------------------------------------------------
五、已知问题
----------------------------------------------------------------
1. 分配 MIDI 输入端口后崩溃  【已修复】
   在宿主里给插件分配 MIDI Input Port 后，播放或停止时曾会崩溃
   （崩溃点 RVA 0x16144，空指针解引用）。
   修复方式：把 MIDI 程序名查询函数 0x10016120 改写为空值安全版本，
   见 07_MIDI崩溃修复/修复报告_MIDI崩溃.txt。
   如果仍然崩溃，请反馈。

2. 调整鼓垫 Tune 旋钮崩溃  【已修复】
   鼓垫 Tune 路径（0x10014A68）调用采样管理器 0x100F4020 前忘了判空，
   而该函数第一条就是 mov edx,[ecx+0x2AC]，于是崩溃。
   全局 M. Tune 的同款路径是有判空的，作者只漏了这一条。
   修复方式：在调用点插入 jecxz 保护，
   见 08_Tune崩溃修复/修复报告_Tune崩溃.txt。

3. 程序名上限 20 个
   插件内部硬编码最多 20 个 program（cmp eax, 0x14）。
   超过的部分无法显示名字。

4. 手动加载的库没有名字
   见上面第 3 点说明，是插件设计如此。

5. 缺 5 个采样
   V-BassSounds-Bass1 / Bass2 / Bass4 / Bass6 / Bass13.wav
   这 5 个文件在整套音色包里都不存在（原作者归档盘上的），
   只影响 Vinyl Kits.fxb 和 Wizoo Processed Studio Kits.fxb
   里 11 处引用，其余采样不受影响。

----------------------------------------------------------------
六、注意事项
----------------------------------------------------------------
* 这是 32 位插件，需要 32 位宿主或桥接器。
  jBridger 等桥接器不能解决上面提到的修补问题（它不改段权限，
  也不影响插件内部校验），必须用本目录里修补过的 DLL。

* 采样文件夹的位置不要随意移动。移动后预设里的绝对路径会失效，
  需要重新用 Search in Directories... 定位。

* 目录名和文件名建议不要改（除了 LM4-MarkII.dll 这个名字）。
  插件对大小写不敏感，但名字要一致。

================================================================
【English】

  Compiled & patched by: TOLOC
  Analysis & binary patching: DeepSeek

  NOTE: If there is any discrepancy between the Chinese and English
  versions, the Chinese version shall prevail.


----------------------------------------------------------------
1. What is this
----------------------------------------------------------------
Steinberg LM-4 MarkII, a 32-bit VST2 drum sampler from 2003.
The original DLL cannot be loaded by modern DAWs (FL Studio, Cubase,
Reaper, etc.) due to the issues below. The LM4-MarkII.dll in this
folder has been patched and works out of the box.

Requires a 32-bit host, or a bit-bridge to use it in a 64-bit host.

----------------------------------------------------------------
2. What was patched
----------------------------------------------------------------
Issue 1: the packer marked the code section as non-executable
  The original DLL is packed with NeoLite. After unpacking, the stub
  calls VirtualProtect and sets the whole .text section to
  PAGE_READWRITE (readable/writable, but NOT executable).
  In 2003 32-bit processes had DEP off by default, so this was fine.
  Modern Windows enables DEP everywhere, so the moment the stub jumps
  to the entry point it raises an access violation and the host
  reports a generic "plugin error".

  Patch: 3 bytes, 0x04 -> 0x40 (PAGE_EXECUTE_READWRITE)
    file offsets 0x3a16 / 0x3aa8 / 0x3d3c

Issue 2: the built-in installation check failed silently
  The plugin performs a license check inside main() (reads the
  registry plus the volume serial number). On failure it returns NULL,
  so the host gets no AEffect and reports "please make sure the plugin
  is installed correctly".
  The error dialog itself never appears: the string resource ID the
  code asks for does not exist, LoadStringA fails, and the
  MessageBoxA call is skipped. Hence the silent failure.

  Patch: 1 byte, conditional jump -> unconditional
    0x1001b968 : 75 35 -> EB 35  (jne -> jmp)

----------------------------------------------------------------
3. Folder layout
----------------------------------------------------------------
Default location:
  C:\Program Files (x86)\Steinberg\VstPlugins\LM-4 MarkII\

  LM4-MarkII.dll              patched plugin (use this one)
  LM4-MarkII.dlld             original, renamed so DAWs ignore it
  lm4mkIIdef.fxb              default bank = Wizoo, 10 kits
  bkup.fxb                    original factory bank (10 Mini Kit)

  01 Gator Kit.fxp  + 01 Gator Kit\      Wizoo Processed Studio Kits
  02 Headbangers Kit.fxp + 02 HeadBangers Kit\
  ... 03 ~ 09 ...
  10 Mini Kit.fxp + 10 Mini Kit\

  Wizoo Kits - Part2\Processed Studio Kits\   same 10 kits, second copy
  Steinberg Kits\Vinyl Kits\                  vinyl kits (5 fxp + fxb)
  Steinberg Kits\LM4 original Kits\           factory drumsets
  BitBeats Kits\BitBeats Preset & Samples\    BitBeats (10 fxp + fxb)
  Set_Power Drums\                            four LM4 scripts + samples

----------------------------------------------------------------
4. How to use
----------------------------------------------------------------
1) Auto-loaded on startup
   The plugin reads lm4mkIIdef.fxb from its own folder at startup.
   That file is currently the Wizoo bank (10 kits), so the Program
   list shows:
     01 Gator Kit / 02 Headbangers Kit / 03 Loop Kit / 04 Reso Kit /
     05 Compressor Kit / 06 Mod Kit / 07 Big Arena Kit /
     08 Metallic Grunge Kit / 09 Small Ambience Kit / 10 Mini Kit
   Switch with the Program up/down arrows.

2) Loading other presets
   Drag a .fxp (single kit) or .fxb (bank) onto the plugin window,
   or use "Open preset file..." / "Open bank file..." in the host.
   Note: a manually loaded .fxb may show up as program0 / program1 ...
   The plugin only registers program names on the startup path, not on
   the manual-load path. This is a plugin limitation, not a broken file.

3) Missing samples
   .fxp / .fxb files store absolute paths. All presets currently point
   to:
     C:\Program Files (x86)\Steinberg\VstPlugins\LM-4 MarkII\...
   So as long as the sample folders stay there, nothing to do.
   If you get "Some Audio File(s) could not be found":
     -> right-click ON A PAD in the plugin UI (not on empty space)
     -> choose "Search in Directories..."
     -> point it to the folder containing the .aif / .wav files
   This menu item only appears when the plugin detects missing samples.

4) Importing the Power Drums scripts
   Set_Power Drums\ contains four txt files (LM4/LM9 script format).
   Right-click in the plugin -> "Import LM4/LM9 Script..." -> pick one.
   Then right-click a pad -> "Search in Directories..." and point it to
   Set_Power Drums\Bitbeats Power Drums\

----------------------------------------------------------------
5. Known issues
----------------------------------------------------------------
1. Crash after assigning a MIDI input port  [FIXED]
   This used to crash on playback/stop (null pointer dereference at
   RVA 0x16144). Fixed by rewriting the MIDI program-name lookup at
   0x10016120 into a null-safe version -- see
   07_MIDI崩溃修复/修复报告_MIDI崩溃.txt.
   If it still crashes, please report it.

2. Crash when turning a pad's Tune knob  [FIXED]
   The pad Tune path (0x10014A68) called the sample manager at
   0x100F4020 without a null check, while that function starts with
   mov edx,[ecx+0x2AC]. The global M. Tune path does check for null;
   the author only missed this one. Fixed with a jecxz guard -- see
   08_Tune崩溃修复/修复报告_Tune崩溃.txt.

3. Program name limit: 20
   Hard-coded in the plugin (cmp eax, 0x14). Anything beyond index 19
   cannot display a name.

4. Manually loaded banks show no names
   See item 3. Plugin behaviour, not a corrupt file.

5. Five samples are missing
   V-BassSounds-Bass1 / Bass2 / Bass4 / Bass6 / Bass13.wav
   These do not exist anywhere in the content set (lost on the original
   author's archive drive). They affect 11 references in
   Vinyl Kits.fxb and Wizoo Processed Studio Kits.fxb only.

----------------------------------------------------------------
6. Notes
----------------------------------------------------------------
* 32-bit plugin: needs a 32-bit host or a bit-bridge.
  jBridger and similar tools do NOT fix the problems above (they do not
  rewrite section permissions and do not touch the plugin's internal
  check). You must use the patched DLL in this folder.

* Do not move the sample folders. The presets store absolute paths;
  after moving you would have to relocate samples with
  "Search in Directories...".

* Keep folder and file names as they are (the only rename is
  LM4-MarkII.dll). Names are case-insensitive but must match.

================================================================
