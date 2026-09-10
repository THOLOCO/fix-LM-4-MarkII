import struct, os

WZ = 'Wizoo Kits - Part2/Processed Studio Kits/Wizoo Processed Studio Kits.fxb'
BB = 'BitBeats Kits/BitBeats Preset & Samples/BitBeats Kits.fxb'

w = open(WZ,'rb').read()
b = open(BB,'rb').read()
print("Wizoo   :", len(w))
print("BitBeats:", len(b))

# --- Wizoo 程序块起始（HaPa + 名字校验）---
WNAMES = [' 01 Gator Kit',' 02 Headbangers Kit',' 03 Loop Kit',' 04 Reso Kit',' 05 Compressor Kit',
          ' 06 Mod Kit',' 07 Big Arena Kit',' 08 Metallic Grunge Kit',' 09 Small Ambience Kit',' 10 Mini Kit']
def find_blocks(d, names):
    res=[]
    for nm in names:
        pat=nm.encode(); j=0
        while True:
            j=d.find(pat,j)
            if j<0: break
            p=j-0x7c
            if p>=0 and d[p:p+4]==b'HaPa':
                res.append((p,nm)); break
            j+=1
    res.sort()
    return res

wb = find_blocks(w, WNAMES)
print("\nWizoo 块:")
for i,(p,nm) in enumerate(wb):
    end = wb[i+1][0] if i+1<len(wb) else len(w)
    print("  [%2d] %#08x size=%d  %r" % (i,p,end-p,nm))

# BitBeats 块3 = BB Content Kit4
BBNAMES = ['BB Content Kit1','BB Content Kit2','BB Content Kit3','BB Content Kit4','BB Content Kit5',
           'BB Content Kit6','BB Content Kit7','BB Mixtended Dry','BB Mixtended Overhead','BB Mixtended Room']
bb = find_blocks(b, BBNAMES)
print("\nBitBeats 块:")
for i,(p,nm) in enumerate(bb):
    end = bb[i+1][0] if i+1<len(bb) else len(b)
    print("  [%2d] %#08x size=%d  %r" % (i,p,end-p,nm))

# 取 Wizoo 全部 + BitBeats 块3(BB Content Kit4)
bb3_start = bb[3][0]
bb3_end   = bb[4][0]
blk4 = b[bb3_start:bb3_end]
print("\n追加块: %r size=%d" % (bb[3][1], len(blk4)))

head = w[:wb[0][0]]          # 头部 0x00..0x84a0
wiz_blocks = w[wb[0][0]:]    # 10 个块
out = bytearray(head + wiz_blocks + blk4)
print("新文件大小:", len(out))

# --- 修正头部 ---
# +04 (BE) = 文件大小 - 8
struct.pack_into('>I', out, 4, len(out)-8)
print("  +04 ->", struct.unpack_from('>I',out,4)[0])
# +1c (BE): Wizoo=9 (10个程序) -> 11个程序填 10
struct.pack_into('>I', out, 0x1c, 10)
print("  +1c ->", struct.unpack_from('>I',out,0x1c)[0])

os.makedirs('out', exist_ok=True)
open('out/lm4mkIIdef.fxb','wb').write(out)
print("\n写出 out/lm4mkIIdef.fxb")
