// DECK BUDDY 1.3" OLED upgrade: new bezel (obj_8) + new display frame in the bracket (obj_1). The body is NOT changed.
// Module (copied from Ellie, elephant/src/main.scad): PCB 35.4 x 33.5 x 1.2, glass 34.5 x 23 x 1.5 (centred on the PCB), view window 31 x 17.
// Coordinates of the bracket = the original STL frame: x across (centre 306.31), y_br front-to-back (frame front at 55.22), z_br up (platform top 8.5).
// The bracket sits in the body with:  x_b = x - 306.31 + 130.95,  y_b = 146.3 - z_br,  z_b = y_br - 24.62   (found by fitting: zero overlap, front face on the wall at z_b = 30.6)
// view = "bracket" | "bezel" | "asm" (body + new parts + a dummy board, for clash checks) | "board"
// v2 (2026-11-15): + Ellie's TWO-BOARD stack (TP4056 + ESP32-C3 Mini in two slots, slide in from the back opening) and a self-locking display mount
// (snap arms with 0.25 mm lips behind the PCB; the board is pressed in from behind). v1 is in backup_before_selflock/deck_buddy_oled13_v1.scad.
// v3 (2026-11-15, three fixes): no front stop on the ESP32 slot; the display rails/arms are REMOVED and replaced by two LOCKING PINS that go through the
// display's 4 mm holes (30 mm apart, near the top); module thickness 3.3 mm overall (PCB 1.2 + glass 2.1). v2 is in backup_before_selflock/deck_buddy_oled13_v2_arms.scad.
view = "bracket";
$fn = 48;
BODY    = "../original/obj_7_corp+face.stl_1.stl";
BRACKET = "../original/obj_1_Yeti Full.stl_1.stl";
BEZEL   = "../original/obj_8_corp+face.stl_2.stl";

// ---- module ----
pcb    = [35.4, 33.5, 1.2];      // x, height, thickness
disp_t = 3.3;                    // overall module thickness (user 2026-11-15): PCB + glass
glass  = [34.5, 23.0, disp_t - pcb[2]];     // glass 2.1 thick
pocket_d = glass[2] + 0.2;       // glass pocket depth in the plate (2.3)
hole_d = 4.0; hole_dx = 30.0; hole_from_top = 3.0;   // display mounting holes: 4 mm, centres 30 mm apart, 3 mm below the top edge (assumed)
win    = [31.0, 17.0];           // what you see
// ---- frame ----
xb     = 306.31;                 // bracket centre
zc     = 25.0;                   // display centre height (= body window centre y_b 121.3)
y_front= 55.22;                  // front face of the old frame plate (touches the wall)
plate_t= pocket_d + 1.2;           // pocket + 1.2 front skin = 3.5
y_pl   = y_front - plate_t;      // plate back face = PCB front face (51.72)
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
            translate([xb, y_front - (plate_t - pocket_d), zc + (plate_t - pocket_d)]) rotate([-90,0,0]) linear_extrude(0.01) rrect([win[0], win[1] + 2*(plate_t - pocket_d)], 2.5);
        }
        // glass pocket from the back, floor at y_pl + pocket_d, top chamfered 45 deg
        translate([xb - 34.9/2, 0, 0]) rotate([90,0,90]) linear_extrude(34.9)
            polygon([[y_pl - 0.5, zc - 23.4/2], [y_pl + pocket_d, zc - 23.4/2], [y_pl + pocket_d, zc + 23.4/2], [y_pl - 0.01, zc + 23.4/2 + pocket_d], [y_pl - 0.5, zc + 23.4/2 + pocket_d + 0.5]]);
    }
    display_pins();
}
// SELF-LOCK PINS: two split pins on the plate go through the display's two 4 mm holes (30 mm apart, near the top edge).
// The hollow pin (OD 3.6, bore 2.0) is split by an X-shaped 0.8 slit (4 petals: left/right/top/bottom); its head is 4.5 wide, so it sits 0.25 over the hole edge, flat catch 0.1 behind the PCB,
// with a 45 deg lead-in. The pin stands on the glass-pocket floor so its flexing length is about 3.6 mm. The module tilts in (bottom first).
pin_od = 3.6; head_od = 4.5; tip_od = 3.2; pin_bore = 2.0; pin_slit = 0.8;
module display_pins() for (sx = [-1, 1]) {
    xp = xb + sx*hole_dx/2; zp = zc + pcb[1]/2 - hole_from_top;
    y_fl = y_pl + pocket_d;                                  // pocket floor (solid plate behind it)
    y_c  = pcb_back - 0.1;                                   // catch plane, 0.1 behind the PCB back face
    y_tip = y_c - 0.95;
    difference() {
        union() {
            translate([xp, y_fl + 0.4, zp]) rotate([90,0,0]) cylinder(d = pin_od, h = y_fl + 0.4 - y_c);         // shaft (root 0.4 inside the plate)
            intersection() {   // head cut flat 0.6 below the pin centre: a lower head makes the slicer report floating regions when printed upright
                translate([xp, y_c, zp]) rotate([90,0,0]) { cylinder(d = head_od, h = 0.3); translate([0,0,0.3]) cylinder(d1 = head_od, d2 = tip_od, h = 0.65); }
                translate([xp - 3, y_tip - 1, zp - 0.6]) cube([6, 3, 6]);   // lock on top + both sides; lower half cut away so no layer floats
            }
        }
        translate([xp, y_pl + 1.0, zp]) rotate([90,0,0]) cylinder(d = pin_bore, h = y_pl + 1.0 - y_tip + 0.1);     // hollow
        for (ang = [45, -45])   // X-shaped split (4 petals: left, right, top, bottom): every overhang is a 45 deg V when printed upright
            translate([xp, 0, zp]) rotate([0, ang, 0]) translate([-3, y_tip - 0.1, -pin_slit/2]) cube([6, y_pl + 1.0 - y_tip + 0.1, pin_slit]);
    }
}

