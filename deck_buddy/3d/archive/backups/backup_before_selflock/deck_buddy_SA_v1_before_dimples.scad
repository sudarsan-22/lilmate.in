// DECK BUDDY SA (stand-alone): the yeti body (original/obj_7) with three edits, in PRINT orientation.
//   1. printed UPRIGHT: feet on the bed, head up, face toward -y, back opening toward +y
//   2. the 9 mm counterbore + 6 mm hole in each foot sole is plugged, so the buddy stands on the desk by itself (no spike base)
//   3. the touch-sensor pocket in the head roof gets a self-locking snap (two thin flexing fingers with 0.2 mm lips,
//      the same idea as the 0.8 mm long walls of the SPDT housing) and two z-stops, sized for a TTP223 board 15 x 11 x 1.6
// All numbers are in the ORIGINAL body frame (x sideways, y from head (low) to feet (high), z from the back opening (0) to the face (40.6)),
// measured from sections of the STL. upright() then turns the model into the print frame.
//   view = "print"  -> the finished upright body   |   view = "board" -> the 15 x 11 x 1.6 board in its seat (for checks)
//   view = "edits"  -> only the added material (plugs + snap), in the original frame, for clash checks
view = "print";
BODY = "../../../reference/original/obj_7_corp+face.stl_1.stl";

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

module added() { plug(); snap(); }

module board() translate([xc - brd_w/2, y_roof + 0.08, zc - brd_l/2]) cube([brd_w, brd_t, brd_l]);

// original frame -> print frame: x' = xc - x (centred), y' = -z (face toward -y, opening toward +y), z' = sole_y - y (feet on the bed)
module upright() multmatrix([[-1,0,0,xc],[0,0,-1,0],[0,-1,0,sole_y],[0,0,0,1]]) children();

module body_sa() union() { import(BODY, convexity = 10); added(); }

if (view == "print")      intersection() { upright() body_sa(); translate([-100,-100,0]) cube([200,200,200]); }
else if (view == "board") upright() board();
else if (view == "edits") added();
