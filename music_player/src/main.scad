// ============================================================
// Project : lilmate MUSIC PLAYER "Tiny Retro PC" (concept L, approved 2026-11-14)
// Look    : proposal/look4.scad (design = 12), previews/r4_12_front.png
// Printer : Bambu Lab A1 mini (180 x 180 x 180), PLA
// Closure : snap-fit everywhere (no screws)
//
// Electronics (see components_L_retro_pc.md):
//   1.3" I2C OLED (CRT screen) - YX6300 serial MP3 (HW-311 layout: microSD + 3.5 mm jack, wired headphones only)
//   ESP32-C3 Super Mini + TP4056 USB-C (both USB-C on the back of the "CRT")
//   Li-Po 503450 (~1000 mAh) flat in the base - SS-12F15 slide switch (back)
//   4 x 6x6x5 tact switches on a perfboard strip (keyboard) - EC11 encoder (volume knob, right side)
//
// Axes: X = left/right, -Y = FRONT, +Y = back, Z = up, Z = 0 = table.
// The monitor front face is the plane y = 0; the monitor stands on the base deck (z = HB).
//
// PRINTED PARTS (each has an overhang-free print orientation, see print_* parts):
//   base      tray: floor + walls, open top (battery + keyboard inside)    -> floor on the bed
//   deck      flat plate = monitor floor + base top (YX6300 posts, lips)   -> bottom on the bed
//   keyplate  sloped key plate + perfboard frame                          -> TOP face on the bed
//   shell     monitor: roof + front + 2 sides, open bottom + back          -> ROOF on the bed (upside down)
//   back      CRT taper back cover: USB-C x2, switch, board rails, lip    -> back plate on the bed
//   keycap x4 (one orange PLAY), knob (orange)                            -> see print_* parts
// ============================================================

/* [Output] */
part = "assembly";   // assembly | exploded | section | check | base | deck | keyplate | shell | back | keycaps | knob | print_*
expl = 0;            // explode distance for "exploded"
$fn  = 96;
eps  = 0.01;

/* [Base] */
BW      = 64;        // base width (x)
by0     = -25;       // base front (y)
by1     = 42;        // base back (y)
HB      = 15;        // deck top height (monitor sits here)
ky      = -1;        // y where the keyboard slope starts (= deck front edge)
ks      = 12;        // keyboard slope angle (deg)
b_r     = 5;         // base plan corner radius
b_er    = 1.5;       // base top edge radius
floor_t = 1.6;
bwall   = 2.0;

/* [Monitor] */
MW    = 58;          // monitor width
MD    = 28;          // front box depth (y 0..MD)
MH    = 50;          // monitor height above the deck
mwall = 2.0;
m_r   = 4;           // monitor edge radius
ft    = 15;          // v2: front face leans back (deg) about the front-bottom edge (y = 0, z = mz0)
TD    = 12;          // CRT taper depth (back cover)
BCW   = 42;          // back plate width
BCH   = 40;          // back plate height
bc_r  = 3;
bc_t  = 2;           // back cover wall
mz0   = HB;          // monitor bottom (global z)

/* [Deck plate] */
dk_t  = 2.0;

/* [Front face] */
pad_t  = 4;          // front wall thickness around the screen
pad    = [48, 36];   // thick pad area (inside), centred 1 mm above the screen (clears the YX6300)
bez    = [46, 31];   // CRT bezel recess (outside)
bez_d  = 1.4;        // bezel depth (45 deg chamfer)
win    = [32, 20];   // screen window (shows the black OLED glass)
fl_bay = [26, 5.4];  // floppy bay recess (outside)
fl_zc  = 3.9;        // floppy bay centre (local z)

/* [OLED 1.3" I2C] */
oled_pcb   = [35.4, 33.5, 1.2];
oled_glass = [34.5, 23, 1.5];
oled_z0    = 9.5;    // pcb bottom (local z above the deck)
bay_clr    = 0.6;
bay_wall   = 1.4;
bay_depth  = 3.5;

/* [YX6300 HW-311] - from listing photos + Catalex manual: CONFIRM WITH CALIPERS */
yx_pcb      = [43, 25, 1.6];   // x (long), y, z
yx_z0       = 4.5;             // board bottom (local z) - SD socket hangs below
yx_x0       = -23.5;           // board left edge (jack end)
yx_y0       = 4.2;             // board front edge (SD mouth side) - v2: 2.4 -> 4.2, clears the slanted front wall
yx_jack_over= 3;               // jack nose sticks out past the board edge
yx_jack_y   = 12.5;            // jack centre from the board front edge
yx_jack_zc  = 2.8;             // jack centre above the board top
yx_jack_d   = 6;
yx_jack_len = 12;
yx_jack_h   = 5.6;
yx_sd       = [14, 15, 1.8];   // microSD socket under the board
yx_sd_xc    = 21.5;            // socket centre from the board left edge

