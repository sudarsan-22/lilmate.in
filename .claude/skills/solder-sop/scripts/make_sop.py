#!/usr/bin/env python3
"""Generate <project>/hardware/soldering_sop.png (+ .md) : wiring diagram, step panels, wire cut list.
usage: make_sop.py [project ...]   (default: all)"""
import sys,os,re,math
from PIL import Image,ImageDraw,ImageFont
ROOT=os.path.abspath(os.path.join(os.path.dirname(__file__),'../../../..'))
def F(s,b=False): return ImageFont.truetype('/usr/share/fonts/truetype/dejavu/DejaVuSans%s.ttf'%('-Bold' if b else ''),int(max(9,s)))
RED=(205,35,35);BLK=(35,35,35);ORG=(240,140,20);BLU=(35,95,225);YEL=(225,190,10);GRN=(40,160,70);PUR=(150,60,175);CYN=(20,165,180);BRN=(140,90,50);GRY=(200,204,212)
CN={RED:'red',BLK:'black',ORG:'orange',BLU:'blue',YEL:'yellow',GRN:'green',PUR:'purple',CYN:'cyan',BRN:'brown'}
# ---------------- product definitions ----------------
# comps: key -> (label, x,y, left pins, right pins); ESP/peripherals laid out by layout()
def product(P):
    sigs=[];periph=[]   # periph: (key,label,pins[(pin,kind)]) kind: vcc|gnd|sig:<espgpio>
    power=True; note=''
    oled=('oled','1.3" OLED (SH1106)',[('VCC','3v3'),('GND','gnd'),('SDA','sig:GPIO8:'+'B'),('SCL','sig:GPIO9:Y')]) if P!='desk_mini' else ('oled','0.96" OLED (SSD1306)',[('VCC','3v3'),('GND','gnd'),('SDA','sig:GPIO8:B'),('SCL','sig:GPIO9:Y')])
    touch=('touch','TTP223 touch pad',[('VCC','3v3'),('GND','gnd'),('I/O','sig:GPIO2:G')])
    yx=('yx','YX6300 MP3 module',[('VCC','5v'),('GND','gnd'),('RX','sig:GPIO21:G'),('TX','sig:GPIO20:P')])
    keys=('keys','4 key switches',[('K1','sig:GPIO0:G'),('K2','sig:GPIO1:P'),('K3','sig:GPIO3:C'),('K4','sig:GPIO4:N'),('COM','gnd')])
    enc=('enc','EC11 encoder',[('A','sig:GPIO5:G'),('B','sig:GPIO6:P'),('C (common)','gnd')])
    buz=('buz','Buzzer (passive 12 mm)',[('+','sig:GPIO7:G'),('-','gnd')])
    if P in('elephant','pengu_chubby'): periph=[oled,touch]
    elif P=='deck_buddy': periph=[oled]
    elif P=='music_player': periph=[oled,yx,keys,enc]
    elif P=='office_buddy': periph=[oled,buz,keys,enc]
    elif P=='desk_mini': periph=[oled,buz]; note='ASSUMED: ESP32-C3 Super Mini controller and the same battery chain. The Desk Mini source does not name its board: confirm before soldering.'
    if P=='office_buddy': note='GPIO numbers for keys, encoder and buzzer are PROPOSED (copied from the Music Player map, buzzer on spare GPIO7). Confirm against the firmware.'
    if P=='music_player': note='GPIO map is the provisional one from docs/components_L_retro_pc.md. ESP TX/RX to the YX6300 may need swapping in code.'
    if P in('elephant','pengu_chubby'): note='GPIO8/9 (I2C) are the ESP32-C3 defaults; TTP223 on GPIO2 follows minimo_bear.ino. Confirm against the firmware.'
    if P=='deck_buddy': note='Battery is not modelled in the Deck Buddy CAD: confirm where it sits. GPIO8/9 are the ESP32-C3 I2C defaults.'
    if P=='desk_mini': note=note+' Buzzer GPIO7 is proposed.'
    return periph,note
