// area that is solid at z=83.0 but empty right below at z=82.6 (= printed in mid-air)
difference(){
  projection(cut=true) translate([0,0,-83.0]) import("/home/sudarsan/Documents/crazy_projects/lilmate_3D_design/elephant/build/front.stl");
  offset(delta=0.4) projection(cut=true) translate([0,0,-82.6]) import("/home/sudarsan/Documents/crazy_projects/lilmate_3D_design/elephant/build/front.stl");
}