/* [EC11 encoder, right wall] */
ec_y    = 18.6;                // v2: 18 -> 18.6, pins clear the tilted OLED bay
ec_z    = 20;                  // local
ec_hole = 7.4;
ec_body = [6.5, 12, 12];       // depth (x), y, z

/* [Boards in the back cover] - measured (Ellie) */
tp_pcb  = [17, 27, 1.0];       // x, y (length, USB end at the back), z
tp_z    = 14;                  // board bottom (local)
esp_pcb = [18, 22, 1.0];
esp_z   = 26;
usb_c   = [9.6, 3.9];
usb_mold= [13.5, 7.8];
rail_len= 18;

/* [Switch SS-12F15, back plate] */
sw_x     = 13;
sw_z     = 7;                  // local
sw_body  = [11.8, 5.2];        // pocket (x, z)
sw_depth = 5.1;
sw_lever = [3, 3, 4];
sw_travel= 3.2;

/* [Battery 503450] */
bat    = [52, 35, 6];          // bay incl. clearance (x, y, z)
bat_y0 = 3;

/* [Keyboard] */
kt     = 1.8;                  // key plate thickness
kcap   = 12;                   // keycap size
kc_h   = 4.5;                  // keycap height above the plate
kpitch = 14;
kv     = -11.2;                // key centre (local v along the slope)
tact   = [6, 3.5, 5];          // 6x6 body, body height, total height incl. plunger
pb     = [54, 13, 1.6];        // perfboard strip (u, v, thickness) - cut to 54 x 13

/* [Snap fit] */
clr   = 0.15;
lip_h = 3;
lip_t = 1.2;
bump  = 0.35;

// ------------------------------------------------------------
// Derived
// ------------------------------------------------------------
oled_zc = mz0 + oled_z0 + oled_pcb[1]/2;            // screen centre (global z)
glass_y0 = pad_t - oled_glass[2];
bay_in  = [oled_pcb[0] + 2*bay_clr, oled_pcb[1] + 2*bay_clr];
bay_end = pad_t + oled_pcb[2] + bay_depth;
zf      = HB - (ky - by0 - b_er) * tan(ks);         // base front top
bp_y    = MD + TD;                                  // back plate outer face
bp_in   = bp_y - bc_t;                              // back plate inner face
yx_top  = yx_z0 + yx_pcb[2];
jack_p  = [yx_x0 - yx_jack_over, yx_y0 + yx_jack_y, mz0 + yx_top + yx_jack_zc];
sd_x    = yx_x0 + yx_sd_xc;
kp_vf   = (by0 + bwall + 0.2 - ky) / cos(ks);       // key plate front edge (local v)
kp_vb   = -0.5;                                     // key plate back edge
pb_top  = -kt - 0.3 - tact[1];                      // perfboard top (local w)
key_u   = [for (i = [0:3]) (i - 1.5) * kpitch];

// ------------------------------------------------------------
// Helpers
// ------------------------------------------------------------
module rrect(s, r) let(rr = min(r, min(s[0], s[1])/2 - 0.01)) offset(r = rr) offset(delta = -rr) square(s, center = true);
module tdrop(r) hull() { sphere(r); translate([0, 0, r*sqrt(2)]) sphere(0.01); }   // teardrop: 45 deg roof for upside-down printing
module torus(R, r) rotate_extrude() translate([R - r, 0]) circle(r);
module xbox(x0, x1, y0, y1, z0, z1) translate([x0, y0, z0]) cube([x1 - x0, y1 - y0, z1 - z0]);
module on_y(y0, y1) translate([0, y1, 0]) rotate([90, 0, 0]) linear_extrude(y1 - y0) children();    // 2D (x, z) -> solid between y0 and y1
module on_x(x0, x1) translate([x0, 0, 0]) rotate([90, 0, 90]) linear_extrude(x1 - x0) children();   // 2D (y, z) -> solid between x0 and x1
module kframe() translate([0, ky, HB]) rotate([ks, 0, 0]) children();                               // key-plate local (u, v, w): top at w = 0
module ftilt() translate([0, 0, mz0]) rotate([-ft, 0, 0]) translate([0, 0, -mz0]) children();          // v2: onto the slanted front face
module keyplane_below(off = 0) kframe() translate([-100, -100, -100 - off]) cube([200, 200, 100]);   // half-space under the key plate top (- off)

// ------------------------------------------------------------
// BASE TRAY
// ------------------------------------------------------------
module base_outer() hull() for (sx = [-1, 1]) {
    for (y = [by0 + b_r, by1 - b_r]) translate([sx*(BW/2 - b_r), y, 0]) {
        cylinder(r1 = b_r - 0.6, r2 = b_r, h = 0.6);                 // 0.6 chamfer (no elephant foot)
        translate([0, 0, 0.6]) cylinder(r = b_r, h = 1);
    }
    translate([sx*(BW/2 - b_r), by1 - b_r, HB - b_er]) torus(b_r, b_er);
    translate([sx*(BW/2 - b_er), ky, HB - b_er]) sphere(b_er);
    translate([sx*(BW/2 - b_r), by0 + b_r, zf - b_er]) torus(b_r, b_er);
}
module base_plan_in(o = 0) translate([0, (by0 + by1)/2]) rrect([BW - 2*bwall - 2*o, by1 - by0 - 2*bwall - 2*o], b_r - bwall - o);
module base_cavity() translate([0, 0, floor_t]) linear_extrude(100) base_plan_in();