NAMES={'deck_buddy':'Deck Buddy','desk_mini':'Desk Mini v2','elephant':'Elephant (Ellie v3)','pengu_chubby':'Pengu Chubby v3','music_player':'Music Player (Retro PC v2)','office_buddy':'Office Buddy v1'}
KC={'B':BLU,'Y':YEL,'G':GRN,'P':PUR,'C':CYN,'N':BRN}
# ---------------- layout + wires ----------------
def build(P):
    periph,note=product(P)
    comps={};wires=[]   # wires: dict(a=(comp,pin),b=(comp,pin),color,step,route)
    comps['bat']=dict(label='Li-Po battery',x=10,y=100,w=150,h=80,L=[],R=['BAT+','BAT-'])
    comps['tp']=dict(label='TP4056 USB-C',x=240,y=70,w=170,h=130,L=['B+','B-'],R=['OUT+','OUT-'])
    comps['sw']=dict(label='Slide switch',x=240,y=260,w=170,h=80,L=[],R=['COM','ON'])
    sig=[];
    for k,l,pins in periph:
        for pin,kind in pins:
            if kind.startswith('sig'): sig.append((k,pin,kind))
    eh=70+32*len(sig)
    comps['esp']=dict(label='ESP32-C3 Super Mini',x=640,y=90,w=200,h=max(eh,150),L=['5V','3V3','GND'],R=[f"{s[2].split(':')[1]}" for s in sig])
    y=70;px=1110
    for k,l,pins in periph:
        h=46+30*len(pins); comps[k]=dict(label=l,x=px,y=y,w=230,h=h,L=[p for p,_ in pins],R=[]); y+=h+22
    H=max(y,comps['sw']['y']+120,comps['esp']['y']+comps['esp']['h']+40)+30
    def pin(c,name):
        d=comps[c]; 
        if name in d['L']: i=d['L'].index(name); n=len(d['L']); return (d['x'],d['y']+46+i*(d['h']-56)/max(n-1,1) if n>1 else d['y']+d['h']/2),'L'
        i=d['R'].index(name); n=len(d['R']); return (d['x']+d['w'],d['y']+46+i*(d['h']-56)/max(n-1,1) if n>1 else d['y']+d['h']/2),'R'
    if P in('desk_mini',): pass
    W=[]
    def wire(a,b,color,step,route,label=''): W.append(dict(a=a,b=b,color=color,step=step,route=route,label=label))
    # esp pins fixed positions
    ep={n:pin('esp',n) for n in comps['esp']['L']}
    # power chain
    wire(('bat','BAT+'),('tp','B+'),RED,2,'direct','battery red lead to B+')
    wire(('bat','BAT-'),('tp','B-'),BLK,2,'direct','battery black lead to B-')
    p_op=pin('tp','OUT+')[0];p_om=pin('tp','OUT-')[0];p_com=pin('sw','COM')[0];p_on=pin('sw','ON')[0]
    wire(('tp','OUT+'),('sw','COM'),RED,3,[p_op,(p_op[0]+22,p_op[1]),(p_op[0]+22,p_com[1]),p_com],'')
    p5=ep['5V'][0];p3=ep['3V3'][0];pg=ep['GND'][0]
    wire(('sw','ON'),('esp','5V'),RED,3,[p_on,(570,p_on[1]),(570,p5[1]),p5],'')
    wire(('tp','OUT-'),('esp','GND'),BLK,3,[p_om,(535,p_om[1]),(535,pg[1]),pg],'')
    # buses
    busx={'5v':985,'3v3':1010,'gnd':1035}; ry={'5v':22,'3v3':36,'gnd':50}; bx={'5v':(595,p5[1]),'3v3':(580,p3[1]),'gnd':(550,pg[1])}
    bcol={'5v':RED,'3v3':ORG,'gnd':BLK}
    used=set(kind for k,l,pins in periph for p,kind in pins if kind in busx)
    bottom=max(comps[k]['y']+comps[k]['h'] for k,_,_ in periph)
    buses={}
    for b in used:
        sx,sy=bx[b]; pinpos={'5v':p5,'3v3':p3,'gnd':pg}[b]
        buses[b]=dict(route=[(sx,sy),(sx,ry[b]),(busx[b],ry[b]),(busx[b],bottom)],color=bcol[b])
    sigx=[860+14*i for i in range(len(sig))]; si=0
    step_of={'oled':4,'touch':5,'yx':5,'keys':6,'enc':6,'buz':5}
    if P=='music_player': step_of={'oled':4,'yx':5,'keys':6,'enc':6}
    if P=='office_buddy': step_of={'oled':4,'buz':5,'keys':6,'enc':6}
    for k,l,pins in periph:
        for pn,kind in pins:
            pp=pin(k,pn)[0]
            if kind in busx:
                b=kind; wire((k,pn),('bus',b),bcol[b],step_of[k],[pp,(busx[b],pp[1])],'')
            else:
                _,g,c=kind.split(':'); e=pin('esp',g)[0]; mx=sigx[si]; si+=1
                wire((k,pn),('esp',g),KC[c],step_of[k],[e,(mx,e[1]),(mx,pp[1]),pp],'')
    return comps,W,buses,busx,H,note,pin
