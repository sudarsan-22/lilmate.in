// DECK BUDDY 1.3" OLED upgrade: new bezel (obj_8) + new display frame in the bracket (obj_1). The body is NOT changed.
// Module (copied from Ellie, elephant/src/main.scad): PCB 35.4 x 33.5 x 1.2, glass 34.5 x 23 x 1.5 (centred on the PCB), view window 31 x 17.
// Coordinates of the bracket = the original STL frame: x across (centre 306.31), y_br front-to-back (frame front at 55.22), z_br up (platform top 8.5).
// The bracket sits in the body with:  x_b = x - 306.31 + 130.95,  y_b = 146.3 - z_br,  z_b = y_br - 24.62   (found by fitting: zero overlap, front face on the wall at z_b = 30.6)
// view = "bracket" | "bezel" | "asm" (body + new parts + a dummy board, for clash checks) | "board"
// v2 (2026-11-15): + Ellie's TWO-BOARD stack (TP4056 + ESP32-C3 Mini in two slots, slide in from the back opening) and a self-locking display mount
// (snap arms with 0.25 mm lips behind the PCB; the board is pressed in from behind). v1 is in backup_before_selflock/deck_buddy_oled13_v1.scad.
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
z_top  = zc + bay[1]/2 - 0.15;                                 // plate top (42.05), no top wall: the PCB slides in from the top; any higher touches the head ceiling
z_foot = 6.5;                                       // frame feet overlap the platform (top 8.5)
cut_y0 = 49.4; cut_z0 = 7.9;                        // old frame removal box starts here (also removes the old bar the PCB bottom would touch)
z_wall0 = 12.0;                                     // side walls start here: below it the body has nubs at y_b 135-140 (cavity half width only 17.85)
low_hw  = 17.6;                                     // half width of the low part (plate + sill) = just the PCB
eps = 0.01;

// ---- Ellie two-board stack (all numbers from elephant/src/main.scad) ----
esp   = [22.0, 18.0, 1.0];       // length (slides in), width, thickness   ESP32-C3 Mini
tp    = [27.0, 17.0, 1.0];       // TP4056
usb_h = 3.3;
stack_w  = 20.5;                 // inner width between the two side walls
st_wall  = 1.2;
slot_clr = 0.2; slot_zclr = 0.3; stop_len = 2.0; stop_reach = 2.5; lip_reach = 1.0;
y_open = 24.62;                  // back opening plane (body z = 0); boards end flush here
fl_top = 3.0;                    // top of the old bracket floor
tp_z0  = 6.3 - (1.0 + usb_h/2);  // TP4056 USB-C centre must sit at z_br 6.3 = body y 140.0 = the lid's USB-C slot -> 3.65
esp_z0 = tp_z0 + tp[2] + usb_h + 1.6;      // 9.55
stack_top = esp_z0 + esp[2] + slot_zclr + 1.0 + 0.6;   // side walls end just above the ESP lip
// ---- self-locking display arms ----
arm_t   = 1.2;  arm_gap = 0.4;           // arm thickness, gap between arm and plate edge
arm_z0  = 12.5; arm_z1 = 39.5;           // arm root / top (body cavity corners stop it any higher)
lip_z0  = 33.0; lip_z1 = 38.5;           // lip along the arm (high up: the display tilts in, bottom first, and the top clicks in last)
lip_ov  = 0.25;                          // lip overlap on the PCB edge (the "0.2 mm lock")
plate_hw = 18.25;                        // plate half width (glass pocket 34.9 + 0.8 skin each side)

module rrect(s, r) offset(r) offset(-r) square(s, center = true);

module old_frame_cut() translate([280, cut_y0, cut_z0]) cube([60, 10, 40]);       // everything of the old frame (y > 49.4, z > 8.8)

module slab_x(x0, x1, y0, y1, z0, z1) translate([x0, y0, z0]) cube([x1 - x0, y1 - y0, z1 - z0]);