// ---- Ellie slots, mapped to the bracket: boards slide in along -y_br from the opening (y_open); stack axis = z_br ----
module slot_side(sx, bw, bt, z0, y_front, stop = true, y_end = -1) {
    xw = sx*stack_w/2; xs = sx*(bw/2 + slot_clr); zt = bt + slot_zclr;
    ya = y_open; yb = stop ? y_front + stop_len : (y_end > 0 ? y_end : y_front);
    p  = stack_w/2 - bw/2 + lip_reach;                                // shelf reach under the board edge
    // 45 deg shelf wedge under the long edge (flat top at z0)
    translate([0, ya, 0]) rotate([90,0,0]) mirror([0,0,1]) linear_extrude(yb - ya)
        polygon([[xb + xw, z0], [xb + xw - sx*p, z0], [xb + xw, z0 - p]]);
    // side guide (narrows the slot to the board + clearance) up to the lip
    translate([xb + min(xw, xs), ya, z0 - eps]) cube([abs(xw - xs), yb - ya, zt + 1.0 + eps]);
    // lip over the board edge, full length
    let(xl = sx*(bw/2 - lip_reach)) translate([xb + min(xw, xl), ya, z0 + zt]) cube([abs(xw - xl), yb - ya, 1.0]);
    // front stop: 45 deg underside, stands above the board
    if (stop) let(p2 = stack_w/2 - bw/2 + stop_reach) intersection() {
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
        slot_side(sx, esp[1], esp[2], esp_z0, y_open + esp[0], stop = false, y_end = 49.0);   // ESP32: guides and lips only, no front stop (user)
    }
}
module old_tray_cut() {
    translate([xb - stack_w/2 - 0.1, y_open - 1.0, fl_top]) cube([stack_w + 0.2, cut_y0 - y_open + 1.0, 50]);
    translate([xb - stack_w/2 - 0.1, cut_y0 - 0.1, fl_top]) cube([stack_w + 0.2, 7.0, 5.0]);        // old bar under the TP4056 front end
}

module bracket_new() { difference() { import(BRACKET, convexity = 10); old_frame_cut(); old_tray_cut(); } new_frame(); stack(); }

bezel_grow = 0.12;   // press fit: the bezel is 0.12 bigger per side than the window (37.4 x 28.5), was exactly the window size = loose (user 2026-11-15)
module bezel_new() difference() {
    translate([257.59, 43.96, 0]) scale([(37.4 + 2*bezel_grow)/37.4, (28.5 + 2*bezel_grow)/28.5, 1]) translate([-257.59, -43.96, 0]) import(BEZEL, convexity = 10);
    translate([257.59, 43.96, -1]) linear_extrude(8) rrect(win + [0.4, 0.4], 2.5);   // 31.4 x 17.4 through the whole bezel
}

module pcb_dummy() color("green") difference() {
    translate([xb - pcb[0]/2, y_pl - pcb[2], zc - pcb[1]/2]) cube([pcb[0], pcb[2], pcb[1]]);
    for (sx = [-1, 1]) translate([xb + sx*hole_dx/2, y_pl - pcb[2] - 0.1, zc + pcb[1]/2 - hole_from_top]) rotate([-90,0,0]) cylinder(d = hole_d, h = pcb[2] + 0.2);
}
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