# ---------------- drawing ----------------
def draw(d,ox,oy,s,comps,W,buses,busx,pin,active=None,fonts=1.0):
    fp=F(13*s*fonts);fb=F(15*s*fonts,True);fs=F(11*s*fonts)
    P=lambda x,y:(ox+x*s,oy+y*s)
    # buses
    for b,bb in buses.items():
        pts=[P(*q) for q in bb['route']]; on=(active is None) or ('bus' in active)
        col=bb['color'] if (active is None or any(w['b'][1]==b and w['step'] in active for w in W if w['b'][0]=='bus') or 'allbus' in active) else GRY
        d.line(pts,fill=col,width=max(2,int(4*s)))
        for (x,y) in [bb['route'][0]]: d.ellipse([P(x,y)[0]-4*s,P(x,y)[1]-4*s,P(x,y)[0]+4*s,P(x,y)[1]+4*s],fill=col)
        lab={'5v':'5V splice','3v3':'3V3 splice','gnd':'GND splice'}[b]
        d.text(P(busx[b]-4,bb['route'][1][1]-16),lab,fill=col if col!=GRY else (120,120,120),font=fs)
    # wires
    for w in W:
        r=w['route']
        if r=='direct':
            a=pin(*w['a'])[0];b=pin(*w['b'])[0]; r=[a,(a[0]+40,a[1]),(a[0]+40,b[1]),b]
        on=(active is None) or (w['step'] in active)
        col=w['color'] if on else GRY; wd=max(2,int((5 if (active is not None and on) else 4)*s)) if on else max(1,int(2*s))
        d.line([P(*q) for q in r],fill=col,width=wd,joint='curve')
        if w['b'][0]=='bus':
            jx,jy=P(*r[-1]); d.ellipse([jx-4*s,jy-4*s,jx+4*s,jy+4*s],fill=col)
    # boxes
    for k,c in comps.items():
        x0,y0=P(c['x'],c['y']);x1,y1=P(c['x']+c['w'],c['y']+c['h'])
        d.rounded_rectangle([x0,y0,x1,y1],radius=int(8*s),fill=(246,248,252),outline=(40,60,100),width=max(2,int(2*s)))
        d.text((x0+8*s,y0+7*s),c['label'],fill=(20,30,70),font=fb)
        for side,names in (('L',c['L']),('R',c['R'])):
            for n in names:
                px,py=pin(k,n)[0]; X,Y=P(px,py)
                d.ellipse([X-4*s,Y-4*s,X+4*s,Y+4*s],fill=(40,60,100))
                t=n if not (k=='esp' and side=='R') else n
                tw=d.textlength(t,font=fp)
                d.text((X+8*s if side=='L' else X-8*s-tw,Y-8*s),t,fill=(30,30,30),font=fp)