module base_ribs() {
    xi = BW/2 - bwall;
    // under the deck plate
    for (sx = [-1, 1], y = [8, 22, 34]) xbox(sx*xi - (sx > 0 ? 1.4 : 0), sx*xi + (sx < 0 ? 1.4 : 0), y - 1.5, y + 1.5, 0, HB - dk_t);
    for (x = [-15, 0, 15]) xbox(x - 1.5, x + 1.5, by1 - bwall - 1.4, by1 - bwall + eps, 0, HB - dk_t);
    // cross wall at the deck front edge: carries the deck front edge AND the key plate back edge (wire notch in the middle)
    difference() {
        xbox(-xi, xi, ky - 0.8, ky + 0.8, 0, HB - dk_t);
        xbox(-8, 8, ky - 1, ky + 1, floor_t - eps, floor_t + 6);
    }
    // under the key plate: side ribs + front ribs, tops follow the plate underside
    intersection() {
        union() {
            for (sx = [-1, 1], y = [-8, -18]) xbox(sx*xi - (sx > 0 ? 1.4 : 0), sx*xi + (sx < 0 ? 1.4 : 0), y - 1.5, y + 1.5, 0, HB);
            for (x = [-22, 0, 22]) xbox(x - 1.5, x + 1.5, by0 + bwall - eps, by0 + bwall + 1.4, 0, HB);
        }
        keyplane_below(kt / cos(ks) + 0.05);
    }
    // battery bay ribs (3 mm high)
    for (sx = [-1, 1]) xbox(sx*(bat[0]/2) - (sx < 0 ? 1.2 : 0), sx*(bat[0]/2) + (sx > 0 ? 1.2 : 0), bat_y0 + 3, bat_y0 + bat[1] - 3, 0, floor_t + 3);
    xbox(-18, 18, bat_y0 - 1.2, bat_y0, 0, floor_t + 3);
}
// snap grooves in the tray walls for the plate edge bumps
module base_grooves() {
    xi = BW/2 - bwall;
    for (sx = [-1, 1], y = [10, 30]) xbox(sx*xi - 0.45, sx*xi + 0.45, y - 4.5, y + 4.5, HB - dk_t/2 - 0.5, HB - dk_t/2 + 0.5);
    for (sx = [-1, 1], v = [-6, -16]) kframe() xbox(sx*xi - 0.45, sx*xi + 0.45, v - 4.5, v + 4.5, -kt/2 - 0.5, -kt/2 + 0.5);
}
module base() difference() {
    union() {
        difference() { base_outer(); base_cavity(); }
        intersection() { base_ribs(); base_outer(); }
    }
    base_grooves();
}

// ------------------------------------------------------------
// DECK PLATE (monitor floor + base top). Bottom face on the bed.
// ------------------------------------------------------------
module deck2d() intersection() { base_plan_in(0.2); translate([-50, ky]) square([100, 100]); }
module deck() difference() {
    union() {
        translate([0, 0, HB - dk_t]) linear_extrude(dk_t) deck2d();
        // edge bumps (click into the tray grooves)
        for (sx = [-1, 1], y = [10, 30]) xbox(sx*(BW/2 - bwall - 0.2) - 0.3, sx*(BW/2 - bwall - 0.2) + 0.3, y - 4, y + 4, HB - dk_t/2 - 0.35, HB - dk_t/2 + 0.35);
        // monitor lips (inside the shell side walls) with outward bumps
        for (sx = [-1, 1]) {
            x_o = MW/2 - mwall - clr;
            xbox(sx > 0 ? x_o - lip_t : -x_o, sx > 0 ? x_o : -x_o + lip_t, 4, 22, HB - eps, HB + lip_h);
            translate([sx*x_o, 13, HB + 1.8]) rotate([0, 90, 0]) linear_extrude(2*bump, center = true) rrect([1.2, 8], 0.5);
        }
        // YX6300 posts (left-back, mid-back) + right snap post
        for (p = [[-20, 24], [6, 24], [yx_x0 + 3, yx_y0 + 3.6]]) translate([p[0], p[1], HB - eps]) post(yx_z0);
        yx_hook();
    }
    // wire pass-through (battery + keys -> back cover)
    translate([-14, 34, HB - dk_t - 1]) linear_extrude(dk_t + 2) rrect([12, 7], 2);
}
module post(h) hull() { translate([-1.5, -1.5, 0]) cube([3, 3, h - 0.5]); translate([-1.1, -1.1, 0]) cube([2.2, 2.2, h]); }
module yx_hook() {           // right end of the YX6300: post beside the board edge, hook over the board top (ramp on top)
    xe = yx_x0 + yx_pcb[0];
    translate([0, 0, HB - eps]) {
        xbox(xe + 0.2, xe + 2.6, 12, 18, 0, yx_top + 2.2);
        hull() {
            xbox(xe - 0.5, xe + 2.6, 12, 18, yx_top + 0.15, yx_top + 0.75);
            xbox(xe + 0.2, xe + 2.6, 12, 18, yx_top + 0.15, yx_top + 2.2);
        }
    }
}

