import sys, struct, math, glob
from collections import Counter
def load(f):
    d=open(f,'rb').read(); n=struct.unpack('<I',d[80:84])[0]; T=[]
    for i in range(n):
        v=struct.unpack('<12f',d[84+50*i:84+50*i+48])
        T.append((v[3:6],v[6:9],v[9:12]))
    return T
for f in sorted(glob.glob(sys.argv[1]+'/*.stl')):
    T=load(f); ids={}; E=Counter(); vol=0; down=0; xs=[];ys=[];zs=[]
    for t in T:
        k=[ids.setdefault(tuple(round(c,3) for c in p),len(ids)) for p in t]
        for a,b in ((0,1),(1,2),(2,0)): E[tuple(sorted((k[a],k[b])))]+=1
        A,B,C=t
        ux,uy,uz=B[0]-A[0],B[1]-A[1],B[2]-A[2]; vx,vy,vz=C[0]-A[0],C[1]-A[1],C[2]-A[2]
        nx,ny,nz=uy*vz-uz*vy,uz*vx-ux*vz,ux*vy-uy*vx; L=math.sqrt(nx*nx+ny*ny+nz*nz) or 1
        vol+=(A[0]*(B[1]*C[2]-B[2]*C[1])-A[1]*(B[0]*C[2]-B[2]*C[0])+A[2]*(B[0]*C[1]-B[1]*C[0]))/6
        if nz/L<-0.707 and (A[2]+B[2]+C[2])/3>0.3: down+=L/2
        for p in t: xs.append(p[0]);ys.append(p[1]);zs.append(p[2])
    bad=sum(1 for c in E.values() if c!=2)
    print(f"{f.split('/')[-1]:30s} {max(xs)-min(xs):5.1f}x{max(ys)-min(ys):5.1f}x{max(zs)-min(zs):5.1f}  vol {vol/1000:5.1f}cm3  bad-edges {bad:4d}  >45deg overhang {down:5.0f}mm2")
