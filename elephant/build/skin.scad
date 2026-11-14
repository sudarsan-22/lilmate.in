use </home/sudarsan/Documents/crazy_projects/lilmate_3D_design/elephant/src/main.scad>
$fn = 160;
// outer 0.8 mm skin of the head (front half) that is MISSING from the printed part, excluding the intended visor cuts
difference(){ intersection(){ difference(){ head_hull(0); head_hull(0.8); } half_y(-200, 0); } import("/home/sudarsan/Documents/crazy_projects/lilmate_3D_design/elephant/build/front.stl"); face_cuts(); }
