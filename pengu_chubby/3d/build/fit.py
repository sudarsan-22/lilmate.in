import math, itertools
W=2.0  # wall
def head_inner_y(x,z,sx,rx,ry,top,bot,off):
    hx=max(0,abs(x)-sx)/(rx-off)
    if z>top[0]: hz=(z-top[0])/(top[1]-off)
    elif z<bot[0]: hz=(bot[0]-z)/(bot[1]-off)
    else: hz=0
    q=1-hx*hx-hz*hz
    return None if q<=0 else -(ry-off)*math.sqrt(q)
pcb=(35.4/2+0.25+0.5, 33.5/2+0.25+0.5)   # half sizes + bay clr + margin
best=[]
for half_w in [30,31,32]:
  for sx in [6,8,10,12]:
    rx=half_w-sx
    for ry in [26,27,28]:
      for (tz,trz,bz,brz) in [(2,22,-10,14),(3,22,-10,13),(4,21,-8,15),(2,23,-12,12),(3,21,-11,12),(4,20,-10,13),(5,20,-12,11)]:
        top=(tz,trz); bot=(bz,brz)
        H=tz+trz - (bz-brz)
        for vdz in [-3,-2,-1,0,1]:
          ys=[]
          ok=True
          for sxs,szs in itertools.product([-1,1],[-1,1]):
            y=head_inner_y(sxs*pcb[0], vdz+szs*pcb[1], sx,rx,ry,top,bot,W)
            if y is None: ok=False;break
            ys.append(y)
          if not ok: continue
          y_pcb_front=max(ys)        # pcb front must be behind all corner surfaces
          y_if=y_pcb_front-1.5        # glass front
          tunnel=ry-abs(y_if)         # from face centre to glass
          best.append((tunnel, half_w*2, H, ry, sx, top, bot, vdz, round(y_if,1)))
best.sort(key=lambda b:(b[1]*b[2]*b[3], b[0]))
print("tunnel  W   H  ry sx top bot vdz y_if")
print(len(best))
for b in sorted(best,key=lambda b:b[0])[:8]: print(b)
for b in [b for b in best if b[1]<=62][:0]: pass
sm=[b for b in best if b[0]<=12]; sm.sort(key=lambda b:(b[1]*b[2]*b[3])); [print("small",b) for b in sm[:8]]
