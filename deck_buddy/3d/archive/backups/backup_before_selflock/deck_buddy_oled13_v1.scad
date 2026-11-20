// DECK BUDDY 1.3" OLED upgrade: new bezel (obj_8) + new display frame in the bracket (obj_1). The body is NOT changed.
// Module (copied from Ellie, elephant/src/main.scad): PCB 35.4 x 33.5 x 1.2, glass 34.5 x 23 x 1.5 (centred on the PCB), view window 31 x 17.
// Coordinates of the bracket = the original STL frame: x across (centre 306.31), y_br front-to-back (frame front at 55.22), z_br up (platform top 8.5).
// The bracket sits in the body with:  x_b = x - 306.31 + 130.95,  y_b = 146.3 - z_br,  z_b = y_br - 24.62   (found by fitting: zero overlap, front face on the wall at z_b = 30.6)
// view = "bracket" | "bezel" | "asm" (body + new parts + a dummy board, for clash checks) | "board"
view = "bracket";
$fn = 48;
BODY    = "../../../reference/original/obj_7_corp+face.stl_1.stl";
BRACKET = "../../../reference/original/obj_1_Yeti Full.stl_1.stl";
BEZEL   = "../../../reference/original/obj_8_corp+face.stl_2.stl";

// ---- module ----
pcb    = [35.4, 33.5, 1.2];      // x, height, thickness
glass  = [34.5, 23.0, 1.5];
win    = [31.0, 17.0];           // what you see
// ---- frame ----
xb     = 306.31;                 // bracket centre
zc     = 25.0;                   // display centre height (= body window centre y_b 121.3)
y_front= 55.22;                  // front face of the old frame plate (touches the wall)
plate_t= 3.0;
y_pl   = y_front - plate_t;      // plate back face = PCB front face (52.22)
clr    = 0.3;                    // PCB clearance per side
bay    = [pcb[0] + 2*clr, pcb[1] + 2*clr];         // 36.0 x 34.1
wall   = 1.0;                    // side wall
lip_r  = 0.8;                    // rail lip reach over the PCB back face (overlap 0.5)
lip_t  = 0.8;
pcb_back = y_pl - pcb[2];                           // 51.02
catch_y  = pcb_back - 0.1;                          // flat face of the rail lip, 0.1 behind the PCB
z_bot  = zc - bay[1]/2;                             // inner bottom of the bay (7.95)
z_top  = zc + bay[1]/2;                                 // plate top (42.05), no top wall: the PCB slides in from the top; any higher touches the head ceiling
z_foot = 6.5;                                       // frame feet overlap the platform (top 8.5)
cut_y0 = 49.4; cut_z0 = 7.9;                        // old frame removal box starts here (also removes the old bar the PCB bottom would touch)
z_wall0 = 12.0;                                     // side walls start here: below it the body has nubs at y_b 135-140 (cavity half width only 17.85)
low_hw  = 17.6;                                     // half width of the low part (plate + sill) = just the PCB
eps = 0.01;

module rrect(s, r) offset(r) offset(-r) square(s, center = true);

module old_frame_cut() translate([280, cut_y0, cut_z0]) cube([60, 10, 40]);       // everything of the old frame (y > 49.4, z > 8.8)

module slab_x(x0, x1, y0, y1, z0, z1) translate([x0, y0, z0]) cube([x1 - x0, y1 - y0, z1 - z0]);

