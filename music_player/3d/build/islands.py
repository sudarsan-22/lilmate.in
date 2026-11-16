# Layer island finder (what the slicer calls "floating regions"): rasterise each layer's cross-section and report
# connected regions that touch nothing in the layer below. usage: islands.py part.stl [layer] [px]   pure python.
import sys, math
from collections import defaultdict
exec(open(__file__.replace('islands.py', 'stlbox.py')).read().split('T = tris')[0])
T = tris(sys.argv[1]); LH = float(sys.argv[2]) if len(sys.argv) > 2 else 0.12; PX = float(sys.argv[3]) if len(sys.argv) > 3 else 0.15
xs = [p[0] for t in T for p in t]; ys = [p[1] for t in T for p in t]; zs = [p[2] for t in T for p in t]
x0, y0, z1 = min(xs), min(ys), max(zs); NX = int((max(xs) - x0)/PX) + 2; NY = int((max(ys) - y0)/PX) + 2
B = defaultdict(list)
for t in T:
    lo, hi = min(p[2] for p in t), max(p[2] for p in t)
    for k in range(int(lo/LH), int(hi/LH) + 2): B[k].append(t)
def layer(k):
    z = (k + 0.5)*LH; seg = []
    for t in B[k]:
        pts = []
        for i in range(3):
            a, b = t[i], t[(i + 1) % 3]
            if (a[2] - z)*(b[2] - z) < 0:
                f = (z - a[2])/(b[2] - a[2]); pts.append((a[0] + f*(b[0] - a[0]), a[1] + f*(b[1] - a[1])))
        if len(pts) == 2: seg.append(pts)
    rows = defaultdict(list)
    for (ax, ay), (bx, by) in seg:
        if ay == by: continue
        if ay > by: ax, ay, bx, by = bx, by, ax, ay
        for j in range(max(0, math.ceil((ay - y0)/PX - 0.5)), min(NY, math.ceil((by - y0)/PX - 0.5))):
            yc = y0 + (j + 0.5)*PX
            if ay <= yc < by: rows[j].append(ax + (yc - ay)/(by - ay)*(bx - ax))
    S = set()
    for j, cx in rows.items():
        cx.sort()
        for i in range(0, len(cx) - 1, 2):
            for q in range(max(0, int((cx[i] - x0)/PX + 0.5)), min(NX, int((cx[i + 1] - x0)/PX + 0.5))): S.add((q, j))
    return S
prev = layer(0); found = 0
for k in range(1, int(z1/LH)):
    cur = layer(k); seen = set()
    for p in cur:
        if p in seen: continue
        comp, st = [], [p]; seen.add(p)
        while st:
            a = st.pop(); comp.append(a)
            for d in ((1, 0), (-1, 0), (0, 1), (0, -1), (1, 1), (1, -1), (-1, 1), (-1, -1)):
                b = (a[0] + d[0], a[1] + d[1])
                if b in cur and b not in seen: seen.add(b); st.append(b)
        if not any((a[0] + dx, a[1] + dy) in prev for a in comp for dx in (-1, 0, 1) for dy in (-1, 0, 1)):
            qx = [a[0] for a in comp]; qy = [a[1] for a in comp]; found += 1
            print("ISLAND z %.2f  x %.1f..%.1f  y %.1f..%.1f  %.2f mm2" % ((k + 0.5)*LH, x0 + min(qx)*PX, x0 + (max(qx) + 1)*PX, y0 + min(qy)*PX, y0 + (max(qy) + 1)*PX, len(comp)*PX*PX))
    prev = cur
print("islands:", found)
