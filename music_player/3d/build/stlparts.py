# connected pieces of an STL with bbox + volume (pure python)
import sys, struct
from collections import defaultdict
exec(open(__file__.replace('stlparts.py', 'stlbox.py')).read().split('T = tris')[0])
T = tris(sys.argv[1]); idx = {}; par = []
def vid(p):
    k = tuple(round(c, 3) for c in p)
    if k not in idx: idx[k] = len(par); par.append(len(par))
    return idx[k]
def f(a):
    while par[a] != a: par[a] = par[par[a]]; a = par[a]
    return a
TT = [[vid(p) for p in t] for t in T]
for a, b, c in TT: par[f(b)] = f(a); par[f(c)] = f(a)
grp = defaultdict(list)
for t, ti in zip(T, TT): grp[f(ti[0])].append(t)
for g in grp.values():
    xs = [p[0] for t in g for p in t]; ys = [p[1] for t in g for p in t]; zs = [p[2] for t in g for p in t]
    vol = sum((a[0]*(b[1]*c[2]-b[2]*c[1]) - a[1]*(b[0]*c[2]-b[2]*c[0]) + a[2]*(b[0]*c[1]-b[1]*c[0]))/6 for a, b, c in g)
    print('  x %6.2f..%6.2f  y %6.2f..%6.2f  z %6.2f..%6.2f  vol %.3f' % (min(xs), max(xs), min(ys), max(ys), min(zs), max(zs), vol))