STEPS={}
def steps_for(P,periph):
    ks=[k for k,_,_ in periph]
    names={'oled':'display','touch':'touch pad','yx':'MP3 module','keys':'keys','enc':'volume encoder','buz':'buzzer'}
    S=[(1,'PREPARE','Tools: iron 330-350 C, thin solder + flux, 28-30 AWG silicone wire (colours as in the table), 1.5 mm heat-shrink, tweezers, multimeter, tape. Cut every wire to the cut list, strip 2 mm, pre-tin each wire end and each pad/pin. Do not connect the battery yet.'),
       (2,'BATTERY TO CHARGER','Solder battery RED to TP4056 B+ and BLACK to B-. Check polarity twice (red = +). Slide heat-shrink over each joint. Keep the iron on a pad no longer than 3 s.'),
       (3,'POWER SWITCH AND ESP32 POWER','TP4056 OUT+ to switch COM; switch ON pin to ESP32 5V; TP4056 OUT- to ESP32 GND. TEST: plug USB-C into the TP4056 (charge LED on), switch ON, measure OUT+ to OUT- = 3.7-4.2 V, the ESP32 LED lights. Switch OFF.')]
    st=4
    S.append((4,'DISPLAY','Check the pin order on the OLED silkscreen first (it differs between modules). Solder VCC to 3V3, GND to GND, SDA to GPIO8, SCL to GPIO9. Join the GND and 3V3 wires of all parts into one splice each (twist, solder, heat-shrink) and run ONE wire from each splice to the ESP32 pad.'))
    if 'touch' in ks: S.append((5,'TOUCH PAD','TTP223: VCC to 3V3 splice, GND to GND splice, I/O to GPIO2. Keep this wire short and away from the display wires to avoid noise.'))
    if 'yx' in ks: S.append((5,'MP3 MODULE','YX6300: VCC to the 5V pin splice (switched battery), GND to GND, RX to GPIO21, TX to GPIO20. The 3.5 mm jack is the audio out. Do not power it from 3V3.'))
    if 'buz' in ks: S.append((5,'BUZZER','Passive buzzer: + to GPIO7, - to GND splice. Polarity matters for volume only.'))
    if 'keys' in ks: S.append((6,'KEYS AND ENCODER' if 'enc' in ks else 'KEYS','Each key switch: one leg to its GPIO (K1 to K4 as shown), the other legs share one common wire to the GND splice. EC11: A and B to their GPIOs, the middle pin C to GND splice. The encoder push switch is not used.'))
    S.append((7,'FINISH AND CHECK','Multimeter, battery connected, switch OFF: no beep between OUT+ and GND, none between B+ and B-. Insulate every splice and exposed pad, tape or glue wires with 30-50 mm slack so the lid closes. Then power on and test the display before closing the case.'))
    return S
def parse_centers(P):
    f=f'{ROOT}/{P}/hardware/components.md'; C={}
    if not os.path.exists(f): return C
    for l in open(f):
        m=re.match(r'\|\s*\d+\s*\|\s*([^|]+?)\s*\|\s*[^|]+\|\s*(-?[\d.]+)\.\.(-?[\d.]+)\s*\|\s*(-?[\d.]+)\.\.(-?[\d.]+)\s*\|\s*(-?[\d.]+)\.\.(-?[\d.]+)\s*\|',l)
        if m:
            n=m.group(1); v=[float(x) for x in m.groups()[1:]]
            C[n]=((v[0]+v[1])/2,(v[2]+v[3])/2,(v[4]+v[5])/2)
    return C
