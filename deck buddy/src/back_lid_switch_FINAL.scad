// FINAL (2026-11-14): back lid with SPDT slide-switch housing + locking lips. Pocket 12.1 x 5.8, lips 0.6 each side (0.2 overlap on the 11x5x5 switch), long walls 0.8,
// niche 1.6, lever out 1.0, height 5.5, centre 17.5 above USB-C. Same housing family is used in elephant/src/main.scad. view = "print" -> outside face down; "coupon" -> test piece.
// PROPOSAL: SS-12F15 slide switch in the yeti back lid, above the USB-C (same switch spec as Ellie)
// body coords: lid mating face at z=0, lid outer face at z=-4, head = low y, feet = high y
view = "out";   // out | in | sec | asm | print | coupon
$fn = 48;
sw_body  = [12.1, 5.8];   // pocket (x = slide direction, y = width) - width 6 -> 5.8 so the locking lips work (user 2026-11-14)
sw_depth = 5.0;           // real switch: 11 long x 5 wide x 5 high (user measured)
sw_lever = [3, 3, 4];
sw_travel= 3.2;
sw_slot  = [sw_lever[0] + sw_travel + 0.8, sw_lever[1] + 0.6];   // 7 x 3.6
sw_plate = 1.4;           // plate the lever passes through
niche_d  = 1.6;           // v2: finger niche depth from the outside (was 2.6)
lock_reach= 0.6;          // locking lip reach into the pocket per side (0 = no lips) -> gap 5.8 - 1.2 = 4.6 -> 0.2 overlap on the 5 mm switch
clip_open= sw_body[1] - 2*lock_reach;   // -> gap 4.6
wall_long= 0.8;           // the 2 walls that carry the lips are thinner so they flex (the other 2 stay 1.2)
sw_c     = [130.95, 122.5];   // centred; moved 5 mm toward the head (was y 127.5, level with the 2 screw holes) -> 17.5 mm above the USB-C centre (y 140)
lid_t    = 4;
sw_sink  = lid_t - niche_d - sw_plate;   // v2: switch sits 1.0 into the lid -> 4 mm lever sticks out 1.0 past the lid surface
bump_in  = (sw_body[1] - clip_open)/2;   // lip reach into the pocket (0.6)
tower_h  = 5.5;                          // v2: housing height above the lid's inner face (was 6.7, user 2026-11-14)
clip_z0  = sw_depth - sw_sink + 0.4;     // lip underside, 0.4 above the switch back (4.4)
assert(lock_reach == 0 || tower_h - lock_reach > clip_z0, "lips too short for the 45 deg ramp");
module rrect(s, r) offset(r) offset(-r) square(s, center = true);
module lid_orig() multmatrix([[0,-1,0,179.2],[-1,0,0,266.85],[0,0,-1,0],[0,0,0,1]]) import("../original/obj_4_Yeti Full.stl_3.stl");
module body_orig() import("../original/obj_7_corp+face.stl_1.stl");
module tower() translate([sw_c.x, sw_c.y, 0]) {
    difference() {
        translate([0,0,-0.01]) linear_extrude(tower_h + 0.01) square([sw_body[0] + 2.4, sw_body[1] + 2*wall_long], center = true);
        translate([0,0,-1]) linear_extrude(20) square(sw_body, center = true);
    }
    // locking lips: flat underside holds the switch, 45 deg ramp on top lets it slide in (fused 0.5 into the wall)
    if (lock_reach > 0) for (m = [0, 1]) mirror([0, m, 0]) rotate([90, 0, 90]) linear_extrude(6, center = true)
        polygon([[sw_body[1]/2 + 0.5, clip_z0], [sw_body[1]/2 - lock_reach, clip_z0], [sw_body[1]/2 - lock_reach, tower_h - lock_reach], [sw_body[1]/2, tower_h], [sw_body[1]/2 + 0.5, tower_h]]);
}
module cuts() translate([sw_c.x, sw_c.y, 0]) {
    translate([0,0,-lid_t - 1]) linear_extrude(niche_d + 1) rrect(sw_slot + [4, 3], 2);           // finger niche (outer side), niche_d deep
    translate([0,0,-sw_sink]) linear_extrude(sw_sink + 0.01) square(sw_body, center = true);        // v2: pocket sunk into the lid
    translate([0,0,-5]) linear_extrude(6) rrect(sw_slot, 0.8);                                     // lever slot
}
module lid_new() { difference() { lid_orig(); cuts(); } tower(); }
module switch_dummy() color("silver") translate([sw_c.x, sw_c.y, 0]) {
    translate([-11/2, -5/2, -sw_sink]) cube([11, 5, sw_depth]);
    translate([-sw_lever[0]/2 - sw_travel/2, -sw_lever[1]/2, -sw_sink - sw_lever[2]]) cube([sw_lever[0], sw_lever[1], sw_lever[2]]);
}
if (view == "out") { color("orange") lid_new(); }
if (view == "in")  { color("orange") lid_new(); switch_dummy(); }
if (view == "sec") intersection() { union() { color("orange") lid_new(); color("SteelBlue") body_orig(); switch_dummy(); } translate([130.95, 0, -50]) cube([100, 300, 200]); }
if (view == "print") translate([0, 0, lid_t]) lid_new();      // print: OUTSIDE face down, holder up
if (view == "asm") { color("SteelBlue") body_orig(); color("orange") lid_new(); }
// TEST COUPON: only the switch housing + a 22 x 13 patch of the lid around it (same geometry as the real lid),
// printed the same way (outside face down) -> quick fit test of pocket, clips and lever grip.
cp_size = [22, 13];
if (view == "coupon") translate([0, 0, lid_t]) translate(-[sw_c.x, sw_c.y, 0]) intersection() {
    lid_new();
    translate([sw_c.x - cp_size.x/2, sw_c.y - cp_size.y/2, -lid_t - 1]) cube([cp_size.x, cp_size.y, 30]);
}
