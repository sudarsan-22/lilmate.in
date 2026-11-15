// lid (obj_4) mapped onto the body back (obj_7, z=0 face): bodyX = -(lidY-48.25)+130.95, bodyY = -(lidX-142.6)+124.25, bodyZ = -lidZ
module lid_in_body() multmatrix([[0,-1,0,130.95+48.25],[-1,0,0,124.25+142.6],[0,0,-1,0],[0,0,0,1]]) import("../reference/original/obj_4_Yeti Full.stl_3.stl");
color("red") linear_extrude(1) difference(){ projection(cut=true) translate([0,0,-0.2]) lid_in_body_flip(); }
module lid_in_body_flip() translate([0,0,0.4]) lid_in_body();
color("SteelBlue") linear_extrude(0.5) projection(cut=true) translate([0,0,-0.2]) import("../reference/original/obj_7_corp+face.stl_1.stl");