KEYMAP={'oled':'OLED','esp':'ESP32-C3','tp':'TP4056 USB-C','sw':'SS-12F15','bat':'Li-Po','touch':'TTP223','yx':'YX6300','keys':('Perfboard','Switch carrier'),'enc':'EC11','buz':'Buzzer'}
def center(C,key):
    pref=KEYMAP[key]; pref=(pref,) if isinstance(pref,str) else pref
    for n,c in C.items():
        if any(n.startswith(p) for p in pref) and 'plug zone' not in n and 'glass' not in n and 'knob' not in n.lower(): return c
    return None
def cutlen(C,a,b,default):
    ca,cb=center(C,a),center(C,b)
    if not ca or not cb: return default,False
    dd=math.dist(ca,cb)*1.2+15; return int(math.ceil(dd/5.0)*5),True
def make(P):
    comps,Wr,buses,busx,H,note,pin=build(P); periph,_=product(P); C=parse_centers(P)
    S=steps_for(P,periph)
    # wire table
    rows=[];seen=set()
    def add(n,a,b,color,step,length,calc):
        rows.append((n,a,b,CN[color],'%d mm%s'%(length,'' if calc else ' (set on assembly)'),step))
    n=1
    add(n,'Battery +','TP4056 B+',RED,2,35,False);n+=1
    add(n,'Battery -','TP4056 B-',BLK,2,35,False);n+=1
    L,c=cutlen(C,'tp','sw',50);add(n,'TP4056 OUT+','Switch COM',RED,3,L,c);n+=1
    L,c=cutlen(C,'sw','esp',50);add(n,'Switch ON','ESP32 5V',RED,3,L,c);n+=1
    L,c=cutlen(C,'tp','esp',30);add(n,'TP4056 OUT-','ESP32 GND',BLK,3,L,c);n+=1
    lab={'oled':'OLED','touch':'Touch','yx':'MP3','keys':'Key','enc':'Enc','buz':'Buzzer'}
    for w in Wr:
        k=w['a'][0]
        if k in('bat','tp','sw'): continue
        L,c=cutlen(C,k,'esp',40)
        tgt=('Splice '+w['b'][1].upper()) if w['b'][0]=='bus' else 'ESP32 '+w['b'][1]
        add(n,'%s %s'%(lab[k],w['a'][1]),tgt,w['color'],w['step'],L,c);n+=1
    # image
    CW=2000; s=0.82
    stepsN=len(S); cols=2; pw=int(CW/2-60); ps=pw/ (1500 if True else 1)
    ds=0.62  # diagram scale in step panels
    ph=int(H*(pw/1360*0.97))+66+14+120
    top=int(H*0.95)+210
    rowsN=math.ceil((stepsN)/cols)
    tableH=60+len(rows)*30+40
    img_h=top+rowsN*(ph+30)+tableH+260
    im=Image.new('RGB',(CW,img_h),'white'); d=ImageDraw.Draw(im)
    d.rectangle([0,0,CW,92],fill=(30,50,90))
    d.text((40,16),'%s - Soldering SOP'%NAMES[P],fill='white',font=F(40,True))
    d.text((40,66),'Follow the steps in order. Colours = wire colours. All sizes in mm. Power chain: battery > TP4056 > switch > ESP32.',fill=(200,215,240),font=F(16))
    y=110
    if note:
        d.rounded_rectangle([40,y,CW-40,y+44],radius=8,fill=(255,243,205),outline=(200,150,20))
        d.text((54,y+12),'CHECK: '+note,fill=(90,60,0),font=F(15,True)); y+=60
    d.text((40,y),'FULL WIRING DIAGRAM',fill=(20,30,70),font=F(22,True)); y+=34
    draw(d,40,y,0.95*min(1.0,(CW-80)/1360),comps,Wr,buses,busx,pin)
    y=top
    d.text((40,y-40),'SOLDER STEPS (highlighted wires = this step)',fill=(20,30,70),font=F(22,True))
    for i,(sn,title,text) in enumerate(S):
        cx=40+(i%cols)*(pw+40);cy=y+(i//cols)*(ph+30)
        d.rounded_rectangle([cx,cy,cx+pw,cy+ph],radius=10,fill=(250,251,254),outline=(150,160,180),width=2)
        d.ellipse([cx+12,cy+12,cx+54,cy+54],fill=(30,50,90)); d.text((cx+27-d.textlength(str(i+1),font=F(22,True))/2,cy+20),str(i+1),fill='white',font=F(22,True))
        d.text((cx+66,cy+20),title,fill=(20,30,70),font=F(21,True))
        active=None if sn==1 else ({sn} if sn<7 else None)
        if sn==7: active=set(range(1,8))
        draw(d,cx+8,cy+66,pw/1360*0.97,comps,Wr,buses,busx,pin,active=active,fonts=1.25)
        import textwrap
        ty=cy+66+int(H*pw/1360*0.97)+14
        for ln in textwrap.wrap(text,int(pw/9.6)): d.text((cx+16,ty),ln,fill=(30,30,30),font=F(15)); ty+=21
    y=y+rowsN*(ph+30)+10
    d.text((40,y),'WIRE CUT LIST',fill=(20,30,70),font=F(22,True)); y+=38
    cx=[40,100,420,760,900,1200,1320]
    for c_,t in zip(cx,['#','From','To','Colour','Length','Step']): d.text((c_,y),t,fill='white',font=F(15,True))
    d.rectangle([30,y-6,CW-30,y+24],fill=(30,50,90))
    for c_,t in zip(cx,['#','From','To','Colour','Length','Step']): d.text((c_,y),t,fill='white',font=F(15,True))
    y+=34
    colmap={v:k for k,v in CN.items()}
    for i,r in enumerate(rows):
        if i%2==0: d.rectangle([30,y-5,CW-30,y+23],fill=(238,243,250))
        d.text((cx[0],y),str(r[0]),font=F(15),fill=BLK);d.text((cx[1],y),r[1],font=F(15),fill=BLK);d.text((cx[2],y),r[2],font=F(15),fill=BLK)
        d.rectangle([cx[3],y+3,cx[3]+22,y+17],fill=colmap[r[3]]);d.text((cx[3]+30,y),r[3],font=F(15),fill=BLK)
        d.text((cx[4],y),r[4],font=F(15),fill=BLK);d.text((cx[5],y),str(r[5]),font=F(15),fill=BLK); y+=30
    y+=14
    d.text((40,y),'Lengths = distance between the parts in the CAD x 1.2 + 15 mm slack, rounded up to 5 mm. Trim after a dry fit.',fill=(90,90,90),font=F(14)); y+=34
    d.rounded_rectangle([40,y,CW-40,y+112],radius=10,fill=(255,236,236),outline=(200,60,60),width=2)
    for j,t in enumerate(['SAFETY: never reverse the battery, never short B+ to B-, keep the iron under 3 s per joint, ventilate, use flux.','Li-Po: do not puncture, do not heat the cell, remove the battery before desoldering anything on the TP4056.','Solder with the battery DISCONNECTED until step 3; disconnect it again for any later rework.','If the ESP32 gets hot or the charge LED flickers, unplug and recheck for shorts.']): d.text((56,y+10+j*24),t,fill=(120,20,20),font=F(15,True if j==0 else False))
    y+=140
    im=im.crop((0,0,CW,y)); out=f'{ROOT}/{P}/hardware/soldering_sop.png'; im.save(out)
    md=f'# {NAMES[P]} - soldering SOP\n\n![SOP](soldering_sop.png)\n\n'+('> '+note+'\n\n' if note else '')+'## Steps\n'+''.join(f'{i+1}. **{t}** - {x}\n' for i,(sn,t,x) in enumerate(S))+'\n## Wire cut list\n| # | From | To | Colour | Length | Step |\n|---|---|---|---|---|---|\n'+''.join('| '+' | '.join(str(v) for v in r)+' |\n' for r in rows)
    open(f'{ROOT}/{P}/hardware/soldering_sop.md','w').write(md); print(P,im.size)
if __name__=='__main__':
    for P in (sys.argv[1:] or list(NAMES)): make(P)
