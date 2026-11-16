# bbox + volume of an ASCII/binary STL (pure python)
import sys, struct
def tris(fn):
    d = open(fn, 'rb').read()
    if d[:5] == b'solid' and b'facet' in d[:400]:
        v = []
        for l in d.decode(errors='ignore').splitlines():
            l = l.strip()
            if l.startswith('vertex'): v.append(tuple(map(float, l.split()[1:])))
        return [v[i:i+3] for i in range(0, len(v), 3)]
    n = struct.unpack('<I', d[80:84])[0]; out = []
    for k in range(n):
        f = struct.unpack('<12f', d[84 + 50*k: 84 + 50*k + 48]); out.append([f[3:6], f[6:9], f[9:12]])
    return out
T = tris(sys.argv[1])
if not T: print('empty'); sys.exit()
xs = [p[0] for t in T for p in t]; ys = [p[1] for t in T for p in t]; zs = [p[2] for t in T for p in t]
vol = sum((a[0]*(b[1]*c[2]-b[2]*c[1]) - a[1]*(b[0]*c[2]-b[2]*c[0]) + a[2]*(b[0]*c[1]-b[1]*c[0]))/6 for a, b, c in T)
print('x %.2f..%.2f  y %.2f..%.2f  z %.2f..%.2f  vol %.3f mm3' % (min(xs), max(xs), min(ys), max(ys), min(zs), max(zs), vol))