// ------------------------------------------------------------
// KEY PLATE (local u, v, w) + perfboard frame. Printed TOP face down.
// ------------------------------------------------------------
module kp2d() intersection() {   // front corners rounded like the tray inside
    translate([0, (kp_vf + kp_vb)/2]) square([BW - 2*bwall - 0.4, kp_vb - kp_vf], center = true);
    translate([0, kp_vf + 20]) rrect([BW - 2*bwall - 0.4, 40], b_r - bwall + 0.2);
}
module keyplate_local() difference() {
    union() {
        translate([0, 0, -kt]) linear_extrude(kt) kp2d();
        // side edge bumps (click into the sloped tray grooves)
        for (sx = [-1, 1], v = [-6, -16]) xbox(sx*(BW/2 - bwall - 0.2) - 0.3, sx*(BW/2 - bwall - 0.2) + 0.3, v - 4, v + 4, -kt/2 - 0.35, -kt/2 + 0.35);
        // perfboard frame: two end walls, stop ledge above the board, snap hook below it
        for (sx = [-1, 1]) {
            xo = pb[0]/2 + 0.25;
            mirror([sx < 0 ? 1 : 0, 0, 0]) {
                xbox(xo, xo + 1.2, kv - pb[1]/2, kv + pb[1]/2, pb_top - pb[2] - 1.0, -kt + eps);
                xbox(xo - 0.8, xo + eps, kv - pb[1]/2, kv + pb[1]/2, pb_top, pb_top + 0.8);                       // stop
                hull() {                                                                                            // hook (ramp)
                    xbox(xo - 0.6, xo + eps, kv - pb[1]/2, kv + pb[1]/2, pb_top - pb[2] - 0.6, pb_top - pb[2] - 0.05);
                    xbox(xo - 0.01, xo + eps, kv - pb[1]/2, kv + pb[1]/2, pb_top - pb[2] - 1.0, pb_top - pb[2] - 0.05);
                }
            }
        }
    }
    for (u = key_u) translate([u, kv, -kt - 1]) linear_extrude(kt + 2) rrect([kcap + 0.4, kcap + 0.4], 2.2);
}
module keyplate() kframe() keyplate_local();

// ------------------------------------------------------------
// KEYCAP (local: origin = plate top at the key centre)
// ------------------------------------------------------------
module icon(i) {
    if (i == 0) polygon([[1.1, -1.7], [1.1, 1.7], [-1.6, 0]]);                         // prev
    if (i == 1) polygon([[-1.2, -2.0], [-1.2, 2.0], [2.0, 0]]);                        // play
    if (i == 2) polygon([[-1.1, -1.7], [-1.1, 1.7], [1.6, 0]]);                        // next
    if (i == 3) { for (s = [-1, 1]) translate([s*1.2, 0.6]) circle(0.6, $fn = 16);      // face mode
                  translate([0, -0.6]) difference() { circle(1.4, $fn = 32); translate([-2, -0.25]) square(4); circle(0.8, $fn = 32); } }
}
module keycap_local(i = 0) difference() {
    union() {
        translate([0, 0, -kt - 0.9]) linear_extrude(0.8) rrect([kcap, kcap + 1.8], 2.2);                 // flange under the plate (front + back only: clears the perfboard frame)
        hull() {
            translate([0, 0, -kt - 0.9]) linear_extrude(0.1) rrect([kcap, kcap], 2.2);
            translate([0, 0, kc_h - 0.1]) linear_extrude(0.1) rrect([kcap - 1.6, kcap - 1.6], 1.8);
        }
    }
    translate([0, 0, kc_h + 30 - 0.6]) sphere(30, $fn = 160);                                           // dished top
    translate([0, 0, kc_h - 1.1]) linear_extrude(2) icon(i);                                             // engraved icon (paint)
    translate([0, 0, -kt - 1]) linear_extrude(pb_top + tact[1] + 0.3 + kt + 1) rrect([tact[0] + 0.8, tact[0] + 0.8], 0.5);   // switch body clearance
    translate([0, 0, -kt - 1]) cylinder(d = 4.2, h = pb_top + tact[2] + 0.2 + kt + 1, $fn = 40);        // plunger cup
}
module keycaps() for (i = [0:3]) kframe() translate([key_u[i], kv, 0]) keycap_local(i);

