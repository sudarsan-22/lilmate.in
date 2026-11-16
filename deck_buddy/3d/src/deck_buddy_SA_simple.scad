// DECK BUDDY SA SIMPLE (stand-alone, internals fused into the body):  the yeti body (original/obj_7) with three edits, in PRINT orientation.
//   1. printed UPRIGHT: feet on the bed, head up, face toward -y, back opening toward +y
//   2. the 9 mm counterbore + 6 mm hole in each foot sole is plugged, so the buddy stands on the desk by itself (no spike base)
//   2b. (2026-11-15) the 2 screw pilot holes are filled and 8 dimples (Ellie-style snap, see docs/switch_lid.scad) are cut in the opening lip for the lid's snap arms
//   3. the touch-sensor pocket in the head roof gets a self-locking snap (two thin flexing fingers with 0.2 mm lips,
//      the same idea as the 0.8 mm long walls of the SPDT housing) and two z-stops, sized for a TTP223 board 15 x 11 x 1.6
// All numbers are in the ORIGINAL body frame (x sideways, y from head (low) to feet (high), z from the back opening (0) to the face (40.6)),
// measured from sections of the STL. upright() then turns the model into the print frame.
//   view = "print"  -> the finished upright body   |   view = "board" -> the 15 x 11 x 1.6 board in its seat (for checks)
//   view = "edits"  -> only the added material (plugs + snap), in the original frame, for clash checks
view = "print";   // "print" | "internals" (only the new internal features) | "board" | "edits"
BODY = "../reference/original/obj_7_corp+face.stl_1.stl";

// ---- feet ----
foot_x    = [115.9, 145.9];   // hole centres (30 mm apart)
foot_z    = 16.0;
sole_y    = 162.22;           // lowest point of the soles (max y of the STL)
bore_end  = 152.25;           // the 6 mm hole opens into the belly cavity here
plug_r    = 4.8;              // counterbore is 9.0 dia, plug 9.6 so it fuses with the walls

// ---- head touch pocket ----
xc     = 130.95;              // pocket centre (x)
y_roof = 94.22;               // pocket ceiling = underside of the 2.0 mm roof skin
y_mouth= 100.32;              // pocket mouth (cavity roof level)
z_a    = 9.0;  z_b = 25.2;    // full-width part of the pocket (18.0 wide) along z
brd_w  = 15.0; brd_l = 11.0; brd_t = 1.6;     // TTP223 board
seat_l = brd_l + 0.4;         // z-stops leave 11.4
zc     = (z_a + z_b)/2;       // board centre along z
// snap fingers
f_gap  = 0.1;                 // clearance between board edge and finger face
f_t    = 0.8;                 // finger thickness (thin = flexes)
f_wall = 0.6;                 // slit between finger and pocket wall (room to flex)
f_len  = 8.0;                 // finger length along z
lip_ov = 0.2;                 // the lock: lip overlaps the board edge by 0.2
lip_h  = 0.9;                 // lip height (45 deg-ish lead-in)
catch_y= y_roof + brd_t + 0.3;           // flat catch face, 0.3 above the seated board
f_top  = y_roof + 0.4;                   // finger free end, 0.4 under the ceiling
eps    = 0.01;

module plug() for (x = foot_x) translate([x, bore_end, foot_z]) rotate([-90,0,0]) cylinder(r = plug_r, h = sole_y - bore_end, $fn = 72);

module prism_z(pts, z0, z1) translate([0,0,z0]) linear_extrude(z1 - z0) polygon(pts);

module finger(side) {                       // side = -1 (left) or +1 (right); drawn in x, y, extruded along z
    u_in  = brd_w/2 + f_gap;                // finger inner face, from the pocket centre
    u_out = u_in + f_t;
    root_out = (side < 0) ? 9.3 : 10.3;     // root bridge reaches into the wall (pocket half width 9.0; 10.0 on the right for y > 97.32)
    z0 = zc - f_len/2; z1 = zc + f_len/2;
    X = function(u) xc + side*u;
    reach = u_in - (brd_w/2 - lip_ov);      // lip reach beyond the finger face = 0.3 -> gap between lips = board - 2 x 0.2
    // 2-D profile (x, y): free end, outer face, root bridge into the wall, inner face up to the lip, 45-ish ramp, flat catch, back to the free end
    pts3 = [ [X(u_out), f_top], [X(u_out), y_mouth - 0.9], [X(root_out), y_mouth - 0.9], [X(root_out), y_mouth],
             [X(u_in), y_mouth], [X(u_in), catch_y + lip_h], [X(u_in - reach), catch_y], [X(u_in), catch_y], [X(u_in), f_top] ];
    prism_z(pts3, z0, z1);
}

module stops() {                            // z-stops: keep the board from sliding along the pocket
    for (r = [[z_a - 0.4, zc - seat_l/2], [zc + seat_l/2, z_b + 0.2]])
        translate([xc - 9.3, y_roof - 0.3, r[0]]) cube([18.6, (catch_y + 0.4) - (y_roof - 0.3), r[1] - r[0]]);
}

module snap() { finger(-1); finger(1); stops(); }

// the small 2 mm hole in the belly between the feet (x 130.95, z 16, through the 2.0 wall y 152.8..154.5): closed (user 2026-11-15)
module belly_plug() translate([130.95, 152.7, 16]) rotate([-90,0,0]) cylinder(d = 2.4, h = 154.5 - 152.7, $fn = 32);
module added() { plug(); snap(); belly_plug(); }