module new_frame() {
    difference() {
        union() {
            // front plate: narrow below z_wall0 (nubs in the body), full glass width above
            slab_x(xb - low_hw, xb + low_hw, y_pl, y_front, z_foot, z_wall0 + 0.01);
            slab_x(xb - plate_hw, xb + plate_hw, y_pl, y_front, z_wall0, z_top);
            // sill under the PCB, joined to the platform
            slab_x(xb - low_hw, xb + low_hw, 47.0, y_pl + eps, z_foot, z_bot);
        }
        // view window 31 x 17 with a sloped top (no 31 mm bridge when printed upright)
        hull() {
            translate([xb, y_front - 0.01, zc]) rotate([-90,0,0]) linear_extrude(0.5) rrect(win, 2.5);
            translate([xb, y_front - 1.3, zc + 1.3]) rotate([-90,0,0]) linear_extrude(0.01) rrect([win[0], win[1] + 2.6], 2.5);
        }
        // glass pocket from the back, floor at y_pl + 1.7, top chamfered 45 deg
        translate([xb - 34.9/2, 0, 0]) rotate([90,0,90]) linear_extrude(34.9)
            polygon([[y_pl - 0.5, zc - 23.4/2], [y_pl + 1.7, zc - 23.4/2], [y_pl + 1.7, zc + 23.4/2], [y_pl - 0.01, zc + 23.4/2 + 1.7], [y_pl - 0.5, zc + 23.4/2 + 2.2]]);
    }
    display_arms();
}
// SELF-LOCK: the display is pressed in from behind (glass into its pocket). Two thin arms (1.2 thick, 14 long, flexing in x) carry lips
// that sit 0.25 over the PCB edge, 0.1 behind its back face (flat catch), with a 45 deg lead-in. Rooted on an outrigger at the plate edge.
module display_arms() for (s = [-1, 1]) {
    x_in  = plate_hw + arm_gap; x_out = x_in + arm_t;                 // arm faces from the centre
    X = function(u) xb + s*u;
    ya = catch_y - 1.15;                                              // arm back end (lip ramp ends here)
    // outrigger + arm (profile in x,z extruded along y)
    translate([0, ya, 0]) rotate([90,0,0]) mirror([0,0,1]) linear_extrude(y_pl + eps - ya)
        polygon([[X(plate_hw - 0.5), arm_z0], [X(x_out), arm_z0 + (x_out - plate_hw + 0.5)], [X(x_out), arm_z1], [X(x_in), arm_z1], [X(x_in), arm_z0 + 2.1], [X(plate_hw - 0.5), arm_z0 + 2.1]]);
    // lip: flat catch at y = catch_y, 45 deg ramp back to the arm face
    lr = x_in - (pcb[0]/2 - lip_ov);
    translate([0, 0, lip_z0]) linear_extrude(lip_z1 - lip_z0)
        polygon([[X(x_in + 0.01), catch_y], [X(x_in - lr), catch_y], [X(x_in + 0.01), catch_y - lr - 0.01]]);
}