// ------------------------------------------------------------
// MONITOR SHELL (roof + front + sides). Printed upside down (roof on the bed).
// ------------------------------------------------------------
// v2: front corners follow the face plane y = (z - mz0) tan(ft); back corners unchanged
module mon_raw(r, extra_y = 0) hull() for (sx = [-1, 1]) {
    translate([sx*(MW/2 - m_r), m_r/cos(ft) + (MH - m_r)*tan(ft), mz0 + MH - m_r]) tdrop(r);
    translate([sx*(MW/2 - m_r), m_r - 9*tan(ft), mz0 - 10]) cylinder(r = r, h = 1);
    translate([sx*(MW/2 - m_r), MD + m_r + extra_y, mz0 + MH - m_r]) tdrop(r);
    translate([sx*(MW/2 - m_r), MD + m_r + extra_y, mz0 - 10]) cylinder(r = r, h = 1);
}
module mon_outer() intersection() { mon_raw(m_r); xbox(-MW, MW, 0, MD, mz0, mz0 + MH); }
module mon_inner() intersection() { mon_raw(m_r - mwall, 10); xbox(-MW, MW, mwall, MD + 10, mz0 - 10, mz0 + MH - mwall); }
// 2D inner outline (x, z) for the back-cover lip
module mon_in2d(o) offset(r = -o) translate([0, mz0 - 10 + (MH - mwall + 10)/2]) rrect([MW - 2*mwall, MH - mwall + 10], m_r - mwall);   // z from mz0-10 to the inner roof

module front_cuts() {
    ftilt() face_cuts();
    // microSD slot stays level (card slides straight into the socket), through the slanted wall
    on_y(-1, yx_y0) translate([sd_x, mz0 + yx_z0 - yx_sd[2] + 1.0]) rrect([13.5, 2.4], 0.6);
}
module face_cuts() {
    // CRT bezel recess with 45 deg walls
    hull() {
        on_y(-1, eps) translate([0, oled_zc]) rrect(bez, 4);
        on_y(bez_d - eps, bez_d) translate([0, oled_zc]) rrect(bez - [2*bez_d, 2*bez_d], 4 - bez_d);
    }
    on_y(-1, pad_t + 1) translate([0, oled_zc]) rrect(win, 1.5);                                         // screen window
    on_y(glass_y0, pad_t + eps) translate([0, oled_zc]) rrect([oled_glass[0] + 1.2, oled_glass[1] + 1.2], 0.6);   // glass pocket
    // floppy bay + microSD slot
    on_y(-1, 0.8) translate([sd_x + 2, mz0 + fl_zc]) rrect(fl_bay, 1.2);
    on_y(-1, 0.5) translate([MW/2 - 9, mz0 + fl_zc]) circle(d = 2.2, $fn = 32);   // power-LED dot: v2 dimple (a raised pip is a mid-air island on the slanted face)
}
module front_details() {
    // eject button (inside the floppy bay): paint orange; the power-LED dot is a dimple in face_cuts()
    on_y(0.2, 1) translate([sd_x + 11, mz0 + fl_zc]) rrect([4.4, 2.2], 0.8);
}
module side_cuts() {
    // left: headphone jack + vents ; right: EC11
    translate([-MW/2 - 1, jack_p[1], jack_p[2]]) rotate([0, 90, 0]) cylinder(d = 7.2, h = mwall + 2, $fn = 48);
    translate([-MW/2 - 1, jack_p[1], jack_p[2]]) rotate([0, 90, 0]) cylinder(d = 9.2, h = 1.6, $fn = 48);   // shallow counterbore
    for (k = [0:4]) on_x(-MW/2 - 1, -MW/2 + mwall + 1) translate([15, mz0 + 24 + k*4]) rrect([12, 1.6], 0.8);
    translate([MW/2 - mwall - 1, ec_y, mz0 + ec_z]) rotate([0, 90, 0]) cylinder(d = ec_hole, h = mwall + 2, $fn = 48);
}
module oled_bay() {
    for (sx = [-1, 1]) {
        xbox(sx > 0 ? bay_in[0]/2 : -bay_in[0]/2 - bay_wall, sx > 0 ? bay_in[0]/2 + bay_wall : -bay_in[0]/2,
             pad_t - eps, bay_end, oled_zc - bay_in[1]/2, oled_zc + bay_in[1]/2);
        // snap bump behind the pcb (ramp toward the back opening)
        translate([sx*bay_in[0]/2, 0, oled_zc]) hull() {
            translate([-sx*0.6 - 0.01, pad_t + oled_pcb[2] + 0.1, -5]) cube([0.02, 0.01, 10]);
            translate([-0.01, pad_t + oled_pcb[2] + 0.1, -5]) cube([0.02, bay_end - pad_t - oled_pcb[2] - 0.1, 10]);
        }
    }
}
module yx_ledges() {          // hold the YX6300 front edge while the shell is lowered onto the deck
    for (x = [yx_x0 + 3, yx_x0 + yx_pcb[0] - 4]) xbox(x - 2, x + 2, mwall - eps, yx_y0 + 1.4, mz0 + yx_z0 - 1.2, mz0 + yx_z0);
}
module shell_dimples() {
    // for the deck lip bumps
    for (sx = [-1, 1]) translate([sx*(MW/2 - mwall), 13, mz0 + 1.8]) rotate([0, 90, 0]) linear_extrude(1.0, center = true) rrect([1.6, 9], 0.6);
    // for the back cover lip bumps
    for (sx = [-1, 1]) translate([sx*(MW/2 - mwall), MD - lip_h/2, mz0 + 25]) rotate([0, 90, 0]) linear_extrude(1.0, center = true) rrect([9, 1.6], 0.6);
    translate([0, MD - lip_h/2, mz0 + MH - mwall]) linear_extrude(1.0, center = true) rrect([9, 1.6], 0.6);
}
module shell() difference() {
    union() {
        difference() { mon_outer(); mon_inner(); }
        intersection() {   // thick pad behind the screen, 45 deg edges (no flat shelf when printed upside down)
            ftilt() hull() { on_y(mwall - 0.5, mwall) translate([0, oled_zc + 1]) rrect(pad + [2*(pad_t - mwall), 2*(pad_t - mwall)], 3); on_y(pad_t - eps, pad_t) translate([0, oled_zc + 1]) rrect(pad, 3); }
            mon_outer();
        }
        ftilt() oled_bay();
        yx_ledges();
        ftilt() front_details();
    }
    front_cuts();
    side_cuts();
    shell_dimples();
}

