import struct, re

d = open('out/lm4mkIIdef.fxb','rb').read()
print("文件大小:", len(d))
print("头部:")
for off in (0,4,8,0xc,0x10,0x14,0x18,0x1c):
    raw=d[off:off+4]
    txt=''.join(chr(x) if 32<=x<127 else '.' for x in raw)
    print("  +%02x %-10s BE=%-12d %r" % (off, raw.hex(), struct.unpack_from('>I',d,off)[0], txt))

print()
print("=== 程序名与块边界 ===")
NAMES = [' 01 Gator Kit',' 02 Headbangers Kit',' 03 Loop Kit',' 04 Reso Kit',' 05 Compressor Kit',
         ' 06 Mod Kit',' 07 Big Arena Kit',' 08 Metallic Grunge Kit',' 09 Small Ambience Kit',
         ' 10 Mini Kit','BB Content Kit4']
pos=[]
for nm in NAMES:
    pat=nm.encode(); j=0
    while True:
        j=d.find(pat,j)
        if j<0: break
        p=j-0x7c
        if p>=0 and d[p:p+4]==b'HaPa':
            pos.append((p,nm)); break
        j+=1
pos.sort()
for i,(p,nm) in enumerate(pos):
    end = pos[i+1][0] if i+1<len(pos) else len(d)
    print("  [%2d] %#08x size=%-7d %r" % (i,p,end-p,nm))

print()
print("=== 路径检查 ===")
ps = sorted(set(m.group().decode('latin-1') for m in re.finditer(rb'[A-Za-z]:\\[ -~]{3,}\.(?:aif|aiff|wav)', d)))
print("路径总数:", len(ps))
wiz = [p for p in ps if 'Wizoo' in p]
bb  = [p for p in ps if 'BitBeats' in p]
other = [p for p in ps if 'Wizoo' not in p and 'BitBeats' not in p]
print("  Wizoo   :", len(wiz))
print("  BitBeats:", len(bb))
print("  其他    :", len(other))
for p in other[:5]: print("     ", p)
print()
print("  BitBeats 路径样例:")
for p in bb[:3]: print("     ", p)
