// FINAL v3 (2026-11-15): back lid with SPDT housing + Ellie-style bump/dimple snap (4 arms, no screws, screw holes filled). The SA body has the matching dimples. hooks v1 in backup_before_selflock/switch_lid_hooks_v1.scad.
// view = "print" -> outside face down; "hookcoupon"/"rimcoupon" -> snap test pieces (lid piece with the left 2 arms + body rim piece with the dimples).
// PROPOSAL: SS-12F15 slide switch in the yeti back lid, above the USB-C (same switch spec as Ellie)
// body coords: lid mating face at z=0, lid outer face at z=-4, head = low y, feet = high y
view = "out";   // out | in | sec | asm | print | coupon | hookcoupon | rimcoupon
$fn = 48;
sw_body  = [12.1, 5.8];   // pocket (x = slide direction, y = width) - width 6 -> 5.8 so the locking lips work (user 2026-11-14)
sw_depth = 5.0;           // real switch: 11 long x 5 wide x 5 high (user measured)
sw_lever = [3, 3, 4];
sw_travel= 3.2;
sw_slot  = [sw_lever[0] + sw_travel + 0.8, sw_lever[1] + 0.6];   // 7 x 3.6
sw_plate = 1.4;           // plate the lever passes through
niche_d  = 0.6;           // finger niche depth from the outside: 2.6 -> 1.6 (v2) -> 0.6 (2026-11-15, user: reduce the depth); lever now sticks out 2.0 and the switch sits 2.0 into the lid
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
module lid_orig() multmatrix([[0,-1,0,179.2],[-1,0,0,266.85],[0,0,-1,0],[0,0,0,1]]) import("../reference/original/obj_4_Yeti Full.stl_3.stl");
module body_orig() import("../reference/original/obj_7_corp+face.stl_1.stl");
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
// ---- SELF-LOCKING SNAP HOOKS (2026-11-15): the body opening has a 3.0 thick lip (edge x = 111.1 / 150.8) with a 2.0 undercut behind it (from z = 3.0).
// 4 flexing arms (2 per long side) pass through the opening; a barb on each hooks 0.3 behind the lip. The body is NOT changed. hook_on = false -> screw-only lid.
hook_on   = false;   // v1 hooks behind the lip, replaced by the Ellie bump + dimple snap below (2026-11-15)
xc_body   = 130.95;
lip_edge  = 19.85;        // LEFT opening wall x = 111.1 = xc - 19.85
lip_edge_r= 20.15;        // RIGHT opening wall x = 151.1 = xc + 20.15 (the 40.0 wide opening is 0.15 off centre)
function lip_e(s) = s < 0 ? lip_edge : lip_edge_r;
lip_back  = 3.0;          // z of the lip's back face
h_clear   = 0.2;          // arm outer face sits 0.2 inside the opening edge
h_t       = 0.8;          // arm thickness (thin = flexes)
h_reach   = 0.5;          // barb reach beyond the arm face -> tip is 0.3 behind the lip edge (0.3 engagement)
h_catch   = lip_back + 0.1;   // flat catch face, 0.1 behind the lip
h_top     = 4.0;          // arm top
h_w       = 7;            // arm width along y
h_y       = [114, 129];   // arm centres (the 3 mm nub in the lip is at y 135-138)
module hook_profile(s) {   // s = -1 left, +1 right: polygon in (x, z)
    xo = xc_body + s*(lip_edge - h_clear);     // arm outer face
    xi = xc_body + s*(lip_edge - h_clear - h_t);
    xt = xc_body + s*(lip_edge - h_clear + h_reach);   // barb tip (further out)
    polygon([[xo,-0.5],[xi,-0.5],[xi,h_top],[xo,h_top],[xo,h_top-0.1],[xt,h_top-0.1-h_reach],[xt,h_catch],[xo,h_catch]]);
}
module hooks() if (hook_on) for (s = [-1, 1]) for (y = h_y) translate([0, y + h_w/2, 0]) rotate([90,0,0]) linear_extrude(h_w) hook_profile(-s);
// ---- ELLIE-STYLE SNAP (2026-11-15): same asymmetric bump as elephant/src/main.scad (steep holding face, gentle ~27 deg ramp), no screws ----
// 4 short skirt arms on the lid (2 per long side) slide into the body opening; a bump on each arm clicks into a dimple cut in the opening wall.
// Each arm stands in a slot cut into the lid so it is long enough to flex (root 2.5 deep in the lid). The old 3 mm screw holes are filled.
snap_on   = true;
snap_h    = 0.4;      // catch height (Ellie 0.6; 0.4 here so the 3 mm skirt can flex it)
snap_y0   = 0.8;      // steep holding face this far behind the seam plane (z = 0.8)
snap_top  = 0.8;      // flat top of the catch
snap_ramp = 1.2;      // lead-in ramp (~27 deg)
sk_t      = 1.0;      // skirt thickness
sk_clr    = 0.12;     // skirt outer face sits 0.12 inside the opening wall (Ellie lip_clr)
sk_tip    = 3.0;      // skirt length into the body = the 3.0 thick lip
sk_root   = -2.5;     // arm root, deep in the lid
sk_w      = 8;        // arm width along y
sk_y      = [114, 129];
slot_w    = 0.6;      // slot around the arm in the lid
module snap_arm_profile(s) {                 // s = -1 left, +1 right; polygon in (x, z)
    xo = xc_body + s*(lip_e(s) - sk_clr); xi = xo - s*sk_t; b = snap_h;
    polygon([[xi, sk_root - 0.3], [xo, sk_root - 0.3], [xo, snap_y0], [xo + s*b, snap_y0], [xo + s*b, snap_y0 + snap_top], [xo, snap_y0 + snap_top + snap_ramp], [xo, sk_tip], [xi, sk_tip]]);
}
module snap_arms() if (snap_on) for (s = [-1, 1]) for (y = sk_y) translate([0, y + sk_w/2, 0]) rotate([90,0,0]) linear_extrude(sk_w) snap_arm_profile(s);
module snap_slots() if (snap_on) for (s = [-1, 1]) for (y = sk_y) {
    xo = xc_body + s*(lip_e(s) - sk_clr); xi = xo - s*sk_t;
    difference() {   // ring slot around the arm, from the lid's inner face down to the arm root
        translate([min(xi - s*slot_w, xo + s*slot_w), y - sk_w/2 - slot_w, sk_root]) cube([sk_t + 2*slot_w, sk_w + 2*slot_w, -sk_root + 0.05]);
        translate([min(xi, xo), y - sk_w/2, sk_root - 1]) cube([sk_t, sk_w, -sk_root + 2]);
    }
}
// the 2 old M2/M3 screw holes (body pilots at x 108.4 / 153.4, y 127.5): fill the lid holes flush
module screw_fill() intersection() {
    hull() lid_orig();
    union() for (x = [108.4, 153.4]) translate([x, 127.5, -4.5]) cylinder(d = 7.0, h = 4.5);   // 7 mm covers the countersink too
}
// dimples in the body opening wall (the lip faces at x = xc +- 19.85), same shape as the bump + 0.05 play behind the holding face
module dimples() if (snap_on) for (s = [-1, 1]) for (y = sk_y)
    translate([0, y + (sk_w + 0.4)/2, 0]) rotate([90,0,0]) linear_extrude(sk_w + 0.4)
        polygon([[xc_body + s*(lip_e(s) - 0.05), snap_y0 - 0.05], [xc_body + s*(lip_e(s) + snap_h + 0.1), snap_y0 - 0.05],
                 [xc_body + s*(lip_e(s) + snap_h + 0.1), snap_y0 + snap_top + 0.1], [xc_body + s*(lip_e(s) - 0.05), snap_y0 + snap_top + snap_ramp + 0.25]]);
