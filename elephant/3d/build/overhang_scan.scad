m = "/home/sudarsan/Documents/crazy_projects/lilmate_3D_design/elephant/build/front.stl";
module sl(z) projection(cut=true) translate([0,0,-z]) import(m);
for (z = [20:0.5:97]) translate([0,0,z]) linear_extrude(0.4) difference() { sl(z); offset(delta = 0.55) sl(z - 0.5); }
