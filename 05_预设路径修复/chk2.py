import re, os

# 解析电脑上的真实目录树
ROOT='program files (x86)\\steinberg\\vstplugins\\lm-4 markii'
cur=''; have=set()
for line in open('/data/data/com.termux/files/home/lm4_real_tree.txt', encoding='latin-1'):
    line=line.rstrip('\n')
    if line.startswith('\\'):
        cur=line[1:].strip()
        if cur.lower().startswith(ROOT):
            cur=cur[len(ROOT):].lstrip('\\')
        continue
    m=re.match(r'\s+(.+?)\s+([A-Z]+)\s+(\d+)', line)
    if m:
        name=m.group(1).strip()
        if name in ('.','..'): continue
        p=((cur+'\\'+name) if cur else name).lstrip('\\')
        have.add(p.lower())

print("电脑上的文件条目:", len(have))

d=open('out/lm4mkIIdef.fxb','rb').read()
PREFIX='c:\\program files (x86)\\steinberg\\vstplugins\\lm-4 markii\\'
ok=0; missing=[]
for m in re.finditer(rb'[A-Za-z]:\\[ -~]{3,}\.(?:aif|aiff|wav)', d):
    p=m.group().decode('latin-1'); pl=p.lower()
    if pl.startswith(PREFIX):
        rel=pl[len(PREFIX):]
        if rel in have: ok+=1
        else: missing.append(rel)
    else:
        missing.append('[外部] '+p)

print("✅ 存在:", ok)
print("❌ 缺失:", len(missing))
seen=set()
for x in missing:
    if x in seen: continue
    seen.add(x); print("   ", x)