// ---- Ellie slots, mapped to the bracket: boards slide in along -y_br from the opening (y_open); stack axis = z_br ----
module slot_side(sx, bw, bt, z0, y_front) {
    xw = sx*stack_w/2; xs = sx*(bw/2 + slot_clr); zt = bt + slot_zclr;
    ya = y_open; yb = y_front + stop_len;
    p  = stack_w/2 - bw/2 + lip_reach;                                // shelf reach under the board edge
    // 45 deg shelf wedge under the long edge (flat top at z0)
    translate([0, ya, 0]) rotate([90,0,0]) mirror([0,0,1]) linear_extrude(yb - ya)
        polygon([[xb + xw, z0], [xb + xw - sx*p, z0], [xb + xw, z0 - p]]);
    // side guide (narrows the slot to the board + clearance) up to the lip
    translate([xb + min(xw, xs), ya, z0 - eps]) cube([abs(xw - xs), yb - ya, zt + 1.0 + eps]);
    // lip over the board edge, full length
    let(xl = sx*(bw/2 - lip_reach)) translate([xb + min(xw, xl), ya, z0 + zt]) cube([abs(xw - xl), yb - ya, 1.0]);
    // front stop: 45 deg underside, stands above the board
    let(p2 = stack_w/2 - bw/2 + stop_reach) intersection() {
        translate([0, y_front, 0]) rotate([90,0,0]) mirror([0,0,1]) linear_extrude(stop_len)
            polygon([[xb + xw, z0 - p2], [xb + xw - sx*p2, z0], [xb + xw - sx*p2, z0 + bt + 1.0], [xb + xw, z0 + bt + 1.0]]);
        translate([200, 0, 0]) cube([200, 200, 200]);   // keep z >= 0 (printed on the bed)
    }
}
module stack() {
    for (sx = [-1, 1]) {
        // side wall (1.2 thick) from the floor to just above the ESP lip, along the whole tray
        translate([xb + sx*(stack_w/2 + st_wall/2) - st_wall/2, y_open, fl_top - 0.3]) cube([st_wall, 49.5 - y_open, stack_top - fl_top + 0.3]);
        translate([xb + sx*(stack_w/2 + st_wall/2) - st_wall/2, y_open, fl_top - 0.3]) cube([st_wall, 53.0 - y_open, 7.9 - fl_top + 0.3]);   // low part runs under the display PCB (z_br < 8.25) to the plate
        slot_side(sx, tp[1],  tp[2],  tp_z0,  y_open + tp[0]);
        slot_side(sx, esp[1], esp[2], esp_z0, y_open + esp[0]);
    }
}
module old_tray_cut() {
    translate([xb - stack_w/2 - 0.1, y_open - 1.0, fl_top]) cube([stack_w + 0.2, cut_y0 - y_open + 1.0, 50]);
    translate([xb - stack_w/2 - 0.1, cut_y0 - 0.1, fl_top]) cube([stack_w + 0.2, 7.0, 5.0]);        // old bar under the TP4056 front end
}

module bracket_new() { difference() { import(BRACKET, convexity = 10); old_frame_cut(); old_tray_cut(); } new_frame(); stack(); }

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

// ---- board dummies (for clash and slide-in checks) ----
module tp_slab()   translate([xb - tp[1]/2, y_open, tp_z0]) cube([tp[1], tp[0], tp[2]]);
module tp_conn()   translate([xb - 4.5, y_open, tp_z0 + tp[2]]) cube([9, 7, usb_h]);
module esp_slab()  translate([xb - esp[1]/2, y_open, esp_z0]) cube([esp[1], esp[0], esp[2]]);
module esp_conn()  translate([xb - 4.5, y_open, esp_z0 + esp[2]]) cube([9, 7, usb_h]);
module tp_dummy()  color("red")  { tp_slab(); tp_conn(); }
module esp_dummy() color("blue") { esp_slab(); esp_conn(); }
module sweep(d = 40) { hull() { children(); translate([0, -d, 0]) children(); } }
if (view == "boards") { tp_dummy(); esp_dummy(); }
if (view == "clash_boards") intersection() { bracket_new(); union() { tp_dummy(); esp_dummy(); } }
// slide-in: each board part must travel from 40 mm outside the opening to its seat without touching the bracket
if (view == "clash_slide_tp")  intersection() { bracket_new(); union() { sweep() tp_slab();  sweep() tp_conn(); } }
if (view == "clash_slide_esp") intersection() { bracket_new(); union() { sweep() esp_slab(); sweep() esp_conn(); } }
if (view == "clash_pcb_frame") intersection() { bracket_new(); pcb_dummy(); }
if (view == "dbg_p1") intersection() { new_frame(); pcb_dummy(); }
if (view == "dbg_p2") intersection() { stack(); pcb_dummy(); }
if (view == "dbg_p3") intersection() { difference() { import(BRACKET, convexity = 10); old_frame_cut(); old_tray_cut(); } pcb_dummy(); }

// ---- display tilt-in test: the module (PCB + glass) hinges on its bottom edge and swings in from tilt deg to 0 ----
module disp_dummy() { pcb_dummy(); glass_dummy(); }
module disp_tilt(t) translate([0, y_pl, 8.25]) rotate([t, 0, 0]) translate([0, -y_pl, -8.25]) disp_dummy();
for (t = [0, 1, 2, 3, 4, 5, 10, 15, 20, 25]) if (view == str("clash_tilt", t)) intersection() { bracket_new(); disp_tilt(t); }
