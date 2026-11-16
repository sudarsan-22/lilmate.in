import sys,re
s=open(sys.argv[1]).read()
for d in re.findall(r' d="([^"]+)"',s):
    for sub in re.split(r'(?=M)',d):
        pts=[tuple(map(float,p)) for p in re.findall(r'(-?[\d.]+)[ ,](-?[\d.]+)',sub)]
        if len(pts)<3: continue
        xs=[p[0] for p in pts]; ys=[-p[1] for p in pts]
        A=sum(pts[i][0]*-pts[(i+1)%len(pts)][1]-pts[(i+1)%len(pts)][0]*-pts[i][1] for i in range(len(pts)))/2
        print(f"  loop n={len(pts):4d} area={A:8.1f}  x[{min(xs):6.1f},{max(xs):6.1f}] w={max(xs)-min(xs):5.1f}  y[{min(ys):6.1f},{max(ys):6.1f}] h={max(ys)-min(ys):5.1f}")
