#!/usr/bin/env python3
"""Elephant: one illustrated PNG per soldering step -> elephant/hardware/sop/ . Pin/pad layouts of the boards are typical: match the printed labels on your boards."""
import os,re,math
from PIL import Image,ImageDraw,ImageFont
ROOT=os.path.abspath(os.path.join(os.path.dirname(__file__),'../../../..'))
OUT=ROOT+'/elephant/hardware/sop/'
def F(s,b=False): return ImageFont.truetype('/usr/share/fonts/truetype/dejavu/DejaVuSans%s.ttf'%('-Bold' if b else ''),int(s))
RED=(205,35,35);BLK=(35,35,35);ORG=(240,140,20);BLU=(35,95,225);YEL=(225,190,10);GRN=(40,160,70)
NAVY=(30,50,90);PCB=(30,125,80);GOLD=(222,182,70);SIL=(205,208,214)
# wire lengths from the generated cut list
L={}
for l in open(ROOT+'/elephant/hardware/soldering_sop.md'):
    m=re.match(r'\|\s*\d+\s*\|\s*([^|]+?)\s*\|\s*([^|]+?)\s*\|\s*\w+\s*\|\s*(\d+) mm',l)
    if m: L[(m.group(1),m.group(2))]=int(m.group(3))
def ln(a,b,default=0): return L.get((a,b),default)
W,H=1800,1200
def new(step,title,sub):
    im=Image.new('RGB',(W,H),'white');d=ImageDraw.Draw(im)
    d.rectangle([0,0,W,100],fill=NAVY)
    d.ellipse([30,16,88,74],fill='white');d.text((59-d.textlength(str(step),font=F(36,True))/2,24),str(step),fill=NAVY,font=F(36,True))
    d.text((110,14),'ELEPHANT - STEP %d: %s'%(step,title),fill='white',font=F(38,True));d.text((110,62),sub,fill=(200,215,240),font=F(18))
    return im,d
def bez(p0,c1,c2,p3,n=48):
    pts=[]
    for i in range(n+1):
        t=i/n;u=1-t
        pts.append((u**3*p0[0]+3*u*u*t*c1[0]+3*u*t*t*c2[0]+t**3*p3[0],u**3*p0[1]+3*u*u*t*c1[1]+3*u*t*t*c2[1]+t**3*p3[1]))
    return pts
