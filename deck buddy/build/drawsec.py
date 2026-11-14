import re,sys
from PIL import Image, ImageDraw
def loops(f):
    s=open(f).read(); out=[]
    for d in re.findall(r' d="([^"]+)"',s):
        for sub in re.split(r'(?=M)',d):
            p=[tuple(map(float,q)) for q in re.findall(r'(-?[\d.]+)[ ,](-?[\d.]+)',sub)]
            if len(p)>2: out.append(p)
    return out
# window in svg coords: x = -bodyZ? we just auto-fit around the switch region
parts=[('build/c_body_orig.svg',(70,130,190)),('build/c_lid_new.svg',(240,150,30)),('build/c_switch_dummy.svg',(150,150,150))]
allp=[q for f,_ in parts for l in loops(f) for q in l]
cx,cy=[ (min(v)+max(v))/2 for v in zip(*[q for q in loops('build/c_switch_dummy.svg')[0]])]
S=22; W=H=760; img=Image.new('RGB',(W,H),'white'); d=ImageDraw.Draw(img)
def T(p): return (W/2+(p[0]-cx)*S, H/2+(p[1]-cy)*S)
for f,col in parts:
    L=loops(f)
    # draw outer loops then holes white (even-odd via area sign)
    def area(p): return sum(p[i][0]*p[(i+1)%len(p)][1]-p[(i+1)%len(p)][0]*p[i][1] for i in range(len(p)))/2
    sgn=area(max(L,key=lambda p:abs(area(p))))
    for p in sorted(L,key=lambda p:-abs(area(p))):
        d.polygon([T(q) for q in p], fill=col if area(p)*sgn>0 else 'white', outline=(0,0,0))
d.text((10,10),"Side cut at the switch centre (scale: 22 px = 1 mm). Orange = back lid, blue = yeti body, grey = SS-12F15",fill='black')
img.save(sys.argv[1])