// ------------------------------------------------------------
// BACK COVER (CRT taper). Printed back plate down.
// ------------------------------------------------------------
module bp2d(o = 0) translate([0, mz0 + BCH/2 - 5]) offset(r = -o) offset(r = bc_r) offset(delta = -bc_r) square([BCW, BCH + 10], center = true);
module bc_outer() intersection() {
    hull() {
        intersection() { mon_raw(m_r); xbox(-MW, MW, MD - eps, MD, mz0 - 10, mz0 + MH); }
        on_y(bp_y - 0.6, bp_y - 0.5) bp2d();
        on_y(bp_y - eps, bp_y) bp2d(0.5);                  // 0.5 chamfer on the bed edge
    }
    xbox(-MW, MW, MD, bp_y, mz0, mz0 + MH);
}
module bc_inner() hull() {
    on_y(MD - 1, MD + eps) mon_in2d(clr + lip_t);      // starts at the lip inner face -> no ledge at the joint
    on_y(bp_in - eps, bp_in) bp2d(bc_t);
}
module bc_lip() {
    on_y(MD - lip_h, MD + eps) intersection() {
        difference() { mon_in2d(clr); mon_in2d(clr + lip_t); }
        translate([-50, mz0]) square([100, 100]);
    }
    // bumps
    x_o = MW/2 - mwall - clr;
    for (sx = [-1, 1]) translate([sx*x_o, MD - lip_h/2, mz0 + 25]) rotate([0, 90, 0]) linear_extrude(2*bump, center = true) rrect([8, 1.2], 0.5);
    translate([0, MD - lip_h/2, mz0 + MH - mwall - clr]) linear_extrude(2*bump, center = true) rrect([8, 1.2], 0.5);
}
module rails(w, z0) for (sx = [-1, 1]) mirror([sx < 0 ? 1 : 0, 0, 0]) difference() {
    xbox(w/2 - 0.8, w/2 + 1.6, bp_in - rail_len, bp_in + eps, mz0 + z0 - 2, mz0 + z0 + 1 + 2.2);
    xbox(w/2 - 0.8 - eps, w/2 + 0.2, bp_in - rail_len - 1, bp_in + 1, mz0 + z0 - 0.1, mz0 + z0 + 1.15);
}
module rail_bumps(w, z0) for (sx = [-1, 1]) mirror([sx < 0 ? 1 : 0, 0, 0])
    xbox(w/2 - 0.8, w/2 + 0.2, bp_in - 8, bp_in - 5, mz0 + z0 + 1.0, mz0 + z0 + 1.15 + eps);     // 0.15 squeeze on the board top