module new_frame() {
    difference() {
        union() {
            // front plate
            slab_x(xb - low_hw, xb + low_hw, y_pl, y_front, z_foot, z_wall0 + 0.01);
            slab_x(xb - bay[0]/2 - wall, xb + bay[0]/2 + wall, y_pl, y_front, z_wall0, z_top);
            // side walls + rail lips (the PCB slides down between the plate and the lips)
            for (s = [-1, 1]) {
                x_in = xb + s*bay[0]/2;
                slab_x(min(x_in, x_in + s*wall), max(x_in, x_in + s*wall), catch_y - lip_t, y_pl + eps, z_wall0, z_top);
                slab_x(min(x_in, x_in - s*lip_r), max(x_in, x_in - s*lip_r), catch_y - lip_t, catch_y, z_wall0, z_top);
            }
            // sill under the PCB, joined to the platform
            slab_x(xb - low_hw, xb + low_hw, 47.0, y_pl + eps, z_foot, z_bot);
        }
        // the cavity corners (chamfer) near the head are tighter than the PCB top: trim the side walls above z = 40.3
        for (sx = [-1, 1]) translate([xb + sx*17.9 + (sx > 0 ? 0 : -20), 40, 40.3]) cube([20, 20, 10]);
        // view window 31 x 17 with a sloped top (no 31 mm bridge when printed upright)
        hull() {
            translate([xb, y_front - 0.01, zc]) rotate([-90,0,0]) linear_extrude(0.5) rrect(win, 2.5);
            translate([xb, y_pl + plate_t - 1.3 - 0.0, zc + 1.3]) rotate([-90,0,0]) linear_extrude(0.01) rrect([win[0], win[1] + 2.6], 2.5);
        }
        // glass pocket from the back, floor at y_pl + 1.7, top chamfered 45 deg
        translate([xb - 34.9/2, 0, 0]) rotate([90,0,90]) linear_extrude(34.9)
            polygon([[y_pl - 0.5, zc - 23.4/2], [y_pl + 1.7, zc - 23.4/2], [y_pl + 1.7, zc + 23.4/2], [y_pl - 0.01, zc + 23.4/2 + 1.7], [y_pl - 0.5, zc + 23.4/2 + 2.2]]);
    }
}

module bracket_new() { difference() { import(BRACKET, convexity = 10); old_frame_cut(); } new_frame(); }

module bezel_new() difference() {
    import(BEZEL, convexity = 10);
    translate([257.59, 43.96, -1]) linear_extrude(8) rrect(win + [0.4, 0.4], 2.5);   // 31.4 x 17.4 through the whole bezel
}

module pcb_dummy() color("green") translate([xb - pcb[0]/2, y_pl - pcb[2], zc - pcb[1]/2]) cube([pcb[0], pcb[2], pcb[1]]);
module glass_dummy() color("silver") translate([xb - glass[0]/2, y_pl, zc - glass[1]/2]) cube([glass[0], glass[2], glass[1]]);

// bracket frame -> body frame (rotation, no mirror)
module br2body() multmatrix([[1,0,0,130.95 - xb],[0,0,-1,146.3],[0,1,0,-24.62],[0,0,0,1]]) children();

if (view == "bracket") bracket_new();
if (view == "bezel")   bezel_new();
if (view == "board")   { pcb_dummy(); glass_dummy(); }
if (view == "asm") { color("SteelBlue") import(BODY, convexity = 10); br2body() { color("orange") bracket_new(); pcb_dummy(); glass_dummy(); } }
if (view == "clash_body") intersection() { import(BODY, convexity = 10); br2body() bracket_new(); }
if (view == "clash_board") intersection() { br2body() { bracket_new(); } br2body() { pcb_dummy(); } }
if (view == "clash_pcb") intersection() { import(BODY, convexity = 10); br2body() { pcb_dummy(); } }
if (view == "clash_plate") intersection() { import(BODY, convexity = 10); br2body() new_frame(); }
module bezel2body(c = 30.6) multmatrix([[1,0,0,130.95 - 257.59],[0,1,0,121.3 - 43.96],[0,0,1,c],[0,0,0,1]]) children();
if (view == "clash_bezel") intersection() { import(BODY, convexity = 10); bezel2body() bezel_new(); }
if (view == "clash_bezel_frame") intersection() { br2body() new_frame(); bezel2body() bezel_new(); }
