# Find where a part starts printing in mid-air: local height minima of the surface (z > 0.3) in PRINT orientation.
# A plateau of equal-z vertices is a minimum if every neighbour outside it is higher. pure python.
import sys
from collections import defaultdict
exec(open(__file__.replace('minima.py', 'stlbox.py')).read().split('T = tris')[0])
T = tris(sys.argv[1]); key = lambda p: (round(p[0], 3), round(p[1], 3), round(p[2], 3))
nb = defaultdict(set)
for t in T:
    k = [key(p) for p in t]
    for i in range(3):
        for j in range(3):
            if i != j: nb[k[i]].add(k[j])
seen = set(); out = []
for v in nb:
    if v in seen or v[2] < 0.3: continue
    comp, st, ok = [], [v], True
    seen.add(v)
    while st:
        a = st.pop(); comp.append(a)
        for b in nb[a]:
            if abs(b[2] - v[2]) < 1e-3:
                if b not in seen: seen.add(b); st.append(b)
            elif b[2] < v[2]: ok = False
    if ok:
        xs = [c[0] for c in comp]; ys = [c[1] for c in comp]
        out.append((v[2], min(xs), max(xs), min(ys), max(ys), len(comp)))
for o in sorted(out): print("z %.2f  x %.2f..%.2f  y %.2f..%.2f  (%d verts)" % o)