module switch_tower() {
    yb = bp_in - sw_depth - 1.2;
    difference() {
        on_y(yb, bp_in + eps) translate([sw_x, mz0 + sw_z]) square(sw_body + [2.4, 2.4], center = true);
        on_y(yb - 1, bp_in + 1) translate([sw_x, mz0 + sw_z]) square(sw_body, center = true);
    }
    for (sz = [-1, 1]) xbox(sw_x - 3, sw_x + 3, yb + 0.2, yb + 1.1, mz0 + sw_z + sz*sw_body[1]/2 - (sz > 0 ? 0.4 : 0), mz0 + sw_z + sz*sw_body[1]/2 + (sz < 0 ? 0.4 : 0));
}
module back_cuts() {
    for (z = [tp_z, esp_z]) {
        on_y(bp_in - 1, bp_y + 1) translate([0, mz0 + z + 1 + 1.6]) rrect(usb_c, 1.6);
        on_y(bp_y - 1.0, bp_y + 1) translate([0, mz0 + z + 1 + 1.6]) rrect(usb_mold, 2.4);
    }
    // switch: lever slot + finger niche
    on_y(bp_in - 1, bp_y + 1) translate([sw_x, mz0 + sw_z]) rrect([sw_lever[0] + sw_travel + 0.8, sw_lever[1] + 0.6], 0.8);
    on_y(bp_y - 0.8, bp_y + 1) translate([sw_x, mz0 + sw_z]) rrect([sw_lever[0] + sw_travel + 4.8, sw_lever[1] + 3.6], 1.6);
    // small vent grille on the CRT back (engraved slots)
    for (k = [0:3]) on_y(bp_y - 0.8, bp_y + 1) translate([-12, mz0 + 26 + k*3]) rrect([10, 1.4], 0.7);
}
module back() difference() {
    union() {
        difference() { bc_outer(); bc_inner(); }
        bc_lip();
        intersection() { union() { rails(tp_pcb[0], tp_z); rails(esp_pcb[0], esp_z); switch_tower(); } bc_outer(); }
        rail_bumps(tp_pcb[0], tp_z); rail_bumps(esp_pcb[0], esp_z);
    }
    back_cuts();
}

// ------------------------------------------------------------
// KNOB (local: axis z, z = 0 = face toward the wall)
// ------------------------------------------------------------
kn_d = 14; kn_h = 7;
module knob_local() difference() {
    hull() { cylinder(d = kn_d, h = kn_h - 0.8); cylinder(d = kn_d - 1.6, h = kn_h); }
    for (a = [0:15:359]) rotate(a) translate([kn_d/2 + 0.15, 0, -1]) cylinder(r = 0.7, h = kn_h + 2, $fn = 12);
    translate([0, 0, -eps]) cylinder(d = 11.6, h = 2.6, $fn = 6);                       // nut + bushing recess
    translate([0, 0, 2.6 - eps]) intersection() { cylinder(d = 6.15, h = kn_h - 0.8 - 2.6, $fn = 40); translate([-4, -3.2, 0]) cube([8, 3.2 + 4.6 - 3.075 + 0.05, 20]); }  // D-shaft 6 / flat 4.6
}
module knob() translate([MW/2 + 0.4, ec_y, mz0 + ec_z]) rotate([0, 90, 0]) knob_local();

// ------------------------------------------------------------
// ELECTRONICS DUMMIES (for fit check + section views)
// ------------------------------------------------------------
module e_oled() ftilt() {
    color([0.1, 0.3, 0.6]) xbox(-oled_pcb[0]/2, oled_pcb[0]/2, pad_t, pad_t + oled_pcb[2], mz0 + oled_z0, mz0 + oled_z0 + oled_pcb[1]);
    color([0.05, 0.05, 0.05]) on_y(glass_y0, pad_t) translate([0, oled_zc]) square([oled_glass[0], oled_glass[1]], center = true);
    color([0.6, 0.6, 0.6]) xbox(-6, 6, pad_t + oled_pcb[2], pad_t + oled_pcb[2] + 3, mz0 + oled_z0 + oled_pcb[1] - 2.6, mz0 + oled_z0 + oled_pcb[1] - 0.4);   // soldered wires
}
module e_yx() {
    color([0.1, 0.35, 0.8]) xbox(yx_x0, yx_x0 + yx_pcb[0], yx_y0, yx_y0 + yx_pcb[1], mz0 + yx_z0, mz0 + yx_top);
    color([0.75, 0.75, 0.75]) xbox(sd_x - yx_sd[0]/2, sd_x + yx_sd[0]/2, yx_y0, yx_y0 + yx_sd[1], mz0 + yx_z0 - yx_sd[2], mz0 + yx_z0);
    color([0.15, 0.15, 0.15]) {
        translate([jack_p[0], jack_p[1], jack_p[2]]) rotate([0, 90, 0]) cylinder(d = yx_jack_d, h = 3);
        xbox(yx_x0 - yx_jack_over + 3, yx_x0 - yx_jack_over + yx_jack_len, jack_p[1] - 3.2, jack_p[1] + 3.2, mz0 + yx_top, mz0 + yx_top + yx_jack_h);
        xbox(yx_x0 + 14, yx_x0 + 26, yx_y0 + 6, yx_y0 + 14, mz0 + yx_top, mz0 + yx_top + 1.6);     // chip
    }
}
module e_ec11() color([0.7, 0.7, 0.72]) {
    xbox(MW/2 - mwall - ec_body[0], MW/2 - mwall, ec_y - 6, ec_y + 6, mz0 + ec_z - 6, mz0 + ec_z + 6);
    xbox(MW/2 - mwall - ec_body[0] - 3.5, MW/2 - mwall - ec_body[0], ec_y - 5, ec_y + 5, mz0 + ec_z - 6, mz0 + ec_z - 4);   // pins
    translate([MW/2 - mwall, ec_y, mz0 + ec_z]) rotate([0, 90, 0]) { cylinder(d = 7, h = 5); cylinder(d = 6, h = 12); }
    translate([MW/2, ec_y, mz0 + ec_z]) rotate([0, 90, 0]) cylinder(d = 11, h = 2, $fn = 6);
}
module e_board(p, z0, col) color(col) {
    xbox(-p[0]/2, p[0]/2, bp_in - 0.3 - p[1], bp_in - 0.3, mz0 + z0, mz0 + z0 + p[2]);
    xbox(-4.5, 4.5, bp_in - 7.5, bp_in, mz0 + z0 + p[2], mz0 + z0 + p[2] + 3.2);          // USB-C
    xbox(-p[0]/2 + 2, p[0]/2 - 2, bp_in - p[1], bp_in - 9, mz0 + z0 + p[2], mz0 + z0 + p[2] + 1.8);   // parts
}
module e_switch() color([0.75, 0.75, 0.75]) {
    xbox(sw_x - 5.25, sw_x + 5.25, bp_in - sw_depth, bp_in, mz0 + sw_z - 2.25, mz0 + sw_z + 2.25);
    xbox(sw_x - 1.5, sw_x + 1.5, bp_in, bp_in + sw_lever[2], mz0 + sw_z - 1.5, mz0 + sw_z + 1.5);
}
module e_battery() color([0.85, 0.85, 0.88]) xbox(-25.5, 25.5, bat_y0 + 0.5, bat_y0 + 34.5, floor_t + 0.1, floor_t + 5.1);
module e_keys() kframe() {
    color([0.1, 0.5, 0.2]) xbox(-pb[0]/2, pb[0]/2, kv - pb[1]/2, kv + pb[1]/2, pb_top - pb[2], pb_top);
    for (u = key_u) translate([u, kv, pb_top]) {
        color([0.2, 0.2, 0.2]) translate([-tact[0]/2, -tact[0]/2, 0]) cube([tact[0], tact[0], tact[1]]);
        color([0.1, 0.1, 0.1]) cylinder(d = 3.5, h = tact[2]);
    }
}
module electronics() { e_oled(); e_yx(); e_ec11(); e_board(tp_pcb, tp_z, [0.2, 0.2, 0.6]); e_board(esp_pcb, esp_z, [0.15, 0.15, 0.15]); e_switch(); e_battery(); e_keys(); }

