use </home/sudarsan/Documents/crazy_projects/lilmate_3D_design/pengu_chubby/src/main.scad>
$fn = 160;
difference(){ import("/home/sudarsan/Documents/crazy_projects/lilmate_3D_design/pengu_chubby/build/front.stl"); union(){ outer_main(); belly(); heart(); tuft(); cheeks(); for (sx=[-1,1]) { foot(sx); wing_T(sx) wing_shape(); } } }
