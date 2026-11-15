"""Make per-product preview PNG, 1:1 paper dieline PDF (A4 tiles) and cutting guide for the box templates."""
import sys,os,subprocess,math,re
S=os.environ['SCR']; sys.path.insert(0,S)
from fit import tris,F
from tprev import preview
from PIL import Image,ImageDraw
R='/home/sudarsan/Documents/crazy_projects/lilmate_3D_design/'
src=open(S+'/box.py').read().split('for k,P in PR.items(): sheet(k,P)')[0]
ns={'__file__':S+'/box.py'}; exec(src,ns)
dieline=ns['dieline']; dashed=ns['dashed']; KR=ns['KR']; INK=ns['INK']
PROD={'deck_buddy':('Deck Buddy',98,98,71),'desk_mini':('Desk Mini v2',70,68,63),'elephant':('Elephant (Ellie v3)',129,115,91)}
for k,(name,Lo,Wo,Ho) in PROD.items():
    out=R+'packaging/%s/template/'%k
    stl=S+'/asm_%s.stl'%k
    subprocess.run(['openscad','-D','part="assembly_keys"','-D','Lo=%d'%Lo,'-D','Wo=%d'%Wo,'-D','Ho=%d'%Ho,'-o',stl,R+'packaging/template/box_template.scad'],capture_output=True)
    # preview: tiles and keys separated by colour (keys are the small ones: height < thick)
    from fit import tris as T2
    tl=[];ky=[]
    for t in T2(stl):
        zs=[q[2] for q in t]
        (ky if max(zs)>0 and max(zs)<=2.7 and False else tl).append(t)
    preview([(stl,(120,170,215))],out+'%s_template_preview.png'%k,name+' - cutting template (assembled, keys in place)','Lay on the cardboard, cut along the OUTER edges, score along the slots and the gaps between tiles. Box outside %d x %d x %d mm.'%(Lo,Wo,Ho),scale=2.0)
    # paper dieline PDF at 1:1 on A4 (210x297), tiled with 8 mm overlap
    dpi=150; mm=dpi/25.4
    sw=15+2*Lo+2*Wo; sh=18+2*Wo+Ho+18
    big=Image.new('RGB',(int((sw+30)*mm),int((sh+30)*mm)),'white'); d=ImageDraw.Draw(big)
    # dieline() draws with its own decorations; call it at scale mm
    dieline(d,15*mm,15*mm,mm,Lo,Wo,Ho)
    pw,ph=int(194*mm),int(281*mm); pages=[]; n=0
    cols=math.ceil((big.width-8*mm)/pw); rows=math.ceil((big.height-8*mm)/ph)
    for r in range(rows):
        for c in range(cols):
            x0=int(c*pw);y0=int(r*ph); crop=big.crop((x0,y0,x0+int(210*mm),y0+int(297*mm)))
            pg=Image.new('RGB',(int(210*mm),int(297*mm)),'white'); pg.paste(crop,(0,0)); dd=ImageDraw.Draw(pg)
            n+=1; dd.text((10,10),'%s dieline 1:1 - page %d (row %d, col %d of %dx%d) - print at 100%%, overlap pages 16 mm, tape together'%(name,n,r+1,c+1,rows,cols),fill=(200,40,40),font=F(16,True))
            for (cx,cy) in ((0,0),(pg.width,0),(0,pg.height),(pg.width,pg.height)): dd.ellipse([cx-8,cy-8,cx+8,cy+8],outline=(200,40,40))
            pages.append(pg)
    pages[0].save(out+'%s_dieline_1to1_A4.pdf'%k,save_all=True,append_images=pages[1:],resolution=dpi)
    print(k,'pdf pages',len(pages),'flat %dx%d'%(sw,sh))