module body_pilot_fill() for (x = [108.4, 153.4]) translate([x, 127.5, -0.01]) cylinder(d = 2.4, h = 3.4);
module body_mod() difference() { union() { body_orig(); body_pilot_fill(); } dimples(); }
module lid_new() { difference() { lid_orig(); cuts(); snap_slots(); } screw_fill(); tower(); hooks(); snap_arms(); }
module switch_dummy() color("silver") translate([sw_c.x, sw_c.y, 0]) {
    translate([-11/2, -5/2, -sw_sink]) cube([11, 5, sw_depth]);
    translate([-sw_lever[0]/2 - sw_travel/2, -sw_lever[1]/2, -sw_sink - sw_lever[2]]) cube([sw_lever[0], sw_lever[1], sw_lever[2]]);
}
if (view == "out") { color("orange") lid_new(); }
if (view == "in")  { color("orange") lid_new(); switch_dummy(); }
if (view == "sec") intersection() { union() { color("orange") lid_new(); color("SteelBlue") body_mod(); switch_dummy(); } translate([130.95, 0, -50]) cube([100, 300, 200]); }
if (view == "print") translate([0, 0, lid_t]) lid_new();      // print: OUTSIDE face down, holder up
if (view == "asm") { color("SteelBlue") body_mod(); color("orange") lid_new(); }
// TEST COUPON: only the switch housing + a 22 x 13 patch of the lid around it (same geometry as the real lid),
// printed the same way (outside face down) -> quick fit test of pocket, clips and lever grip.
cp_size = [22, 13];
if (view == "coupon") translate([0, 0, lid_t]) translate(-[sw_c.x, sw_c.y, 0]) intersection() {
    lid_new();
    translate([sw_c.x - cp_size.x/2, sw_c.y - cp_size.y/2, -lid_t - 1]) cube([cp_size.x, cp_size.y, 30]);
}
// HOOK TEST (print both, then push the lid piece into the rim piece):
//  hookcoupon = a 16 x 26 piece of the lid with 2 hooks, outside face down; rimcoupon = the matching piece of the body rim (lip + undercut), back opening face down.
if (view == "hookcoupon") translate([0, 0, lid_t]) translate(-[xc_body - 22, 108, 0]) intersection() {
    lid_new(); translate([xc_body - 26, 108, -lid_t - 1]) cube([16, 26, 14]); }   // lid piece: 16 x 26 with the 2 left snap arms
if (view == "rimcoupon") translate(-[xc_body - 26, 108, 0]) intersection() {
    body_mod(); translate([xc_body - 30, 108, -0.01]) cube([14, 26, 7.0]); }
if (view == "clash_lid_body") intersection() { body_mod(); lid_new(); }