// ------------------------------------------------------------
// Assembly / views
// ------------------------------------------------------------
c_body = [0.90, 0.84, 0.72]; c_key = [0.74, 0.71, 0.66]; c_acc = [0.98, 0.52, 0.22];
module printed(e = 0) {
    color(c_body) base();
    color(c_body) translate([0, 0, e*0.6]) deck();
    color(c_body) translate([0, -e*0.6, e*0.6]) keyplate();
    for (i = [0:3]) color(i == 1 ? c_acc : c_key) translate([0, -e*0.6, e*1.3]) kframe() translate([key_u[i], kv, 0]) keycap_local(i);
    color(c_body) translate([0, 0, e*1.5]) shell();
    color(c_body) translate([0, e*1.0, e*1.5]) back();
    color(c_acc) translate([e*0.8, 0, e*1.5]) knob();
}
module all_printed() { base(); deck(); keyplate(); keycaps(); shell(); back(); knob(); }

if (part == "assembly")  printed(0);
if (part == "exploded")  { printed(expl); }
if (part == "section")   { intersection() { printed(0); xbox(-100, 100, -100, 100, -1, 200); } electronics(); }
if (part == "electronics") electronics();
if (part == "check")     intersection() { all_printed(); electronics(); }            // must be EMPTY
if (part == "base")      base();
if (part == "deck")      deck();
if (part == "keyplate")  keyplate();
if (part == "keycaps")   keycaps();
if (part == "shell")     shell();
if (part == "back")      back();
if (part == "knob")      knob();
// print orientations (all sit on z = 0)
if (part == "print_base")     base();
if (part == "print_deck")     translate([0, 0, -(HB - dk_t)]) deck();
if (part == "print_keyplate") mirror([0, 0, 1]) keyplate_local();                     // top face on the bed
if (part == "print_shell")    translate([0, 0, mz0 + MH]) mirror([0, 0, 1]) shell();  // roof on the bed
if (part == "print_back")     translate([0, 0, bp_y]) rotate([-90, 0, 0]) back();   // back plate on the bed
if (part == "print_keycap")   for (i = [0:3]) translate([(i - 1.5)*18, 0, kt + 0.9]) keycap_local(i);
ki = 0;
if (part == "print_keycap_i") translate([0, 0, kt + 0.9]) keycap_local(ki);           // one keycap (0 prev, 1 PLAY, 2 next, 3 face)
if (part == "print_knob")     translate([0, 0, kn_h]) mirror([0, 0, 1]) knob_local();