module board() translate([xc - brd_w/2, y_roof + 0.08, zc - brd_l/2]) cube([brd_w, brd_t, brd_l]);

// original frame -> print frame: x' = xc - x (centred), y' = -z (face toward -y, opening toward +y), z' = sole_y - y (feet on the bed)
module upright() multmatrix([[-1,0,0,xc],[0,0,-1,0],[0,-1,0,sole_y],[0,0,0,1]]) children();

// ---- back lid snap: dimples in the opening lip (numbers = docs/switch_lid.scad snap_*), screw pilots filled ----
lid_xc = 130.95; function lid_e(sd) = sd < 0 ? 19.85 : 20.15;   // opening walls at x = 111.1 and 151.1
snap_h = 0.4; snap_y0 = 0.8; snap_top = 0.8; snap_ramp = 1.2; snap_w = 8; snap_ys = [114, 129];
module dimples() for (sd = [-1, 1]) for (y = snap_ys)
    translate([0, y + (snap_w + 0.4)/2, 0]) rotate([90,0,0]) linear_extrude(snap_w + 0.4)
        polygon([[lid_xc + sd*(lid_e(sd) - 0.05), snap_y0 - 0.05], [lid_xc + sd*(lid_e(sd) + snap_h + 0.1), snap_y0 - 0.05],
                 [lid_xc + sd*(lid_e(sd) + snap_h + 0.1), snap_y0 + snap_top + 0.1], [lid_xc + sd*(lid_e(sd) - 0.05), snap_y0 + snap_top + snap_ramp + 0.25]]);
module pilot_fill() for (x = [108.4, 153.4]) translate([x, 127.5, -0.01]) cylinder(d = 2.4, h = 3.4);


// ---- SIMPLE PERMANENT INTERNALS (2026-11-16, Elephant style; replaces the separate Yeti bracket + locking pins) ----
// Everything below is part of the BODY and printed with it. Original body frame: x centre XC, height h = y - 87.5 (y_base 87.5), depth d from the front face (z = 40.64 - d).
// Heights/depths are the same as the old build: OLED PCB h 17.1..50.6 (d 13.5..14.7), ESP32 board h 48.3..49.3 (d 18.6..40.6), TP4056 board h 54.2..55.2 (d 13.6..40.6).
IXC = 130.95; IY0 = 87.5; IZF = 40.64;
module blk(x0,x1,h0,h1,d0,d1) translate([IXC+x0, IY0+h0, IZF-d1]) cube([x1-x0, h1-h0, d1-d0]);
module sym() { children(); translate([IXC,0,0]) mirror([1,0,0]) translate([-IXC,0,0]) children(); }   // mirror about the centre line
module ext(d0,d1) translate([IXC,IY0,IZF-d1]) linear_extrude(d1-d0) children();
module r2(x0,x1,h0,h1) translate([x0,h0]) square([x1-x0,h1-h0]);
emb = 0.6;      // how far the bay/top wall bites into the body wall so they fuse
// OLED bay (plain, like Elephant): PCB 35.4 x 33.5 x 1.2 drops/tilts in from the back, sits against the glass pocket of the front wall
module oled_bay() {
  ext(12.2,18.2) for (s=[1,-1]) scale([s,1]) {
    // lower part follows the bowl of the body (free half width 16.4 at h15, 18.4 at h17), +emb into the wall: it is what fuses the bay to the body
    polygon([[0,15.4],[17.8,15.4],[19.6,16.9],[20.5,17.6],[20.9,18.4],[18.0,18.4],[18.0,17.0],[16,17.1],[0,17.1]]);
    r2(18.0,19.4,18.4,47.0);
  }
  ext(15.4,18.2) for (s=[1,-1]) scale([s,1]) r2(18.0,19.4,47.0,52.3);
  ext(12.2,18.2) r2(-17.8,17.8,15.4,17.1);
  ext(15.4,18.2) r2(-21.8,21.8,50.9,52.3);          // top wall: bites 1.6 into both body walls (wall starts at x 20.2 there and is 9 mm thick) and carries the TP4056 rails
}
// TP4056 slot (above the display PCB, so the PCB can still swing in under it): board 17 x 27 x 1 at h 54.2..55.2, d 13.6..40.6, stop in front
module tp_slot() {
  sym() { blk(8.7,10.4, 50.7,57.5, 13.6,40.64); blk(7.5,8.7, 53.0,54.2, 13.6,40.64); blk(7.5,8.7, 55.5,56.8, 13.6,40.64); }
  blk(-10.4,10.4, 53.0,57.5, 12.2,13.6);
}
// ESP32-C3 slot: board 18 x 22 x 1 at h 48.3..49.3. Rails only on the rear part (d 31..40.6): the display PCB has to swing in past h 47.1..50.6 at d < 30
esp_d0 = 31.0;
module esp_slot() sym() { blk(9.2,10.4, 47.1,51.0, esp_d0,40.64); blk(8.0,9.2, 47.1,48.3, esp_d0,40.64); blk(8.0,9.2, 49.6,50.9, esp_d0,40.64); }
module internals() { oled_bay(); tp_slot(); esp_slot(); }
module body_sa() difference() { union() { import(BODY, convexity = 10); added(); pilot_fill(); internals(); } dimples(); }

if (view == "print")      intersection() { upright() body_sa(); translate([-100,-100,0]) cube([200,200,200]); }
else if (view == "board") upright() board();
else if (view == "edits") added();
else if (view == "internals") internals();
