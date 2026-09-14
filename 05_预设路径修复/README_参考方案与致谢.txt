================================================================
  预设路径修复 —— 参考方案与致谢
  Preset path fixing — prior art and credits
  整理 & 修补：TOLOC
  技术分析 & 二进制修补：DeepSeek
================================================================

----------------------------------------------------------------
一、已经有一个现成的方案（2021 年）
----------------------------------------------------------------
在动手之前/之后都值得看一眼这个仓库：

    https://github.com/nulla2011/fix-LM-4-MarkII

  作者      nulla2011
  建立      2021-02-23
  最后提交  2022-01-05
  内容      4 个 Python 脚本 + 1 个预先修好的预设文件

它解决的是**和我们同一个问题**（预设里存死的绝对路径），
思路也一致。如果只是想修预设路径，这个仓库已经够用。

本仓库（TOLOC/DeepSeek）的工作重点是**另一条线**：DLL 本身的
二进制修补（DEP、安装校验、空指针崩溃）。预设路径部分属于
附带产物，在此把已有的第三方方案一并列出，便于对照与致谢。

----------------------------------------------------------------
二、它包含什么
----------------------------------------------------------------
    README.md                          一句话说明
    fix_LM-4_fxp.py                    批量改写 .fxp（主脚本）
    fix_LM-4_disk1_fxp.py              同上，针对 Disk 1 的另一批数据
    replace-relative-path-in-fxp.py    单个文件的路径替换示例
    get-fixed-reso-kit.py              在线下载 + 改写（输出 _fix.fxp）
    04_Reso_Kit_fix.fxp                预先修好的 Reso Kit（140,852 字节）

关键实现要点（README 提到"有个未知块"）：
    unknownBlock1 = 00 00 05 91 00 00 10 0C 00 00 00 00
    unknownBlock2 = 000000003F80000000000001000000003F800000...
    脚本在改写路径时会把这两块插回去，并重算记录长度。

注意：脚本里的目标路径是作者自己的 `E:\Steinberg\Vstplugins\...`，
直接跑需要先改成自己的安装位置。（我们的脚本会自动填好。）

----------------------------------------------------------------
三、和我们这边的关系
----------------------------------------------------------------
两者关注点不同，可以互补：

                        nulla2011        本仓库
  修 DLL（DEP/校验/崩溃）   —               ✅ 4 类问题、共 6 处修补
  修预设路径               ✅ 2021 年       ✅（附带）
  输出可直接用的 DLL        —               ✅（脚本一键生成）
  免注册表的分发方案         —               ✅ 10_注册表说明/

关于预设路径，两边的做法有一点区别，都可用：

  · nulla2011：重建整条记录（连长度字段一起重算），文件会变短
  · 本仓库    ：同样是重打包（repack_fxp.py），
                路径替换后让"名字"字段紧跟新路径、同步更新长度字段

  两者都把路径缩短后重算长度，因此都不会破坏文件结构。

----------------------------------------------------------------
四、致谢
----------------------------------------------------------------
感谢 nulla2011 在 2021 年就把预设路径这个问题解决了并公开出来。
本仓库的预设路径修复工具在排查过程中参考了该仓库对 FXP 记录
结构的观察。

================================================================
【English】

----------------------------------------------------------------
1. A ready-made solution already exists (2021)
----------------------------------------------------------------
Worth looking at before or alongside this work:

    https://github.com/nulla2011/fix-LM-4-MarkII

  Author       nulla2011
  Created      2021-02-23
  Last push    2022-01-05
  Contents     4 Python scripts + 1 pre-fixed preset

It solves the *same* problem we do (absolute paths baked into the
presets) and takes the same general approach. If all you need is the
preset paths fixed, that repository is already sufficient.

This repository (TOLOC/DeepSeek) focuses on a *different* line of
work: binary patching of the DLL itself (DEP, the installation check,
null-pointer crashes). Preset path fixing is a by-product here; the
prior solution is listed so the two can be compared, and as credit.

----------------------------------------------------------------
2. What it contains
----------------------------------------------------------------
    README.md                          one-line description
    fix_LM-4_fxp.py                    batch-rewrite .fxp (main)
    fix_LM-4_disk1_fxp.py              same, for the Disk 1 data set
    replace-relative-path-in-fxp.py    single-file example
    get-fixed-reso-kit.py              download + rewrite (writes _fix.fxp)
    04_Reso_Kit_fix.fxp                pre-fixed Reso Kit (140,852 bytes)

Two structural blocks the scripts re-insert when rewriting:
    unknownBlock1 = 00 00 05 91 00 00 10 0C 00 00 00 00
    unknownBlock2 = 000000003F80000000000001000000003F800000...
The record length is recomputed accordingly.

Note: the scripts target the author's own path
`E:\Steinberg\Vstplugins\...` and need editing before use.
(Ours fills in the correct path automatically.)

----------------------------------------------------------------
3. How the two relate
----------------------------------------------------------------
Different focus, complementary:

                        nulla2011        this repo
  DLL fixes (DEP/check/crash)  no         yes -- 6 patches, 4 issues
  Preset path fixing           yes (2021) yes (by-product)
  Ready-to-use DLL output      no         yes (one script)
  Distribution without registry no        yes (10_注册表说明/)

For the preset paths both approaches work:
  * nulla2011: rebuild the whole record (length field included);
               the file gets shorter
  * this repo: also a repack (repack_fxp.py) -- the path is replaced,
               the "name" field follows the new path, and the length
               field is updated to match
Both recompute the length, so neither corrupts the file structure.

----------------------------------------------------------------
4. Credits
----------------------------------------------------------------
Thanks to nulla2011 for solving and publishing the preset-path
problem back in 2021. This repository's preset tooling benefited from
that repository's observations about the FXP record layout.

================================================================