def wire(d,p0,p3,col,c1=None,c2=None,label=None,w=9):
    c1=c1 or (p0[0],p0[1]+80); c2=c2 or (p3[0],p3[1]+80)
    pts=bez(p0,c1,c2,p3)
    d.line(pts,fill=(15,15,15),width=w+4,joint='curve');d.line(pts,fill=col,width=w,joint='curve')
    for q in (p0,p3): d.ellipse([q[0]-9,q[1]-9,q[0]+9,q[1]+9],fill=SIL,outline=(120,120,120),width=2)   # solder blobs
    if label:
        m=pts[len(pts)//2];tw=d.textlength(label,font=F(16,True))
        d.rounded_rectangle([m[0]-tw/2-8,m[1]-14,m[0]+tw/2+8,m[1]+14],radius=8,fill='white',outline=col,width=3);d.text((m[0]-tw/2,m[1]-10),label,fill=BLK,font=F(16,True))
def marker(d,p,n,dx=0,dy=0):
    x,y=p[0]+dx,p[1]+dy;d.ellipse([x-17,y-17,x+17,y+17],fill=(255,210,0),outline=BLK,width=3);d.text((x-d.textlength(str(n),font=F(20,True))/2,y-13),str(n),fill=BLK,font=F(20,True))
# ---------------- boards ----------------
def tp(d,x,y,s=15,hl=()):
    w,h=17*s,27*s
    d.rounded_rectangle([x,y,x+w,y+h],radius=8,fill=PCB,outline=(10,70,40),width=3)
    d.rounded_rectangle([x+w*0.28,y-s*1.2,x+w*0.72,y+s*3.8],radius=6,fill=SIL,outline=(110,110,110),width=3);d.text((x+w/2-d.textlength('USB-C',font=F(14,True))/2,y+s*0.6),'USB-C',fill=BLK,font=F(14,True))
    d.rectangle([x+s*1.6,y+s*5.6,x+s*3.6,y+s*6.6],fill=(220,40,40));d.rectangle([x+s*13.4,y+s*5.6,x+s*15.4,y+s*6.6],fill=(60,160,230))
    d.text((x+s*1.2,y+s*6.9),'CHRG',fill='white',font=F(11));d.text((x+s*12.8,y+s*6.9),'DONE',fill='white',font=F(11))
    d.rectangle([x+s*4,y+s*9,x+s*13,y+s*13],fill=(25,25,25));d.text((x+s*5,y+s*10.3),'TP4056',fill=(210,210,210),font=F(15,True))
    d.rectangle([x+s*4,y+s*15,x+s*8,y+s*17],fill=(25,25,25));d.rectangle([x+s*9.5,y+s*15,x+s*13,y+s*17],fill=(25,25,25))
    P={}
    for name,mx in (('B+',2.2),('B-',5.0),('OUT-',10.8),('OUT+',14.6)):
        px,py=x+mx*s,y+25*s;d.rectangle([px-s,py-s*1.2,px+s,py+s*1.2],fill=GOLD,outline=(150,110,20),width=2)
        d.text((px-d.textlength(name,font=F(14,True))/2,py-s*3.0),name,fill=(255,255,255),font=F(14,True));P[name]=(px,py+s*1.2)
    d.text((x,y-s*2.6),'TP4056 USB-C charger (17 x 27)',fill=NAVY,font=F(17,True))
    return P
ESP_L=['5V','GND','3V3','GPIO4','GPIO3','GPIO2','GPIO1','GPIO0'];ESP_R=['GPIO5','GPIO6','GPIO7','GPIO8','GPIO9','GPIO10','GPIO20','GPIO21']
def esp(d,x,y,s=16,hl=()):
    w,h=18*s,22*s
    d.rounded_rectangle([x,y,x+w,y+h],radius=8,fill=(35,40,48),outline=(10,10,10),width=3)
    d.rounded_rectangle([x+w*0.3,y-s*1.0,x+w*0.7,y+s*3.4],radius=6,fill=SIL,outline=(110,110,110),width=3);d.text((x+w/2-d.textlength('USB-C',font=F(14,True))/2,y+s*0.5),'USB-C',fill=BLK,font=F(14,True))
    d.rectangle([x+s*6,y+s*7,x+s*12,y+s*13],fill=(15,15,15),outline=(90,90,90));d.text((x+s*6.6,y+s*9.2),'ESP32-C3',fill=(200,200,200),font=F(13,True))
    P={}
    for i,n in enumerate(ESP_L):
        px,py=x+1.3*s,y+(5+i*2.1)*s*0.93;d.ellipse([px-s*0.55,py-s*0.55,px+s*0.55,py+s*0.55],fill=GOLD)
        c=n in hl;d.text((px+s*0.9,py-8),n,fill=(255,255,255) if not c else (255,230,80),font=F(12,c));P[n]=(px-s*0.55,py)
    for i,n in enumerate(ESP_R):
        px,py=x+w-1.3*s,y+(5+i*2.1)*s*0.93;d.ellipse([px-s*0.55,py-s*0.55,px+s*0.55,py+s*0.55],fill=GOLD)
        c=n in hl;t=d.textlength(n,font=F(12,c));d.text((px-s*0.9-t,py-8),n,fill=(255,255,255) if not c else (255,230,80),font=F(12,c));P[n]=(px+s*0.55,py)
    d.text((x,y-s*2.6),'ESP32-C3 Super Mini (18 x 22)',fill=NAVY,font=F(17,True))
    return P
def oled(d,x,y,s=11):
    w,h=35.4*s,33.5*s
    d.rounded_rectangle([x,y,x+w,y+h],radius=8,fill=(30,60,140),outline=(10,25,80),width=3)
    d.rectangle([x+s*0.5,y+s*4,x+w-s*0.5,y+s*28],fill=(8,8,8));d.rectangle([x+s*2,y+s*7,x+w-s*2,y+s*25],fill=(20,24,30),outline=(70,70,70))
    d.text((x+w/2-60,y+h/2-8),'1.3" OLED',fill=(180,180,180),font=F(17,True))
    P={}
    for i,n in enumerate(['GND','VCC','SCL','SDA']):
        px,py=x+w/2+(i-1.5)*2.54*s,y+h-s*1.6;d.ellipse([px-s*0.6,py-s*0.6,px+s*0.6,py+s*0.6],fill=GOLD)
        d.text((px-d.textlength(n,font=F(11,True))/2,py-s*2.7),n,fill='white',font=F(11,True));P[n]=(px,py+s*0.6)
    d.text((x,y-58),'1.3" OLED module (35.4 x 33.5)',fill=NAVY,font=F(17,True));d.text((x,y-34),'pin order varies: read YOUR silkscreen',fill=(200,30,30),font=F(14,True))
    return P
def battery(d,x,y,s=12):
    w,h=20*s,30*s
    d.rounded_rectangle([x,y,x+w,y+h],radius=10,fill=(200,205,215),outline=(110,115,125),width=3);d.text((x+w/2-70,y+h/2-14),'Li-Po 502030',fill=BLK,font=F(18,True));d.text((x+w/2-40,y+h/2+12),'3.7 V  ~300 mAh',fill=(70,70,70),font=F(14))
    d.rectangle([x+w-2,y+h*0.55-5,x+w+s*2.2,y+h*0.55+5],fill=RED);d.rectangle([x+w-2,y+h*0.72-5,x+w+s*2.2,y+h*0.72+5],fill=BLK)
    d.text((x,y-s*2.4),'Battery 502030 (20 x 30 x 5)',fill=NAVY,font=F(17,True))
    return {'+':(x+w+s*2.2,y+h*0.55),'-':(x+w+s*2.2,y+h*0.72)}
def switch(d,x,y,s=24):
    w,h=10.5*s*0.55,4.5*s*0.55*1.6
    d.rounded_rectangle([x,y,x+10.5*s*0.7,y+4.5*s*0.7],radius=5,fill=(180,185,195),outline=(90,90,95),width=3)
    d.rectangle([x+10.5*s*0.7*0.45,y-12,x+10.5*s*0.7*0.45+3*s*0.5,y+4.5*s*0.7*0.35],fill=(60,60,70))
    P={};bw=10.5*s*0.7
    for i,n in enumerate(['unused','COM','ON']):
        px=x+bw*(0.14+0.36*i);d.rectangle([px-5,y+4.5*s*0.7,px+5,y+4.5*s*0.7+26],fill=GOLD);P[n]=(px,y+4.5*s*0.7+26)
        d.text((px-d.textlength(n,font=F(14,True))/2,y+4.5*s*0.7+34),n,fill=BLK,font=F(14,True))
    d.text((x,y-34),'SS-12F15 slide switch',fill=NAVY,font=F(17,True))
    return P
def touch(d,x,y,s=18):
    w,h=15*s,11*s
    d.rounded_rectangle([x,y,x+w,y+h],radius=8,fill=(40,100,190),outline=(10,40,100),width=3);d.ellipse([x+w*0.28,y+h*0.12,x+w*0.72,y+h*0.6],outline=(220,220,255),width=3);d.text((x+w/2-27,y+h*0.3),'TTP223',fill='white',font=F(14,True))
    P={}
    for i,n in enumerate(['I/O','VCC','GND']):
        px=x+w/2+(i-1)*2.54*s*0.8;py=y+h-s*0.9;d.ellipse([px-8,py-8,px+8,py+8],fill=GOLD);d.text((px-d.textlength(n,font=F(13,True))/2,py-30),n,fill='white',font=F(13,True));P[n]=(px,py+8)
    d.text((x,y-30),'TTP223 touch pad (15 x 11)',fill=NAVY,font=F(17,True))
    return P
def panel(d,items,title='WHAT TO DO',x0=1230,y0=125,w=540):
    d.rounded_rectangle([x0,y0,x0+w,H-30],radius=12,fill=(248,250,254),outline=(150,160,180),width=2)
    d.text((x0+20,y0+14),title,fill=NAVY,font=F(24,True));y=y0+60
    import textwrap
    for i,(kind,t) in enumerate(items):
        if kind=='n':
            n=sum(1 for k,_ in items[:i+1] if k=='n');d.ellipse([x0+18,y,x0+50,y+32],fill=(255,210,0),outline=BLK,width=2);d.text((x0+34-d.textlength(str(n),font=F(18,True))/2,y+4),str(n),fill=BLK,font=F(18,True));tx=x0+62
        elif kind=='!': d.text((x0+18,y),'!',fill=(200,30,30),font=F(24,True));tx=x0+62
        else: d.text((x0+22,y),'-',fill=NAVY,font=F(20,True));tx=x0+62
        lines=textwrap.wrap(t,int((w-90)/10.2))
        for l in lines: d.text((tx,y+2),l,fill=(200,30,30) if kind=='!' else (30,30,30),font=F(17,kind=='!'));y+=24
        y+=12
    return y
def legend(d,x,y):
    d.text((x,y),'WIRE COLOURS',fill=NAVY,font=F(16,True))
    for i,(c,n) in enumerate(((RED,'+ / 5V'),(BLK,'GND / -'),(ORG,'3V3'),(BLU,'SDA'),(YEL,'SCL'),(GRN,'signal'))):
        d.rectangle([x+i*120,y+26,x+i*120+26,y+44],fill=c);d.text((x+i*120+32,y+26),n,fill=BLK,font=F(14))
def zoom(d,cx,cy,r,title,wirecol):
    d.ellipse([cx-r,cy-r,cx+r,cy+r],fill=(236,246,238),outline=NAVY,width=4)
    d.rectangle([cx-r*0.55,cy+r*0.1,cx+r*0.55,cy+r*0.45],fill=GOLD,outline=(150,110,20),width=3)
    d.line([cx-r*0.9,cy-r*0.45,cx-r*0.1,cy+r*0.1],fill=(15,15,15),width=26);d.line([cx-r*0.9,cy-r*0.45,cx-r*0.1,cy+r*0.1],fill=wirecol,width=18)
    d.polygon([(cx-r*0.25,cy+r*0.12),(cx+r*0.25,cy+r*0.12),(cx+r*0.1,cy-r*0.12),(cx-r*0.1,cy-r*0.1)],fill=SIL,outline=(120,120,120))   # solder fillet
    d.polygon([(cx+r*0.75,cy-r*0.7),(cx+r*0.18,cy-r*0.05),(cx+r*0.28,cy+r*0.02),(cx+r*0.85,cy-r*0.58)],fill=(120,120,128),outline=BLK)   # iron tip
    d.text((cx-d.textlength(title,font=F(15,True))/2,cy+r*0.56),title,fill=NAVY,font=F(15,True))
    d.text((cx-d.textlength('touch 2-3 s',font=F(14))/2,cy+r*0.76),'touch 2-3 s',fill=(60,60,60),font=F(14))
# ---------------- steps ----------------
def step1():
    im,d=new(1,'PREPARE','Tools, wires, and how to make one good solder joint. Do NOT connect the battery yet.')
    # tools row
    y=130;d.text((40,y),'TOOLS AND PARTS',fill=NAVY,font=F(24,True))
    def tool(x,name,draw):
        d.rounded_rectangle([x,y+44,x+190,y+210],radius=10,fill=(248,250,254),outline=(170,180,200),width=2);draw(x+95,y+110);d.text((x+95-d.textlength(name,font=F(15,True))/2,y+176),name,fill=BLK,font=F(15,True))
    tool(40,'Iron 330-350 C',lambda cx,cy:(d.rectangle([cx-70,cy-12,cx+10,cy+12],fill=(60,60,70)),d.polygon([(cx+10,cy-8),(cx+60,cy-2),(cx+60,cy+2),(cx+10,cy+8)],fill=(180,180,190))))
    tool(250,'Solder + flux',lambda cx,cy:(d.ellipse([cx-40,cy-40,cx+40,cy+40],outline=(120,120,128),width=10),d.ellipse([cx-12,cy-12,cx+12,cy+12],fill=(120,120,128))))
    tool(460,'Silicone wire 28-30',lambda cx,cy:[d.line([cx-60,cy+i*14-14,cx+60,cy+i*14-14],fill=c,width=9) for i,c in enumerate((RED,BLK,ORG))])
    tool(670,'Heat-shrink 1.5 mm',lambda cx,cy:(d.rounded_rectangle([cx-55,cy-14,cx+55,cy+14],radius=12,fill=(60,60,70)),d.rounded_rectangle([cx-35,cy-8,cx+35,cy+8],radius=8,fill=(30,30,36))))
    tool(880,'Multimeter',lambda cx,cy:(d.rounded_rectangle([cx-34,cy-52,cx+34,cy+52],radius=8,fill=(240,200,40),outline=BLK,width=3),d.rectangle([cx-24,cy-42,cx+24,cy-12],fill=(150,200,150)),d.ellipse([cx-18,cy+4,cx+18,cy+40],fill=(60,60,60))))
    tool(1090,'Tweezers + tape',lambda cx,cy:(d.line([cx-40,cy+40,cx+10,cy-40],fill=(120,120,128),width=8),d.line([cx-10,cy+40,cx+40,cy-40],fill=(120,120,128),width=8)))
    # joint technique
    y2=370;d.text((40,y2),'HOW TO MAKE ONE JOINT (4 moves)',fill=NAVY,font=F(24,True))
    labs=['1  Strip 2 mm,\ntwist, tin the wire','2  Tin the pad\n(touch 1 s, add solder)','3  Hold wire on pad,\ntouch iron 2-3 s','4  Remove iron, keep still\n3 s: shiny cone = good']
    for i in range(4):
        x=40+i*290;d.rounded_rectangle([x,y2+44,x+270,y2+300],radius=10,fill=(248,250,254),outline=(170,180,200),width=2);cx,cy=x+135,y2+150
        d.rectangle([cx-70,cy+30,cx+70,cy+60],fill=GOLD,outline=(150,110,20),width=2)
        if i==0: d.line([cx-110,cy-10,cx-20,cy-10],fill=RED,width=14);d.line([cx-20,cy-10,cx+40,cy-10],fill=SIL,width=10)
        if i==1: d.ellipse([cx-40,cy+14,cx+40,cy+44],fill=SIL,outline=(120,120,120))
        if i==2: d.line([cx-110,cy-30,cx-10,cy+25],fill=RED,width=14);d.polygon([(cx+90,cy-60),(cx+10,cy+18),(cx+22,cy+26),(cx+102,cy-48)],fill=(120,120,128),outline=BLK)
        if i==3: d.line([cx-110,cy-8,cx-10,cy+20],fill=RED,width=14);d.polygon([(cx-45,cy+34),(cx+45,cy+34),(cx+15,cy+5),(cx-15,cy+5)],fill=SIL,outline=(120,120,120));d.text((cx-30,cy-60),'GOOD',fill=GRN,font=F(18,True))
        for j,t in enumerate(labs[i].split('\n')): d.text((x+14,y2+232+j*22),t,fill=BLK,font=F(15,j==0))
    d.text((40,y2+312),'Bad joint = dull, ball-shaped blob or wire that moves: reheat, add a little flux, redo.',fill=(200,30,30),font=F(16,True))
    # cut list
    y3=720;d.text((40,y3),'CUT AND PRE-TIN THESE 12 WIRES (lengths from the Elephant CAD, trim after a dry fit)',fill=NAVY,font=F(24,True))
    rows=[('1','Battery + > TP4056 B+',RED,35),('2','Battery - > TP4056 B-',BLK,35),('3','TP4056 OUT+ > switch COM',RED,ln('TP4056 OUT+','Switch COM',80)),('4','Switch ON > ESP32 5V',RED,ln('Switch ON','ESP32 5V',75)),('5','TP4056 OUT- > ESP32 GND',BLK,ln('TP4056 OUT-','ESP32 GND',25)),
          ('6','OLED VCC > 3V3 splice',ORG,ln('OLED VCC','Splice 3V3',80)),('7','OLED GND > GND splice',BLK,ln('OLED GND','Splice GND',80)),('8','OLED SDA > ESP32 GPIO8',BLU,ln('OLED SDA','ESP32 GPIO8',80)),('9','OLED SCL > ESP32 GPIO9',YEL,ln('OLED SCL','ESP32 GPIO9',80)),
          ('10','Touch VCC > 3V3 splice',ORG,ln('Touch VCC','Splice 3V3',105)),('11','Touch GND > GND splice',BLK,ln('Touch GND','Splice GND',105)),('12','Touch I/O > ESP32 GPIO2',GRN,ln('Touch I/O','ESP32 GPIO2',105))]
    for i,(n,t,c,l) in enumerate(rows):
        col,row=divmod(i,6);x=40+col*880;y=y3+50+row*58
        d.rounded_rectangle([x,y,x+840,y+48],radius=8,fill=(248,250,254),outline=(170,180,200),width=2);d.rectangle([x+14,y+14,x+58,y+34],fill=c);d.text((x+72,y+11),'%s  %s'%(n,t),fill=BLK,font=F(18,True));d.text((x+700,y+11),'%s mm'%l,fill=NAVY,font=F(18,True))
    d.text((40,1120),'For every wire: strip 2 mm, twist, tin. Also tin the pads you will use. Keep the battery DISCONNECTED until step 3.',fill=(200,30,30),font=F(18,True))
    return im
def step2():
    im,d=new(2,'BATTERY TO CHARGER','Battery leads to the TP4056 B+ / B- pads. Polarity is the one mistake you cannot undo.')
    bt=battery(d,70,330);T=tp(d,560,215)
    wire(d,bt['+'],T['B+'],RED,c1=(bt['+'][0]+160,bt['+'][1]),c2=(T['B+'][0],T['B+'][1]+120),label='35 mm')
    wire(d,bt['-'],T['B-'],BLK,c1=(bt['-'][0]+200,bt['-'][1]+40),c2=(T['B-'][0],T['B-'][1]+170))
    marker(d,T['B+'],1,-34,-40);marker(d,T['B-'],2,34,-40)
    zoom(d,1010,820,150,'tinned lead on the pad',RED);legend(d,60,1090)
    panel(d,[('n','Slide a 10 mm piece of heat-shrink over each battery lead FIRST.'),('n','Battery RED lead to pad B+. Hold the pad with tweezers, touch 2-3 s.'),('n','Battery BLACK lead to pad B-.'),('n','Slide the heat-shrink over the joint and shrink it with the iron side.'),('!','Red = +. Check with the multimeter: pad B+ to the battery red lead is 0 ohm.'),('!','Never let B+ and B- touch. Cover the exposed pads when done.'),('-','Do not plug in USB yet.')])
    return im
def step3():
    im,d=new(3,'POWER SWITCH AND ESP32 POWER','Charger output goes through the slide switch to the ESP32. Then test the power.')
    T=tp(d,40,150,13);S=switch(d,520,520,24);E=esp(d,900,170,14,hl=('5V','GND'))
    r=(T['OUT+'][0]+5,T['OUT+'][1])
    wire(d,T['OUT+'],S['COM'],RED,c1=(T['OUT+'][0]+60,T['OUT+'][1]+150),c2=(S['COM'][0]-80,S['COM'][1]+80),label='%d mm'%ln('TP4056 OUT+','Switch COM',80))
    wire(d,S['ON'],E['5V'],RED,c1=(S['ON'][0]+150,S['ON'][1]+60),c2=(E['5V'][0]-150,E['5V'][1]-10),label='%d mm'%ln('Switch ON','ESP32 5V',75))
    wire(d,T['OUT-'],E['GND'],BLK,c1=(T['OUT-'][0]-10,T['OUT-'][1]+260),c2=(E['GND'][0]-260,E['GND'][1]+60),label='%d mm'%ln('TP4056 OUT-','ESP32 GND',25))
    marker(d,T['OUT+'],1,28,-34);marker(d,S['COM'],2,0,50);marker(d,S['ON'],3,40,40);marker(d,E['5V'],4,-44,-26);marker(d,T['OUT-'],5,-34,-34);marker(d,E['GND'],6,-44,28)
    # multimeter test
    mx,my=330,880
    d.line([(mx+40,my),(T['OUT+'][0]-8,T['OUT+'][1]+30)],fill=RED,width=5);d.line([(mx+110,my),(T['OUT-'][0]+8,T['OUT-'][1]+30)],fill=BLK,width=5)
    d.rounded_rectangle([mx,my,mx+150,my+240],radius=14,fill=(240,200,40),outline=BLK,width=4);d.rectangle([mx+14,my+16,mx+136,my+80],fill=(160,205,160),outline=BLK,width=2);d.text((mx+26,my+28),'3.9 V',fill=BLK,font=F(34,True));d.ellipse([mx+40,my+110,mx+110,my+180],fill=(60,60,60),outline=BLK,width=3);d.text((mx+60,my+130),'V',fill='white',font=F(24,True))
    d.text((mx+170,my+30),'POWER TEST',fill=NAVY,font=F(22,True));d.text((mx+170,my+62),'USB-C in, switch ON:',fill=BLK,font=F(16));d.text((mx+170,my+84),'OUT+ to OUT- = 3.7 - 4.2 V',fill=BLK,font=F(16,True));d.text((mx+170,my+106),'red CHRG LED on while charging',fill=BLK,font=F(16))
    legend(d,40,1130)
    panel(d,[('n','TP4056 OUT+ to the middle pin of the switch (COM).'),('n','Switch pin ON (the side that is ON when the lever is toward the lid mark) to ESP32 5V pad.'),('n','TP4056 OUT- to ESP32 GND pad.'),('n','Connect the battery and plug USB-C into the TP4056. Switch ON.'),('n','Measure OUT+ to OUT-: 3.7 - 4.2 V, and the ESP32 LED lights. Switch OFF.'),('!','If the ESP32 gets hot or the CHRG LED flickers, unplug and look for a short.'),('-','The unused outer switch pin stays free: trim or insulate it.')])
    return im
def step4():
    im,d=new(4,'DISPLAY','OLED: VCC and GND go to splices, SDA and SCL go straight to the ESP32.')
    E=esp(d,150,300,16,hl=('GPIO8','GPIO9','3V3','GND'));O=oled(d,640,210)
    # splice blobs
    sp3=(60,900);spg=(150,960)
    for p,c,n in ((sp3,ORG,'3V3 splice'),(spg,BLK,'GND splice')):
        d.rounded_rectangle([p[0]-40,p[1]-16,p[0]+40,p[1]+16],radius=14,fill=(60,60,70));d.rounded_rectangle([p[0]-30,p[1]-9,p[0]+30,p[1]+9],radius=8,fill=c);d.text((p[0]-d.textlength(n,font=F(14,True))/2,p[1]+22),n,fill=BLK,font=F(14,True))
    wire(d,O['SDA'],E['GPIO8'],BLU,c1=(O['SDA'][0],O['SDA'][1]+140),c2=(E['GPIO8'][0]+300,E['GPIO8'][1]+60),w=8)
    wire(d,O['SCL'],E['GPIO9'],YEL,c1=(O['SCL'][0],O['SCL'][1]+110),c2=(E['GPIO9'][0]+240,E['GPIO9'][1]+40),w=8)
    wire(d,O['VCC'],(sp3[0]+30,sp3[1]-8),ORG,c1=(O['VCC'][0],O['VCC'][1]+130),c2=(sp3[0]+330,sp3[1]-40),label='%d mm'%ln('OLED VCC','Splice 3V3',80),w=8)
    wire(d,O['GND'],(spg[0]+30,spg[1]-8),BLK,c1=(O['GND'][0],O['GND'][1]+170),c2=(spg[0]+330,spg[1]-20),w=8)
    wire(d,(sp3[0]-30,sp3[1]-8),E['3V3'],ORG,c1=(sp3[0]-130,sp3[1]-150),c2=(E['3V3'][0]-130,E['3V3'][1]),w=8)
    wire(d,(spg[0]-30,spg[1]-8),E['GND'],BLK,c1=(spg[0]-200,spg[1]-250),c2=(E['GND'][0]-90,E['GND'][1]),w=8)
    marker(d,E['GPIO8'],1,40,-26);marker(d,E['GPIO9'],2,40,26);marker(d,E['3V3'],3,-40,34);marker(d,E['GND'],4,-40,-30);marker(d,O['SDA'],5,0,30);marker(d,O['SCL'],6,0,30)
    zoom(d,960,860,140,'OLED pad joint',BLU);legend(d,60,1130)
    panel(d,[('n','Read the labels on your OLED (GND VCC SCL SDA is typical; the order differs).'),('n','SDA to GPIO8 (blue), SCL to GPIO9 (yellow).'),('n','OLED VCC and GND: twist with the touch-pad wires later into one splice each (twist, solder, heat-shrink).'),('n','One wire from the 3V3 splice to the ESP32 3V3 pad, one from the GND splice to a GND pad.'),('n','Switch ON: the display should light and show the firmware screen (or stay dark if no sketch is loaded).'),('!','Keep the OLED wires 80 mm: the module sits in the visor bay, behind the face.'),('-','Solder the header side wires FROM THE BACK of the OLED pads.')])
    return im
def step5():
    im,d=new(5,'TOUCH PAD (TTP223)','Touch pad in the head: VCC and GND to the splices, I/O to GPIO2.')
    E=esp(d,640,180,16,hl=('GPIO2','3V3','GND'));Tc=touch(d,70,330)
    sp3=(120,820);spg=(260,860)
    for p,c,n in ((sp3,ORG,'3V3 splice'),(spg,BLK,'GND splice')):
        d.rounded_rectangle([p[0]-40,p[1]-16,p[0]+40,p[1]+16],radius=14,fill=(60,60,70));d.rounded_rectangle([p[0]-30,p[1]-9,p[0]+30,p[1]+9],radius=8,fill=c);d.text((p[0]-d.textlength(n,font=F(14,True))/2,p[1]+22),n,fill=BLK,font=F(14,True))
    wire(d,Tc['I/O'],E['GPIO2'],GRN,c1=(Tc['I/O'][0],Tc['I/O'][1]+200),c2=(E['GPIO2'][0]-220,E['GPIO2'][1]),label='%d mm'%ln('Touch I/O','ESP32 GPIO2',105))
    wire(d,Tc['VCC'],(sp3[0],sp3[1]-16),ORG,c1=(Tc['VCC'][0],Tc['VCC'][1]+150),c2=(sp3[0],sp3[1]-140),label='%d mm'%ln('Touch VCC','Splice 3V3',105),w=8)
    wire(d,Tc['GND'],(spg[0],spg[1]-16),BLK,c1=(Tc['GND'][0],Tc['GND'][1]+120),c2=(spg[0],spg[1]-130),w=8)
    wire(d,(sp3[0]+30,sp3[1]-8),E['3V3'],ORG,c1=(sp3[0]+300,sp3[1]-20),c2=(E['3V3'][0]-200,E['3V3'][1]),w=8)
    wire(d,(spg[0]+30,spg[1]-8),E['GND'],BLK,c1=(spg[0]+300,spg[1]+10),c2=(E['GND'][0]-120,E['GND'][1]),w=8)
    d.rounded_rectangle([1010,560,1180,660],radius=8,fill=(235,235,240),outline=(150,150,160),width=2);d.text((1022,572),'OLED wires',fill=(120,120,130),font=F(14,True));d.text((1022,596),'(step 4, also on',fill=(120,120,130),font=F(13));d.text((1022,614),'the same splices)',fill=(120,120,130),font=F(13))
    marker(d,Tc['I/O'],1,-30,34);marker(d,Tc['VCC'],2,0,36);marker(d,Tc['GND'],3,34,34);marker(d,E['GPIO2'],4,-40,-26)
    zoom(d,900,900,140,'pad joint',GRN);legend(d,60,1130)
    panel(d,[('n','TTP223 I/O to ESP32 GPIO2 (green).'),('n','TTP223 VCC: twist with the OLED VCC wire into the 3V3 splice. Heat-shrink the splice.'),('n','TTP223 GND: twist with the OLED GND wire into the GND splice. Heat-shrink.'),('n','Check: 3V3 splice to GND splice is NOT 0 ohm (no short).'),('!','Route the touch wire away from the OLED wires and keep the pad 1.6 mm under the skin (CAD).'),('-','Only one touch pad is built into the Elephant.')])
    return im
def step6():
    im,d=new(6,'FINISH AND CHECK','Test, insulate, then fit the parts in the order below.')
    d.text((40,125),'CHECKS (battery connected, switch OFF)',fill=NAVY,font=F(24,True))
    chk=[('Charger outputs','OUT+ to OUT- : no short (not 0 ohm)'),('Battery pads','B+ to B- : 3.7 - 4.2 V, NOT 0 ohm'),('I2C lines','GPIO8 to GND and GPIO9 to GND : not 0 ohm'),('Splices','3V3 splice to GND splice : not 0 ohm'),('Power on','Switch ON: ESP32 LED on, display lights')]
    for i,(a,b) in enumerate(chk):
        y=170+i*74;d.rounded_rectangle([40,y,1160,y+62],radius=10,fill=(248,250,254),outline=(170,180,200),width=2);d.ellipse([54,y+14,88,y+48],fill=(60,170,90));d.text((62,y+16),'ok',fill='white',font=F(18,True));d.text((106,y+8),a,fill=NAVY,font=F(19,True));d.text((106,y+32),b,fill=BLK,font=F(17))
    d.text((40,570),'INSULATE AND TIDY',fill=NAVY,font=F(24,True))
    tips=['Heat-shrink every splice and every battery/TP4056 joint; cover unused pads.','Leave 30-50 mm of slack on each wire so the lid closes and the parts can slide in.','A drop of hot glue on the OLED and TTP223 wires stops them pulling on the pads.','Twist the OLED SDA and SCL wires together loosely, away from the touch wire.']
    for i,t in enumerate(tips): d.text((60,615+i*34),'- '+t,fill=BLK,font=F(17))
    d.text((40,780),'FIT INTO THE ELEPHANT (order from the CAD)',fill=NAVY,font=F(24,True))
    order=['1  OLED into the visor bay (front shell, from behind); TTP223 pad in the head-top seat.','2  Battery into the floor bay (20.5 x 30.5), leads toward the back.','3  TP4056 and ESP32 slide in from the back opening along their slots (USB-C ends face the opening).','4  Slide switch snaps into its housing in the lid (z 61, back of the head).','5  Check the display once more, then snap the lid on (no screws).']
    for i,t in enumerate(order): d.text((60,825+i*36),t,fill=BLK,font=F(17))
    # side view crop from the enclosure fit sheet
    src=ROOT+'/elephant/docs/dimensions/elephant_enclosure_fit.png'
    if os.path.exists(src):
        c=Image.open(src).crop((676,138,990,556));c=c.resize((int(c.width*1.35),int(c.height*1.35)));im.paste(c,(1290,160));d.text((1290,125),'WHERE EACH PART SITS',fill=NAVY,font=F(20,True));d.text((1290,148),'(side view, front of the elephant at the left)',fill=(80,80,80),font=F(14))
        for i,nm in enumerate(['OLED glass','OLED PCB','ESP32-C3','ESP32 USB-C zone','TP4056','TP4056 USB-C zone','Li-Po battery','Slide switch','TTP223 touch pad']): d.text((1290+(i%2)*230,160+int(c.height)+20+(i//2)*26),'%d  %s'%(i+1,nm),fill=BLK,font=F(15))
    d.rounded_rectangle([40,1020,1160,1170],radius=10,fill=(255,236,236),outline=(200,60,60),width=2)
    for j,t in enumerate(['SAFETY: disconnect the battery before any rework on the TP4056 or ESP32.','Never reverse the battery, never short B+ to B-, keep the iron under 3 s per joint.','If something heats up or smells, unplug and stop.']): d.text((58,1038+j*34),t,fill=(120,20,20),font=F(18,j==0))
    return im
names=['step1_prepare','step2_battery_to_charger','step3_switch_and_power','step4_display','step5_touch_pad','step6_finish_and_check']
for n,f in zip(names,(step1,step2,step3,step4,step5,step6)):
    f().save(OUT+n+'.png');print(n)
