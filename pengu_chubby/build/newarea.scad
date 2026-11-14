// area that is solid at z=67.6 but empty right below at z=67.2 (= printed in mid-air)
difference(){
  projection(cut=true) translate([0,0,-67.6]) import("/home/sudarsan/Documents/crazy_projects/lilmate_3D_design/pengu_chubby/build/front.stl");
  offset(delta=0.4) projection(cut=true) translate([0,0,-67.2]) import("/home/sudarsan/Documents/crazy_projects/lilmate_3D_design/pengu_chubby/build/front.stl");
}
