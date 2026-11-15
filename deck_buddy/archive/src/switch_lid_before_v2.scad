// PROPOSAL: SS-12F15 slide switch in the yeti back lid, above the USB-C (same switch spec as Ellie)
// body coords: lid mating face at z=0, lid outer face at z=-4, head = low y, feet = high y
view = "out";   // out | in | sec | asm | print
$fn = 48;
sw_body  = [11.8, 5.2];   // pocket incl. bent ears + clearance (x = slide direction)
sw_depth = 5.1;
sw_lever = [3, 3, 4];
sw_travel= 3.2;
sw_slot  = [sw_lever[0] + sw_travel + 0.8, sw_lever[1] + 0.6];   // 7 x 3.6
sw_plate = 1.4;
sw_c     = [130.95, 127.5];   // centred, level with the 2 screw holes, ~12.5 mm above USB-C centre (y 140)
lid_t    = 4;
module rrect(s, r) offset(r) offset(-r) square(s, center = true);
module lid_orig() multmatrix([[0,-1,0,179.2],[-1,0,0,266.85],[0,0,-1,0],[0,0,0,1]]) import("../../reference/original/obj_4_Yeti Full.stl_3.stl");
module body_orig() import("../../reference/original/obj_7_corp+face.stl_1.stl");
module tower() translate([sw_c.x, sw_c.y, 0]) {
    difference() {
        translate([0,0,-0.01]) linear_extrude(sw_depth + 1.6 + 0.01) square(sw_body + [2.4, 2.4], center = true);
        linear_extrude(20) square(sw_body, center = true);
    }
    for (s = [-1, 1]) translate([-3, s * sw_body[1]/2 - (s > 0 ? 0.4 : 0.5), sw_depth + 0.4]) cube([6, 0.9, 1.2]);   // retaining bumps
}
module cuts() translate([sw_c.x, sw_c.y, 0]) {
    translate([0,0,-lid_t - 1]) linear_extrude(lid_t - sw_plate + 1) rrect(sw_slot + [4, 3], 2);   // finger niche (outer side)
    translate([0,0,-5]) linear_extrude(6) rrect(sw_slot, 0.8);                                     // lever slot
}
module lid_new() { difference() { lid_orig(); cuts(); } tower(); }
module switch_dummy() color("silver") translate([sw_c.x, sw_c.y, 0]) {
    translate([-10.5/2, -4.5/2, 0]) cube([10.5, 4.5, sw_depth]);
    translate([-sw_lever[0]/2 - sw_travel/2, -sw_lever[1]/2, -sw_lever[2]]) cube([sw_lever[0], sw_lever[1], sw_lever[2]]);
}
if (view == "out") { color("orange") lid_new(); }
if (view == "in")  { color("orange") lid_new(); switch_dummy(); }
if (view == "sec") intersection() { union() { color("orange") lid_new(); color("SteelBlue") body_orig(); switch_dummy(); } translate([130.95, 0, -50]) cube([100, 300, 200]); }
if (view == "print") translate([0, 0, lid_t]) lid_new();      // print: OUTSIDE face down, holder up
if (view == "asm") { color("SteelBlue") body_orig(); color("orange") lid_new(); }
