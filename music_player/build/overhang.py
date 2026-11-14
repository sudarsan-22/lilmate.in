# Overhang scan for a part in PRINT orientation: downward-facing facets (normal z < -0.72, i.e. > ~44 deg)
# that are not on the bed. Clusters them (2 mm cells) and reports area, height, bbox. pure python.
import sys, math
from collections import defaultdict
exec(open(__file__.replace('overhang.py', 'stlbox.py')).read().split('T = tris')[0])
T = tris(sys.argv[1]); lim = float(sys.argv[2]) if len(sys.argv) > 2 else -0.72
cells = defaultdict(lambda: [0.0, 1e9, -1e9, 1e9, -1e9, 1e9, 0])
for a, b, c in T:
    u = [b[i]-a[i] for i in range(3)]; v = [c[i]-a[i] for i in range(3)]
    n = [u[1]*v[2]-u[2]*v[1], u[2]*v[0]-u[0]*v[2], u[0]*v[1]-u[1]*v[0]]; L = math.sqrt(sum(x*x for x in n))
    if L < 1e-12: continue
    nz = n[2]/L; zmin = min(a[2], b[2], c[2])
    if nz > lim or zmin < 0.3: continue
    cx = (a[0]+b[0]+c[0])/3; cy = (a[1]+b[1]+c[1])/3
    k = (int(cx//2), int(cy//2), int(zmin//1))
    e = cells[k]; e[0] += L/2; e[1] = min(e[1], cx); e[2] = max(e[2], cx); e[3] = min(e[3], cy); e[4] = max(e[4], cy); e[5] = min(e[5], zmin); e[6] = max(e[6], 1 if nz < -0.99 else 0)
# merge neighbouring cells
keys = list(cells); par = {k: k for k in keys}
def f(k):
    while par[k] != k: par[k] = par[par[k]]; k = par[k]
    return k
for k in keys:
    for d in [(1,0,0),(0,1,0),(0,0,1),(1,1,0),(1,-1,0)]:
        q = (k[0]+d[0], k[1]+d[1], k[2]+d[2])
        if q in cells: par[f(q)] = f(k)
G = defaultdict(lambda: [0.0, 1e9, -1e9, 1e9, -1e9, 1e9, 0])
for k, e in cells.items():
    g = G[f(k)]; g[0] += e[0]; g[1] = min(g[1], e[1]); g[2] = max(g[2], e[2]); g[3] = min(g[3], e[3]); g[4] = max(g[4], e[4]); g[5] = min(g[5], e[5]); g[6] = max(g[6], e[6])
rows = sorted(G.values(), key=lambda g: -g[0])
for g in rows[:12]:
    print('  %6.1f mm2  z %5.1f  x %6.1f..%6.1f  y %6.1f..%6.1f  %s' % (g[0], g[5], g[1], g[2], g[3], g[4], 'flat' if g[6] else ''))
print('  total %.0f mm2 in %d clusters' % (sum(g[0] for g in rows), len(rows)))
