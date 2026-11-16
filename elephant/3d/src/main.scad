// ============================================================
// Project : ELLIE the elephant desk buddy (lilmate) - one-piece main body + snap-on back lid
// Look approved from elephant/proposal/look_front.png ; electronics + mechanics from pengu_chubby (proven)
// Ref     : pengu_chubby/reference.jpeg (sitting chubby penguin, curled tuft,
//           widow's-peak hood, wide pill visor, mitten wings, paw feet)
// Printer : Bambu Lab A1 mini (180 x 180 x 180 mm)
// Material: WOL3D PLA Pro+, single colour (paint optional)
// Closure : snap-fit (front lip + bumps -> back rebate + dimples)
//
// Electronics (same as pengu v1/v2):
//   1.3" I2C OLED (behind the visor) - ESP32-C3 Mini + TP4056 (back, ports out)
//   300 mAh Li-Po 502030 (floor) - slide switch (back) - TTP223 (under head top)
//
// Axes: X = left/right, -Y = FRONT (face), +Y = back, Z = up, Z=0 = table.
// The model splits on the plane Y = split_y into FRONT and BACK shells.
// ============================================================

/* [Output] */
part = "assembly";
ci   = -1;
$fn  = 160;
eps  = 0.01;

/* [Shell] */
wall      = 2.2;
split_y   = 13;
lip_h     = 3.0;
lip_keep  = 1.4;        // lid outer skin kept at the seam (was 0.9: too thin to hold a catch) - v8
lip_clr   = 0.12;       // tighter snap = no visible gap at the seam
seam_ch   = 0.35;       // small matching chamfer on both seam edges (clean, even line)
snap_h    = 0.60;       // catch height (was 0.40) - v8 stronger lock
snap_y0   = 0.8;        // steep holding face sits this far behind the seam plane
snap_top  = 0.8;        // flat top of the catch
snap_ramp = 1.2;        // gentle lead-in ramp (~27 deg): easy to push on, hard to pull off
snap_n    = 4;          // ramp steps (smooth when printed)

/* [Screw fit] */
// v10: the snap (3 failed prints) is replaced by 4 x M2 x 10 pan-head screws, lid -> body. Lip + rebate stay as the locator only.
screw_on     = true;
snap_on      = !screw_on;               // snap bumps + dimples (off when screws are used)
scr_pts      = [[-23, 72], [23, 72], [-18, 14], [18, 14]];   // screw axes (x, z), all parallel to Y
scr_boss_d   = 7.6;                     // boss outside diameter
scr_body_len = 8;                       // body boss length behind the seam
scr_reach    = 6;                       // the boss grows this far sideways into the wall (45 deg underside, prints upright)
scr_pilot    = 1.8;                     // pilot hole in the body boss: M2 self-tapping into PLA
scr_pilot_len= 7.2;                     // pilot depth (the 10 mm screw ends 5.8-6.4 behind the seam)
scr_clear    = 2.4;                     // clearance hole in the lid
scr_head_d   = 4.6;                     // head pocket in the lid skin
scr_head_h   = 1.3;                     // pocket depth at its low (outer) edge = M2 pan head height
scr_gap      = 0.1;                     // lid boss stops this far behind the seam plane

/* [Body: round sitting ball] */
body_cy  = 3;
body_R   = 26.5;
body_sy  = 0.9;
body_zm  = 20;
body_alo = 35;
body_aup = 26;
body_fil = 3;

/* [Head] */
head_c   = [0, 0, 65];
head_rx  = 30;          // lobe x radius (half width = head_sx + head_rx = 34)          // lobe x radius (half width = head_sx + head_rx = 31)          // radius of each lobe in x  (half width = head_sx + head_rx = 37)
head_ry  = 29;          // depth radius (front/back)
head_sx  = 4;           // tiny flat -> reads as a round head          // flat-ish front: lobes offset +-x
head_top = [5, 22];     // top at +27     // top at +25     // upper lobes: z offset, z radius  -> top at +29
head_bot = [-8, 18];    // bottom at -26   // bottom at -24   // lower lobes: z offset, z radius  -> bottom at -27 (full chin)

/* [Face] */
rim_r      = 2.0;       // hood edge ridge radius (bolder, prints smoother)
visor_half = [22, 10.25];
visor_rad  = 10;
visor_dz   = 0;      // visor centre vs head centre (sits low like the reference)
visor_rec  = 1.2;

/* [OLED] */
oled_pcb    = [35.4, 33.5, 1.2];
oled_glass_t= 1.5;
oled_win    = [31, 17];
oled_win_dz = 0;
y_if        = -19.3;    // OLED glass front plane (solved for the round head; pcb corners keep >=1 mm skin)
bay_clr     = 0.6;      // OLED pcb clearance per side (was 0.25: too tight)
bay_depth   = 3.5;      // holder depth behind the pcb (short = easy to fit)
bay_wall    = 1.4;

/* [ESP32-C3 Mini + TP4056] */
// [length (y, slides in), width (x), thickness]  - measured by the user 2026-11-14
esp_pcb   = [22.0, 18.0, 1.0];      // board 1: 18 W x 22 L x 1
tp_pcb    = [27.0, 17.0, 1.0];      // board 2: 17 W x 27 L x 1
slot_clr  = 0.2;                    // side clearance per side -> slot = board width + 0.4
slot_zclr = 0.3;                    // clearance above the board under the lip
stop_len  = 2.0;                    // front stop length (y)
stop_reach= 2.5;                    // how far the front stop reaches over the board edge
board_y1  = split_y;                // the ESP32's back edge ends FLUSH with the body's back opening
tp_stop_depth = 27;                 // v10: TP4056 back end ends FLUSH with the body opening (like Pengu) -> USB-C niche in the lid is 7.25 mm deep (was 22: board stuck 5 mm into the lid, niche only 2.25 deep)
usb_h     = 3.3;
usb_hole  = [9.6, 3.9];            // horizontal USB-C opening (x, z)
plug_mold = [13.5, 7.8];           // horizontal cable-plug niche (x, z)
spine_t   = 1.6;
board_z   = 11;
port_wall = 1.2;

/* [Battery] */
bat = [20.5, 30.5, 5.5];           // x, y, z: battery lies lengthwise (front-back), leads at the back end
stop_zmin = wall + 0.3 + bat[2] + 0.2;   // lowest z a board stopper may reach (battery top + 0.2): the TP4056 stopper sits over the battery

/* [Switch] */
// SS-12F15 metal slide switch (ears bent down): body 10.5 x 4.5 x 5.1, lever 3 x 3, 4 high, 3.2 travel
sw_body  = [12.1, 5.8];            // pocket (x, z): same as deck buddy (width 6 -> 5.8 so the locking lips work), was 11.8 x 5.2
lock_reach = 0.6;                  // locking lip reach into the pocket per side (deck buddy; gap 5.8 - 1.2 = 4.6, 0.2 overlap on the 5 mm switch)
lock_clear = 0.4;                  // lip underside sits this far behind the switch back
wall_long  = 0.8;                  // the 2 walls that carry the lips are thinner so they flex (the other 2 stay 1.2)
sw_depth = 5.0;                    // body depth (y)
sw_lever = [3, 3, 4];              // lever x, z, height
sw_travel= 3.2;
sw_slot  = [sw_lever[0] + sw_travel + 0.8, sw_lever[1] + 0.6];
sw_plate = 1.4;                    // wall the lever pokes through
sw_house_d = 6.5;                  // housing depth, switch seat -> rim (= deck buddy: 5.5 above the lid face + 1.0 sunk). Was 13 (a tube to the seam)
sw_z     = 61;                     // back of the head, on the flat vertical band

/* [Touch] */
touch_t   = 1.6;
touch_box = [17, 12.5];          // TTP223 15 x 11 + clearance
touch_y   = -5;                  // centre y of the touch pocket
// 2nd TTP223: slot under the head (jaw), elephant's right side, just behind the arm
touch2_p   = [-25, 2, 42.1];                 // pad centre on the outer skin
touch2_n   = [-0.78, 0.03, -0.62];           // outward skin normal there (from the ray scan)
touch2_box = [11.6, 15.6];                   // TTP223 11 x 15 + 0.3 per side (11 across the jaw, 15 front-back)
touch2_sag = 1.35;                           // jaw curves ~1.3 mm over the 15 mm length -> flat floor this much deeper

/* [Print supports: modelled, snap-off] */
modelled_supports = false;   // v3: OFF - supports come from Bambu Studio. true = built-in snap-off towers (see build/main_v3_with_modelled_supports.scad)
sup_gz   = 0.15;     // air gap under the part (~1 layer at 0.12, like a slicer support top gap) -> snaps off clean
sup_gxy  = 0.35;     // side gap
ear_zlow = 45.8;     // lowest point of the ears (measured)
trunk_zlow = 29.3;   // lowest point of the trunk curl

/* [Wings] */
wing_az  = -33;                // azimuth of wing normal (deg, 0 = +x)
wing_z   = 27;
pin_d    = 1.95;

/* [Feet] */
foot_x = 15.5;
foot_y = -18.5;

// ------------------------------------------------------------
// Derived
// ------------------------------------------------------------
oled_zc     = head_c.z + visor_dz;
win_zc      = oled_zc + oled_win_dz;
pcb_front_y = y_if + oled_glass_t;
pcb_back_y  = pcb_front_y + oled_pcb[2];
bay_in      = [oled_pcb[0] + 2*bay_clr, oled_pcb[1] + 2*bay_clr];

function body_r(z) = z < 0 ? 0 :
    let(a = z < body_zm ? body_alo : body_aup, t = (z - body_zm)/a)
    t >= 1 ? 0 : body_R * sqrt(1 - t*t);
body_top   = body_zm + body_aup;
body_sy_in = (body_R*body_sy - wall) / (body_R - wall);
function body_in_y(x, z) = let(ri = body_r(z) - wall) body_cy + body_sy_in * sqrt(max(0, ri*ri - x*x));

// spine is shifted so the TP4056 USB-C (the ONLY exposed port) is centred on the back
// FLAT STACK between two side walls (all slide in from the back opening):
//   battery on the floor -> TP4056 flat (USB-C horizontal, out through the lid) -> ESP32 flat (USB-C faces the opening)
stack_w   = bat[0];                                   // inner width between the side walls (20.5)
stack_top = 23.5;                                     // side wall height
tp_z0     = wall + 0.3 + bat[2] + 3.0;                // TP4056 pcb bottom
port_z    = tp_z0 + tp_pcb[2] + usb_h/2;              // USB-C centre height
tp_usb_x  = 0;
tp_y0     = split_y - tp_stop_depth;                  // TP4056 front end = front stop face (same depth as the ESP32 stopper)
tp_y1     = tp_y0 + tp_pcb[0];                        // TP4056 back end (USB-C): sticks past the body opening into the lid
esp_z0    = tp_z0 + tp_pcb[2] + usb_h + 1.6;          // ESP32 pcb bottom
y_esp     = board_y1;                                 // ESP32 back end (USB-C) flush with the body opening
esp_y0    = y_esp - esp_pcb[0];                       // ...front end = front stop face
// lid USB-C tunnel: receptacle face ~0.6 behind the board end, plug overmold niche from port_y_mold outward
usb_face_y  = tp_y1 + 0.6;
port_y_mold = usb_face_y + 5.6;                       // USB-C plug metal is ~6.5 long -> plug seats fully
port_y0     = port_y_mold - port_wall;                // guide plate with the USB hole
port_tube_zb= port_z - (plug_mold[1] + 2*1.2 + 1)/2;  // underside of the tunnel tube
bat_y0    = body_cy - bat[1]/2;                                 // battery front end
bat_y1    = body_cy + bat[1]/2;                                 // battery back end
y_sw      = head_c.y + head_ry - wall - 0.8;   // switch body face; FINAL housing: niche 1.6 deep, 4 mm lever sticks out 1.0, plate 1.4 (was -0.2: niche 1.0, lever out 1.6)

// --- analytic head surface (hull of 4 lobes == caps + straight band) ---
function hz_n(z, off = 0) = let(rel = z - head_c.z)
    rel > head_top[0] ? (rel - head_top[0]) / (head_top[1] - off) :
    rel < head_bot[0] ? (head_bot[0] - rel) / (head_bot[1] - off) : 0;
function hx_n(x, off = 0) = max(0, abs(x) - head_sx) / (head_rx - off);
function head_y(x, z) = head_c.y - head_ry * sqrt(max(0, 1 - pow(hx_n(x), 2) - pow(hz_n(z), 2)));
function head_n(x, z) = let(y = head_y(x, z),
    gx = (abs(x) > head_sx ? (abs(x) - head_sx)/pow(head_rx, 2) : 0) * (x < 0 ? -1 : 1),
    rel = z - head_c.z,
    gz = rel > head_top[0] ? (rel - head_top[0])/pow(head_top[1], 2) :
         rel < head_bot[0] ? (rel - head_bot[0])/pow(head_bot[1], 2) : 0,
    gy = (y - head_c.y)/pow(head_ry, 2), g = [gx, gy, gz]) g / norm(g);

sw_y0 = y_sw - sw_house_d;                    // rim of the switch housing (y)
echo(str("esp_y=[", esp_y0, ",", y_esp, "] tp_y=[", tp_y0, ",", tp_y1, "] bat_y=[", bat_y0, ",", bat_y1, "] port_y0=", port_y0, " tube_zb=", port_tube_zb," y_sw=", y_sw, " oled_zc=", oled_zc));

// ------------------------------------------------------------
// Helpers
// ------------------------------------------------------------
module ell(c, r) translate(c) scale(r) sphere(1);
module extrude_y(y0, h) translate([0, y0 + h, 0]) rotate([90, 0, 0]) linear_extrude(h) children();
module rrect(size, r) offset(r = r) square([size[0] - 2*r, size[1] - 2*r], center = true);
module half_y(lo, hi) translate([-200, lo, -200]) cube([400, hi - lo, 400]);
function v_norm(v) = v / norm(v);
function cross3(a, b) = [a[1]*b[2]-a[2]*b[1], a[2]*b[0]-a[0]*b[2], a[0]*b[1]-a[1]*b[0]];

// Catmull-Rom sampling of a 2D control polyline
function cr(p0, p1, p2, p3, t) = 0.5 * (2*p1 + (p2 - p0)*t + (2*p0 - 5*p1 + 4*p2 - p3)*t*t + (3*p1 - p0 - 3*p2 + p3)*t*t*t);
function cr_path(P, k = 10) = let(n = len(P))
    concat([for (i = [0:n-2], s = [0:k-1])
        cr(P[max(i-1, 0)], P[i], P[i+1], P[min(i+2, n-1)], s/k)], [P[n-1]]);

// ------------------------------------------------------------
// Outer / inner solids
// ------------------------------------------------------------
module head_hull(off = 0) hull() for (sx = [-1, 1]) {
    ell([sx*head_sx, head_c.y, head_c.z + head_top[0]], [head_rx - off, head_ry - off, head_top[1] - off]);
    ell([sx*head_sx, head_c.y, head_c.z + head_bot[0]], [head_rx - off, head_ry - off, head_bot[1] - off]);
}
module head_outer() head_hull(0);
// inside of the head gets a 45 deg peaked roof -> prints upright with no internal supports
roof_z = head_c.z + head_top[0] + head_top[1] - wall + 2;
module roof45() extrude_y(-100, 200) polygon([[-200, -300], [200, -300], [200, roof_z - 200], [0, roof_z], [-200, roof_z - 200]]);
module head_inner() intersection() { head_hull(wall); half_y(y_if, 200); roof45(); }

module body_profile2d() {
    N = 120;
    pts = concat([for (i = [0:N]) let(z = body_top*i/N) [body_r(z), z]],
                 [for (i = [N:-1:0]) let(z = body_top*i/N) [-body_r(z), z]]);
    offset(r = body_fil) offset(delta = -body_fil) polygon(pts);
}
module body_rev(d, sy) translate([0, body_cy, 0]) scale([1, sy, 1])
    rotate_extrude($fn = $fn) intersection() {
        offset(delta = d) body_profile2d();
        translate([0, -50]) square([100, 200]);
    }
module body_outer(d = 0) intersection() { body_rev(d, body_sy); translate([-200, -200, 0]) cube(400); }
// body cavity capped by a 45 deg cone: the flat dome ceiling around the neck (inside) sagged when printed upright
neck_cone_z = 51.5;   // 45 deg cone becomes the ceiling from the neck opening (r~10, room for wires) out to r~23
module body_inner() intersection() {
    body_rev(-wall, body_sy_in);
    translate([0, body_cy, 0]) scale([1, body_sy_in, 1]) cylinder(h = neck_cone_z, r1 = neck_cone_z, r2 = 0, $fn = 96);
}

// soft collar that blends the head underside into the body (no sharp crease)
// chin blend: hull of a body slice and the head slice where the head underside reaches 45 deg
chin_z_body = 36.5;                                         // where the blend meets the body
chin_z_head = head_c.z + head_bot[0] - head_bot[1] * sin(atan(head_bot[1] / head_ry)) - 0.2;  // 45 deg point (front/back curve is flattest)
module zslab(z, h = 0.01) translate([-200, -200, z]) cube([400, 400, h]);
module chin_blend() hull() {
    intersection() { body_outer(); zslab(chin_z_body); }
    intersection() { head_outer(); zslab(chin_z_head); }
}
module outer_main() union() { head_outer(); body_outer(); chin_blend(); }
module cavity()     union() { head_inner(); body_inner(); }

module outline2d() projection(cut = true) translate([0, 0, split_y]) rotate([-90, 0, 0]) outer_main();
module cavity2d()  projection(cut = true) translate([0, 0, split_y + 0.5]) rotate([-90, 0, 0]) cavity();

// ------------------------------------------------------------
// Face details
// ------------------------------------------------------------
// hood edge with widow's peak (x, z relative to head centre), left half
hood_half = [[-25.14, -17.5], [-27.31, -10.5], [-27.82, -1.75], [-25.97, 8.2], [-22.62, 13.8], [-18.01, 16.42], [-12.15, 16.16], [-5.86, 14.41], [0.0, 12.58]];
hood_ctrl = concat(hood_half, [for (i = [len(hood_half)-2:-1:0]) [-hood_half[i][0], hood_half[i][1]]]);

module hood_rim() {
    P  = cr_path(hood_ctrl, 14);
    N  = len(P); M = 24;
    fc = [0, -4];                                   // face centre (2D) to orient normals
    rings = [for (i = [0:N-1]) let(
        p  = P[i],
        tq = v_norm(P[min(i+1, N-1)] - P[max(i-1, 0)]),
        n2 = let(c = [tq[1], -tq[0]]) ((c * (p - fc)) < 0 ? -c : c),
        x  = p[0] + n2[0]*0.3, z = p[1] + n2[1]*0.3 + head_c.z,
        S  = [x, head_y(x, z), z],
        U  = head_n(x, z),
        T3 = v_norm([tq[0], 0, tq[1]]),
        V  = v_norm(cross3(T3, U)),
        zr = p[1],                                        // height on the face (rel. head centre)
        sink = 0.9 + 0.6 * min(1, max(0, (zr - 6) / 6)),   // flatter along the forehead (prints upright, no support)
        C  = S - U*sink,
        rr = rim_r * max(0.25, min(1, i / (0.10*N), (N - 1 - i) / (0.10*N))))
        [for (j = [0:M-1]) let(f = 360*j/M) C + rr*(cos(f)*U + sin(f)*V)]];
    pts = concat([for (r = rings) each r],
                 [(rings[0][0] + rings[0][M/2])/2, (rings[N-1][0] + rings[N-1][M/2])/2]);
    c0 = N*M; c1 = N*M + 1;
    faces = concat(
        [for (i = [0:N-2], j = [0:M-1]) [i*M + j, i*M + (j+1)%M, (i+1)*M + (j+1)%M, (i+1)*M + j]],
        [for (j = [0:M-1]) [c0, (j+1)%M, j]],
        [for (j = [0:M-1]) [c1, (N-1)*M + j, (N-1)*M + (j+1)%M]]);
    polyhedron(points = pts, faces = faces, convexity = 6);
}

module visor2d(grow = 0) translate([0, head_c.z + visor_dz]) offset(delta = grow) rrect(2*visor_half, visor_rad);

module face_cuts() {
    // visor: constant-depth recess following the face curvature + 0.6 bevel
    intersection() {
        extrude_y(-80, 80) visor2d();
        difference() { head_hull(-1); head_hull(visor_rec); }
    }
    intersection() {
        extrude_y(-80, 80) visor2d(0.7);
        difference() { head_hull(-1); head_hull(0.4); }
    }
    intersection() {
        extrude_y(-80, 80) visor2d(0.35);
        difference() { head_hull(-1); head_hull(0.8); }
    }
    funnel();
}
// funnel from the visor floor to the OLED window.
// v1 used one hull whose ceiling started 3 mm in FRONT of the face -> only 36 deg and a feather-thin
// top edge that printed ragged (Nov 14 print). Now: the top edge is a flat 1 mm deep bridge (prints clean),
// then the ceiling follows the face and climbs at >=45 deg, so nothing behind it hangs.
fun_st = 0.3;          // 0.3 mm steps < one line width -> prints as a smooth slope
fun_n  = 34;
fun_ov = 0.05;         // overlap of neighbouring funnel shells (kills the speckled holes / spikes from coincident faces)
fun_bridge = 1.0;      // first 1 mm behind the visor floor stays flat -> the top edge prints as a clean 1 mm bridge
fun_g  = 0;            // v9: FLAT top (same as the flat bottom ledge). Was 1 = a 45 deg climb built from stacked steps (ridged look). 0 = one flat ceiling at the visor top edge
fun_cap = win_zc + (23 + 2*bay_clr)/2 - (head_c.z + visor_dz + visor_half[1] - 1.6);   // = glass pocket half-height (same numbers as glass_in, which is defined further down)   // ... but only up to the TOP OF THE OLED GLASS (3.45 mm), then it stays flat.
// v8 fix: the old ceiling shot up 12 mm per 1 mm, which opened the whole forehead above the window and showed the bare PCB strip
// (glass top z 77.1 ... pcb top z 81.75) from outside. Now the solid forehead sits right above the glass, so no board is visible.
function fun_rise(i) = min(fun_cap, max(0, fun_g * (i*fun_st - fun_bridge)));
module opening2d(rise) hull() { visor2d(-1.6); translate([0, rise]) visor2d(-1.6); }
module funnel() intersection() {
    hull() {                                                                         // sides + bottom taper only
        extrude_y(fun_y0 - 3, 3) opening2d(30);
        extrude_y(y_if - 0.01, 0.01) translate([0, win_zc]) rrect(oled_win, 1.5);
        extrude_y(y_if - 0.01, 0.01) translate([-oled_win[0]/2 + 1.5, win_zc]) square([oled_win[0] - 3, 40]);
    }
    union() for (i = [0:fun_n - 1]) intersection() {                                 // 45 deg top, face-following
        difference() { head_hull(i == 0 ? -1 : visor_rec + i*fun_st); head_hull(visor_rec + (i + 1)*fun_st + (i == fun_n - 1 ? 0 : fun_ov)); }   // shells overlap by fun_ov: no coincident faces between steps
        extrude_y(-80, 80) opening2d(fun_rise(i));
    }
    union() { head_hull(wall); zbox(-100, fun_ztop_front + 0.01); }                  // forehead keeps its full wall
    half_y(-200, y_if + 0.01);
}
fun_y0         = head_c.y - head_ry + visor_rec;                       // visor floor at the face centre
fun_ztop_front = head_c.z + visor_dz + visor_half[1] - 1.6;             // top edge of the opening
fun_ztop_back  = fun_ztop_front + fun_cap;                              // capped at the glass top
echo(str("funnel ceiling: z ", fun_ztop_front, " at y ", fun_y0, " -> capped z ", fun_ztop_back, " (glass top) before y ", y_if));

// curled tuft: tall lobe + curl to the right
module tuft() {
    zt = head_c.z + head_top[0] + head_top[1];   // head top
    ty = -3;
    sy = 0.8;
    translate([0, ty, zt]) scale([0.82, 0.82*sy, 0.82]) translate([0, -ty, -zt]) {
        translate([-1.8, ty, zt + 2.0]) rotate([0, 18, 0]) scale([7.2, 7.0, 10.0]) sphere(1);
        curl = [[[3.5, zt + 3.0], 6.0], [[8.6, zt + 4.6], 5.2], [[12.8, zt + 4.4], 4.4], [[15.2, zt + 3.2], 3.4]];
        for (i = [0:len(curl)-2]) hull() {
            translate([curl[i][0][0],   ty, curl[i][0][1]])   sphere(r = curl[i][1]);
            translate([curl[i+1][0][0], ty, curl[i+1][0][1]]) sphere(r = curl[i+1][1]);
        }
    }
}

// blush cheeks: soft raised ovals under the visor corners (paint pink)
module cheeks() for (sx = [-1, 1]) let(x = sx * 17.5, z = oled_zc - 14.2, n = head_n(x, z))
    translate([x, head_y(x, z), z] - n * 0.5) rotate([0, 0, sx * -8]) scale([5.2, 1.15, 3.2]) sphere(r = 1, $fn = 64);
// ================= ELEPHANT FEATURES (from the approved look) =================
// EAR: big puffy leaf/D, thick soft rim, recessed inner area (paint pink)
module ear2d() offset(r = 3) offset(r = -3) hull() {
    translate([13, 8])   rotate(-15) scale([14, 18.5]) circle(r = 1, $fn = 160);   // round dome top
    translate([15, -12]) rotate(25)  scale([9, 8])     circle(r = 1, $fn = 128);   // lower lobe
    translate([1, 0])    scale([3.5, 11]) circle(r = 1, $fn = 96);                 // root behind the head
}
ear_rr = 3.8;                                      // half thickness = rim roundness
module ear_body()  minkowski() { linear_extrude(0.01) offset(delta = -ear_rr) ear2d(); sphere(r = ear_rr, $fn = 40); }
module ear_inner() translate([0, 0, ear_rr - 1.5 + 2.6]) minkowski() { linear_extrude(3) offset(delta = -8) ear2d(); sphere(r = 2.6, $fn = 32); }
ear_pos = [27, -3, 66];   ear_turn = 20;           // root on the head side; angled back (stays in front of the lid seam)
module ear(sx) translate([sx * ear_pos[0], ear_pos[1], ear_pos[2]]) rotate([0, 0, sx * ear_turn]) mirror([sx < 0 ? 1 : 0, 0, 0])
    rotate([90, 0, 0]) difference() { ear_body(); ear_inner(); }

// TRUNK: short and thick from under the visor, curls right, tip rests on the chest (prints upright)
trunk_pts = [[0, -26.5, 50.5, 6.2], [0, -29, 45, 5.7], [0.5, -28.5, 39.5, 5.2], [2.5, -26.5, 35, 4.6],
             [5.5, -23, 33.5, 4.2], [7.5, -21, 35.5, 3.8], [8, -20, 38.5, 3.3]];
module trunk() {
    n = len(trunk_pts);
    P = concat([for (i = [0:n-2], k = [0:2]) trunk_pts[i] + (trunk_pts[i+1] - trunk_pts[i]) * k/3], [trunk_pts[n-1]]);
    for (i = [0:len(P)-2]) hull() {
        translate([P[i][0], P[i][1], P[i][2]])       sphere(r = P[i][3]   * (i % 2 == 1 ? 0.975 : 1), $fn = 64);
        translate([P[i+1][0], P[i+1][1], P[i+1][2]]) sphere(r = P[i+1][3] * ((i+1) % 2 == 1 ? 0.975 : 1), $fn = 64);
    }
}

// ARM: big round oval hugging the belly, resting on the foot
module arm(sx) translate([sx * 24.5, -9, 27]) rotate([0, sx * 14, 0]) rotate([-12, 0, 0]) scale([8.6, 9, 11.8]) sphere(1);

// FOOT: round sole facing forward, big pad + 3 toe beans (paint pink)
module ele_foot(sx) {
    x = sx * 18.5;
    intersection() {
        union() {
            hull() { ell([x, -10, 11], [10.8, 9, 11]); ell([x, -21.5, 11], [10.8, 2.6, 10.8]); }
            ell([x, -23.6, 8.6], [5.4, 1.2, 4.4]);
            for (t = [-1, 0, 1]) ell([x + t*4.8, -23.2, 16.2 - abs(t)*1.5], [2.0, 1.2, 2.0]);
        }
        translate([-200, -200, 0]) cube(400);
    }
}

// tiny round tail at the back bottom
module tail() hull() {
    ell([0, body_cy + body_sy*body_R - 4, 5.8], [6.0, 3.4, 3.2]);
    ell([0, body_cy + body_sy*body_R + 2.6, 3.4], [2.3, 1.7, 1.7]);
}

module belly_zone(rx, rz) extrude_y(-60, 55) translate([0, 28]) scale([rx, rz]) circle(r = 1);
module belly() intersection() {
    union() {
        intersection() { body_outer(0.35); belly_zone(24.9, 20.9); }
        intersection() { body_outer(0.7);  belly_zone(24, 20); }
    }
    half_y(-200, split_y - 6);
    translate([-200, -200, 1.0]) cube(400);
}
// little heart on the belly (paint pink/red)
heart_z = 30;
module heart2d(w = 9) scale(w / 4.4) union() {
    translate([-1.02, 0.45]) circle(r = 1.16, $fn = 48);
    translate([ 1.02, 0.45]) circle(r = 1.16, $fn = 48);
    polygon([[-2.12, 0.2], [2.12, 0.2], [0, -2.25]]);
}
module heart() intersection() {
    body_outer(1.7);
    extrude_y(-60, 55) translate([0, heart_z]) offset(r = 0.4) offset(delta = -0.4) heart2d();
    half_y(-200, split_y - 6);
}

module foot(sx) {
    x = sx * foot_x;
    intersection() {
        union() {
            hull() {
                ell([x, foot_y, 7.0],  [9.6, 7.2, 7.4]);
                ell([x, foot_y + 2, 1.3], [8.4, 7.6, 1.7]);
            }
            for (t = [-1, 0, 1]) hull() {          // toes blend smoothly into the paw
                ell([x + t*5.0, foot_y - 0.9, 12.2 - abs(t)*1.1], [3.9, 5.2, 3.6]);
                ell([x + t*3.6, foot_y + 0.4, 8.6], [3.4, 5.4, 3.2]);
            }
            // toe beans (paint pink): big pad + 3 little beans on the front of the paw
            ell([x, foot_y - 6.7, 5.6], [3.9, 1.6, 2.9]);
            for (t = [-1, 0, 1])
                ell([x + t*3.9, foot_y - 6.0, 10.2 - abs(t)*1.0], [1.75, 1.3, 1.7]);
        }
        translate([-200, -200, 0]) cube(400);
    }
}

// ------------------------------------------------------------
// FRONT SHELL internals
// ------------------------------------------------------------
// short OLED holder: 4 walls just deep enough for glass + pcb + snap bumps.
// corners are slit so the side walls flex when the pcb clicks in.
bay_end = pcb_back_y + bay_depth;
module oled_bay_walls() {
    intersection() {
        extrude_y(y_if - eps, bay_end - y_if)                // walls start at the face block (solidly joined)
            translate([0, oled_zc]) difference() {
                square([bay_in[0] + 2*bay_wall, bay_in[1] + 2*bay_wall], center = true);
                square([bay_in[0], bay_in[1]], center = true);
                // NO top wall: it was a 30 mm bridge (failed upright). The glass pocket holds the screen up/down.
                translate([-(bay_in[0]/2 + bay_wall + 1), bay_in[1]/2 - 0.01]) square([bay_in[0] + 2*bay_wall + 2, bay_wall + 2]);
            }
        outer_main();
    }
    // 45 deg wedge under the holder floor: it grows up from the chin instead of bridging in mid-air
    intersection() {
        hull() {
            translate([-(bay_in[0]/2 + bay_wall), y_if, oled_zc - bay_in[1]/2 - bay_wall]) cube([bay_in[0] + 2*bay_wall, bay_end - y_if, bay_wall]);
            translate([-(bay_in[0]/2 + bay_wall), y_if, oled_zc - bay_in[1]/2 - bay_wall - (bay_end - y_if)]) cube([bay_in[0] + 2*bay_wall, 0.01, 0.01]);
        }
        head_hull(0.6);
    }
    // snap bumps on the side walls (catch face holds the pcb back, ramp faces the opening)
    for (sx = [-1, 1])
        translate([sx * bay_in[0]/2, 0, oled_zc])
            hull() {
                translate([-sx*0.6 - 0.01, pcb_back_y + 0.1, -4]) cube([0.02, 0.01, 8]);
                translate([0, pcb_back_y + 0.1, -4]) cube([0.02, bay_end - pcb_back_y - 0.1, 8]);
            }
}
glass_in = [34.5 + 2*bay_clr, 23 + 2*bay_clr];      // OLED glass panel + clearance
module oled_bay_cuts() {
    extrude_y(y_if, oled_glass_t + 0.01) translate([0, win_zc]) square(glass_in, center = true);          // glass pocket
    // OLED slide-in channel (from the back opening to the holder)
    extrude_y(pcb_front_y, split_y + lip_h + 1 - pcb_front_y) translate([0, oled_zc]) square(bay_in, center = true);
    // ...with a 45 deg peaked top inside the head, so nothing above it is a flat ceiling in mid-air
    // (the flat top of this channel left a 10 x 31 mm unsupported slab -> the spaghetti failure)
    intersection() {
        extrude_y(pcb_front_y, split_y + lip_h + 1 - pcb_front_y) translate([0, oled_zc])
            polygon([[-bay_in[0]/2, bay_in[1]/2 - 0.01], [bay_in[0]/2, bay_in[1]/2 - 0.01], [0, bay_in[1]/2 + bay_in[0]/2]]);
        head_hull(wall);                                   // never cut into the outer skin
    }
    // corner slits -> flexible side walls
    intersection() {                                   // never cut the outer skin
        for (sx = [-1, 1], sz = [-1, 1])
            translate([sx * (bay_in[0]/2 + bay_wall/2) - 0.3, pcb_front_y + 0.2, oled_zc + sz * (bay_in[1]/2 + 0.3) - 0.3])
                cube([0.6, 30, 0.6 + bay_wall]);
        head_hull(1.0);
        roof45();                                      // no slits inside the solid roof (no loose slivers)
    }
}

// TTP223 pocket under the head top: follows the dome, leaves touch_t of plastic
// v9: the roof is curved (it falls ~2 mm toward the front over the 12.5 mm pocket), so the sensor now sits on a FLAT seat plane
// tilted to the roof (tp_slope, measured: skin 1.6 at the front corners, ~2.4 mm at the middle) and is held by two flexing
// side arms with 45 deg lead-in lips (same idea as the SPDT housing). The board is pushed UP from inside the head.
tp_slope  = 0.136;       // seat plane rises 0.136 mm per mm toward the back (7.7 deg)
tch_z0    = 88.4;        // seat plane z at the FRONT edge of the pocket
tp_board  = [15, 11, 1.6];
tp_side   = 0.2;         // clearance per side between board and arm
tp_arm_t  = 1.2;         // arm thickness (v10: was 0.65, the thin arms broke off with the tree supports). Flexes in the print-layer plane, never across the layers
tp_arm_h  = 2.2;         // arm height
tp_reach  = 0.7;         // lip reach over the board edge (hold = reach - 0.2 clearance... board edge overlap 0.5)
tp_gap_up = 0.3;         // free slit between arm top and the roof so the arm can flex
tp_root   = 0.6;         // half length of the root block at the middle
tp_arm_L  = 6.0;         // arm reaches this far each way from the middle
tp_lip_L  = 2.6;         // length of the lip at the free end
module at_tb() translate([0, touch_y, tch_z0 + touch_box[1]/2 * tp_slope]) rotate([atan(tp_slope), 0, 0]) children();
module touch_pocket() at_tb() translate([-touch_box[0]/2, -touch_box[1]/2, -14]) cube([touch_box[0], touch_box[1], 14]);   // flat seat, board top = z 0
module touch_fill() intersection() {        // roof material between the seat plane and the skin (never closer than touch_t to the outside)
    head_hull(touch_t);
    at_tb() translate([-touch_box[0]/2, -touch_box[1]/2, 0]) cube([touch_box[0], touch_box[1], 4]);
}
module touch_cradle() intersection() {
    head_hull(touch_t + 0.1);
    at_tb() for (sx = [-1, 1]) scale([sx, 1, 1]) {
        xi = tp_board[0]/2 + tp_side;  xo = xi + tp_arm_t;  zt = -tp_gap_up;  zb = zt - tp_arm_h;
        lz = -(tp_board[2] + 0.15);                       // holding face 0.15 under the board
        // root block (fused up into the roof fill)
        translate([xi, -tp_root, zb]) cube([tp_arm_t, 2*tp_root, 0.9 - zb]);
        // two arms, front and back, thin plates with a free slit above them
        for (sy = [-1, 1]) {
            translate([xi, sy > 0 ? tp_root - 0.01 : -tp_arm_L, zb]) cube([tp_arm_t, tp_arm_L - tp_root + 0.01, tp_arm_h]);
            // lip at the free end: flat holding face on top, 45 deg lead-in underneath
            y0 = sy > 0 ? tp_arm_L - tp_lip_L : -tp_arm_L;
            translate([0, y0, 0]) rotate([90, 0, 0]) mirror([0, 0, 1]) linear_extrude(tp_lip_L)
                polygon([[xi + 0.01, lz], [xi - tp_reach, lz], [xi + 0.01, lz - tp_reach]]);
        }
    }
}

// 2nd TTP223 slot under the head: the sensor drops in from inside the head (through the back opening),
// pad side down, and senses through touch_t of plastic. A frame on the head floor holds its edges.
touch2_nn = v_norm(touch2_n);
touch2_t2 = v_norm([0, 1, 0] - touch2_nn[1] * touch2_nn);
touch2_t1 = cross3(touch2_t2, touch2_nn);
module at_touch2() multmatrix([[touch2_t1[0], touch2_t2[0], touch2_nn[0], touch2_p[0]],
                               [touch2_t1[1], touch2_t2[1], touch2_nn[1], touch2_p[1]],
                               [touch2_t1[2], touch2_t2[2], touch2_nn[2], touch2_p[2]], [0, 0, 0, 1]]) children();
module touch2_pocket() intersection() {
    at_touch2() translate([-touch2_box[0]/2, -touch2_box[1]/2, -10]) cube([touch2_box[0], touch2_box[1], 10 - touch_t - touch2_sag]);  // FLAT floor
    translate(-touch_t * touch2_nn) outer_main();          // and never less than touch_t of skin
}
module touch2_frame() intersection() {
    at_touch2() translate([-touch2_box[0]/2 - 1.2, -touch2_box[1]/2 - 1.2, -7.5]) cube([touch2_box[0] + 2.4, touch2_box[1] + 2.4, 7.5]);
    translate(-0.8 * touch2_nn) outer_main();
}

// ---- modelled snap-off print supports (stand on the plate, 0.22 mm air gap under the part) ----
module model_outer() union() { outer_main(); trunk(); for (sx = [-1, 1]) { ele_foot(sx); ear(sx); arm(sx); } }
module sup_keepout() union() {
    translate([0, 0, -sup_gz]) model_outer();
    for (a = [0:45:315]) translate([sup_gxy*cos(a), sup_gxy*sin(a), -sup_gz/2]) model_outer();
}
module shadow() hull() { children(); linear_extrude(0.01) projection() children(); }   // everything under it, down to the plate
module zbox(z0, z1, ymax = 200) translate([-200, -200, z0]) cube([400, 200 + ymax, z1 - z0]);
module ear_support(sx) {
    module slab() intersection() { ear(sx); zbox(0, ear_zlow + 3); }
    shadow() slab();                                                           // cradle that follows the ear's bottom curve
    linear_extrude(ear_zlow - 2) offset(r = 2.5) projection() slab();         // thicker shaft (bed moves in y)
    hull() { linear_extrude(0.6) offset(r = 6) projection() slab();           // flared foot so the tall tower can't wobble
             translate([0, 0, 6]) linear_extrude(0.01) offset(r = 2.5) projection() slab(); }
}
module trunk_support() difference() {
    union() {
        shadow() intersection() { trunk(); zbox(0, trunk_zlow + 3.5, -21.5); }
        hull() { linear_extrude(0.6) offset(r = 4) projection() intersection() { trunk(); zbox(0, trunk_zlow + 3.5, -21.5); }
                 translate([0, 0, 4]) linear_extrude(0.01) projection() intersection() { trunk(); zbox(0, trunk_zlow + 3.5, -21.5); } }
    }
    for (sx = [-1, 1]) translate([0, 0, -1]) linear_extrude(80) offset(r = 0.6) projection() ele_foot(sx);   // never stand on a foot
}
module foot_support(sx) shadow() union() {               // front lower half of the sole + big pad, and the lowest 5 mm all round
    intersection() { ele_foot(sx); zbox(0, 11, -13); }
    intersection() { ele_foot(sx); zbox(0, 5); }
}
// the snap lip's bottom run hangs 1 mm above the plate behind the seam -> thin plate under it
module lip_support() difference() {
    linear_extrude(lip_keep + lip_clr - sup_gz) projection() intersection() { lip(); zbox(0, 2.5); half_y(split_y + sup_gxy, 200); }
    translate([-5 - sup_gxy, split_y - 2, -1]) cube([10 + 2*sup_gxy, 10, 5]);   // pry notch area stays clear
}
module print_supports() difference() {
    union() { for (sx = [-1, 1]) { ear_support(sx); foot_support(sx); } trunk_support(); }
    sup_keepout();
}
// inside the head, above the display: the ceiling is nearly flat (it can't be a 45 deg roof, the OLED
// slides in from the back under it). Thin walls stand on the head's inner floor behind the display and stop
// sup_gz under the ceiling. 3 loose pieces (left comb, centre wall, right comb) -> pull out through the
// back opening with long-nose pliers BEFORE fitting the display.
dsup_t  = 1.0;                 // wall thickness
dsup_y  = [-16.2, 11.0];       // behind the OLED pcb (back face at pcb_back_y) ... up to the lid seam
module display_support_raw() {
    for (x = [-12, -6, 0, 6, 12]) translate([x - dsup_t/2, dsup_y[0], 38]) cube([dsup_t, dsup_y[1] - dsup_y[0], 60]);
    for (y = [-14, -6, 2, 10], s = [-1, 1])                    // cross ties inside each side comb (stiff on the moving bed)
        translate([s > 0 ? 6 : -12, y - 0.4, 38]) cube([6, 0.8, 32]);
}
module display_support() difference() {
    intersection() { display_support_raw(); head_hull(wall); half_y(pcb_back_y + 0.4, split_y - 1.5); }
    translate([0, body_cy, 0]) scale([1, body_sy_in, 1]) cylinder(r = 11.5, h = 200);   // neck opening: no floor to stand on
    translate([0, 0, -sup_gz]) front_shell();
    for (a = [0:45:315]) translate([sup_gxy*cos(a), sup_gxy*sin(a), -sup_gz/2]) front_shell();
}
module all_supports() { print_supports(); lip_support(); display_support(); }
// lid: the little tail hangs 2-6 mm above the plate
module lid_supports() difference() {
    shadow() intersection() { tail(); zbox(0, 5.8); }
    translate([0, 0, -sup_gz]) union() { outer_main(); tail(); }
    for (a = [0:45:315]) translate([sup_gxy*cos(a), sup_gxy*sin(a), -sup_gz/2]) union() { outer_main(); tail(); }
}

module snap_windows2d() {
    for (sx = [-1, 1]) {
        translate([sx * 30, head_c.z]) square([14, 16], center = true);     // v8: bigger catch areas (was 12 x 10)
        translate([sx * 24.5, 14]) square([14, 10],  center = true);        // (was 12 x 8)
    }
    translate([0, head_c.z + 24]) square([14, 12], center = true);          // (was 12 x 10)
}

// ---- snap joint that FOLLOWS the curved skin (constant thickness, never pokes out) ----
module inner_solid(off) union() { head_hull(off); body_outer(-off); }
module shell_band(o1, o2) difference() { inner_solid(o1); inner_solid(o2); }   // layer between skin-offsets o1 < o2
lip_t = 1.0;
// lip with a stepped 45 deg underside (thick at the root, 1 mm at the tip) -> prints upright with no support
lip_thick_z = head_c.z;         // above this the lip root is thickened (that arc hangs in the air when printed upright)
module lip() union() {
    intersection() {
        half_y(split_y - eps, split_y + lip_h);
        shell_band(lip_keep + lip_clr, lip_keep + lip_clr + lip_t);
    }
    intersection() {
        translate([-200, -200, lip_thick_z]) cube(400);
        union() for (k = [0:2]) intersection() {
            half_y(split_y - eps + k * lip_h/3, split_y + (k + 1) * lip_h/3);
            shell_band(lip_keep + lip_clr, lip_keep + lip_clr + lip_t + (2 - k) * lip_h/3);
        }
    }
}
// asymmetric catch: STEEP (90 deg) face on the seam side = holds the lid, long gentle ramp on the far side = easy to push on.
// (v7 had a symmetric bump: it released as easily as it clicked in.)
module lip_bumps() intersection() {
    extrude_y(-100, 200) snap_windows2d();
    union() for (k = [0:snap_n-1]) let(f = (k + 1)/snap_n)
        intersection() {
            half_y(split_y + snap_y0, split_y + snap_y0 + snap_top + snap_ramp*(1 - f));
            shell_band(lip_keep + lip_clr - snap_h*f, lip_keep + lip_clr + 0.2);
        }
}

// ------------------------------------------------------------
// WINGS (mitten), attached to the front shell with 1.75 mm filament pins
// local frame: a = tangent (horizontal), b = up, c = outward normal
// ------------------------------------------------------------
wn  = [cos(wing_az), sin(wing_az), 0];
wt  = [-sin(wing_az), cos(wing_az), 0];
function body_surf_along(az, z) =   // point on body surface along direction az from axis
    let(r = body_r(z), c = cos(az), s = sin(az), k = 1 / sqrt(pow(c, 2) + pow(s/body_sy, 2)))
    [r*k*c, body_cy + r*k*s, z];
wP  = body_surf_along(wing_az, wing_z) + wn * 1.2;
wing_M = [[wt[0], 0, wn[0], wP[0]], [wt[1], 0, wn[1], wP[1]], [0, 1, 0, wP[2]], [0, 0, 0, 1]];
wing_M_inv = [[wt[0], wt[1], 0, -(wt*wP)], [0, 0, 1, -wP[2]], [wn[0], wn[1], 0, -(wn*wP)], [0, 0, 0, 1]];
wing_pins_local = [[0, 4.2], [0.4, -4.2]];                    // (a, b)

module wing_T(sx)     mirror([sx < 0 ? 1 : 0, 0, 0]) multmatrix(wing_M) children();
module wing_T_inv(sx) multmatrix(wing_M_inv) mirror([sx < 0 ? 1 : 0, 0, 0]) children();

module wing_shape() rotate([0, 0, -15]) scale(0.84) hull() {
    ell([0, 4.5, 0],   [9.2, 8.2, 5.8]);
    ell([1.0, -6.5, 0.3], [6.4, 6.2, 4.4]);
}
module wing_pin_cyl() for (p = wing_pins_local)
    translate([p[0], p[1], 0]) cylinder(d = pin_d, h = 24, center = true, $fn = 16);
module wing_local(sx) difference() {
    wing_shape();
    wing_T_inv(sx) union() {                         // hug the body AND the raised belly panel
        body_outer(0.15);
        intersection() { body_outer(0.95); belly_zone(25.6, 21.6); }
    }
    intersection() { wing_pin_cyl(); translate([-50, -50, -50]) cube([100, 100, 50 + 3.5]); }
}
module wing(sx = 1) wing_T(sx) wing_local(sx);
module wing_print(sx = 1) wing_local(sx);                 // dome up; concave side on supports
module wing_holes() for (sx = [-1, 1]) wing_T(sx) wing_pin_cyl();

// ------------------------------------------------------------
// FRONT SHELL
// ------------------------------------------------------------
module front_shell() { union() { front_shell_core(); touch_cradle(); } }
module front_shell_core() {
    difference() {
        union() {
            intersection() {
                difference() {
                    union() { outer_main(); trunk(); for (sx = [-1, 1]) { ele_foot(sx); ear(sx); arm(sx); } }
                    cavity();
                }
                half_y(-200, split_y);
            }
            lip();
            if (snap_on) lip_bumps();
            screw_front();
            oled_bay_walls();
            battery_ribs_front();
            touch_fill();
        }
        face_cuts();
        oled_bay_cuts();
        screw_front_cuts();
        touch_pocket();
        // side touch pad (touch2) REMOVED: the TTP223 now lives only under the head top (touch_pocket)
        seam_chamfer_front();
        translate([-5, split_y - 1.5, -1]) cube([10, 5, 2.2]);   // pry notch
    }
}

// ------------------------------------------------------------
// BACK SHELL (same mechanics as pengu v2)
// ------------------------------------------------------------
module spine() intersection() {
    union() {
        // centre wall
        translate([spine_x - spine_t/2, split_y, board_z - 2]) cube([spine_t, 60, esp_pcb[1] + 4]);
        // ESP32 slot (left face): edge rails, board slides in USB-C first... facing the seam
        for (zz = [board_z - 1.4, board_z + esp_pcb[1] + 0.2])
            translate([esp_x1 - esp_pcb[2] - 1.0, split_y, zz]) cube([esp_pcb[2] + 1.0 + eps, 60, 1.2]);
        // retaining bumps at the seam end of the ESP32 slot
        for (zz = [board_z - 0.25, board_z + esp_pcb[1] - 0.05])
            translate([esp_x1 - esp_pcb[2] - 1.0, max(split_y, y_esp - esp_pcb[0] - 0.2 + 0.6), zz]) cube([0.8, 2.0, 0.3]);
        // TP4056 slot (right face): edge rails, USB-C end butts on the port plate
        for (zz = [tp_z0 - 1.4, tp_z0 + tp_pcb[1] + 0.2])
            translate([spine_x + spine_t/2 - eps, split_y, zz]) cube([tp_pcb[2] + 1.0, 60, 1.2]);
        for (zz = [tp_z0 - 0.25, tp_z0 + tp_pcb[1] - 0.05])
            translate([spine_x + spine_t/2 + tp_pcb[2] + 0.2, max(split_y, y_back - tp_pcb[0] + 0.6), zz]) cube([0.8, 2.0, 0.3]);
    }
    intersection() { outer_main(); half_y(split_y, 200); }
}

// USB-C tunnel in the lid: the TP4056 now ends flush with the body opening, so the cable plug
// reaches in through a guide plate (port_y0) + overmold niche (port_y_mold -> outside)
module port_block() intersection() {
    difference() {
        extrude_y(port_y0, 40) translate([tp_usb_x, port_z]) rrect([plug_mold[0] + 2*1.2 + 1, plug_mold[1] + 2*1.2 + 1], 3);
        extrude_y(port_y_mold, 41) translate([tp_usb_x, port_z]) rrect([plug_mold[0] + 1, plug_mold[1] + 1], 2.4);
    }
    outer_main();
}
module port_cuts() {
    extrude_y(port_y_mold, 60) translate([tp_usb_x, port_z]) rrect([plug_mold[0] + 1, plug_mold[1] + 1], 2.4);
    extrude_y(port_y0 - 1, 10) translate([tp_usb_x, port_z]) rrect(usb_hole, 1.2);      // TP4056 only
}
module switch_block() intersection() {
    union() {
        // tower: switch slides in from the open side, lever first, until the body hits the plate
        extrude_y(sw_y0, y_sw - sw_y0 + sw_plate) translate([0, sw_z]) difference() {
            square([sw_body[0] + 2.4, sw_body[1] + 2*wall_long], center = true);
            square(sw_body, center = true);
        }
        // 45 deg wedge under the tower: it used to hang ~13 mm in the air from the back wall (printed upright)
        let(w = sw_body[0] + 2.4, zb = sw_z - sw_body[1]/2 - wall_long, L = y_sw + sw_plate - sw_y0)
            hull() {
                translate([-w/2, sw_y0, zb]) cube([w, L, 0.2]);            // overlaps the tower floor -> fused
                translate([-w/2, y_sw + sw_plate, zb - L]) cube([w, 0.01, 0.01]);
            }
        switch_lips();
        // plate + sleeve out to the skin
        difference() {
            extrude_y(y_sw, 30) translate([0, sw_z]) rrect([sw_slot[0] + 6.4, sw_slot[1] + 5.4], 2.5);
            extrude_y(y_sw + sw_plate, 31) translate([0, sw_z]) rrect([sw_slot[0] + 4, sw_slot[1] + 3], 2);
        }
    }
    outer_main();
}
// locking lips (deck buddy): flat underside holds the switch, 45 deg ramp on top lets it slide in (fused 0.5 into the wall)
module switch_lips() for (sz = [-1, 1]) {
    h = sw_body[1]/2; R = lock_reach; d0 = sw_depth + lock_clear;
    pts = [[d0, h + 0.5], [d0, h - R], [sw_house_d - R, h - R], [sw_house_d, h], [sw_house_d, h + 0.5]];
    rotate([90, 0, 90]) linear_extrude(6, center = true)
        polygon([for (q = pts) [y_sw - q[0], sw_z + sz * q[1]]]);
}
// (old) small retaining bumps inside the tower (hold the switch body against the plate)
module switch_bumps() intersection() {
    for (sz = [-1, 1])
        translate([-3, y_sw - sw_depth - 1.6, sw_z + sz * (sw_body[1]/2) - (sz > 0 ? 0.4 : 0.5)])
            cube([6, 1.2, 0.9]);                 // 0.4 bump + 0.5 fused into the holder wall
    outer_main();
}
module switch_cuts() {
    // finger niche around the lever
    extrude_y(y_sw + sw_plate, 40) translate([0, sw_z]) rrect([sw_slot[0] + 4, sw_slot[1] + 3], 2);
    // lever slot
    extrude_y(y_sw - 1, 10) translate([0, sw_z]) rrect(sw_slot, 0.8);
}
module battery_ribs() intersection() {
    union() {
        for (sx = [-1, 1]) {
            translate([sx * (bat[0]/2 + 0.6) - 0.6, split_y + lip_h + 0.3, wall]) cube([1.2, 40, bat[2] + 0.3]);
            hull() {   // battery back stop, raised to carry the USB tunnel's underside (no floating ledge)
                translate([sx * bat[0]/2 - (sx > 0 ? 0.3 : 0), bat_y1, wall]) cube([0.3, 0.01, port_tube_zb - wall]);
                translate([sx > 0 ? bat[0]/2 - 4 : -bat[0]/2, bat_y1 + 4, wall]) cube([4, 0.01, port_tube_zb - wall]);
            }
        }
    }
    intersection() { outer_main(); half_y(split_y, 200); }
}
// battery pocket, front half: side ribs + 45 deg corner stops (printed from the seam plane)
// wedge shelf: flat top at z_top sticking out p from the wall, 45 deg underside back to the wall
module shelf(sx, board_w, ya, yb, z_top) {
    p  = stack_w/2 - board_w/2 + 1.0;          // reach under the board edge
    xw = sx * stack_w/2;                        // wall face
    translate([0, ya, 0]) rotate([90, 0, 0]) mirror([0, 0, 1]) linear_extrude(yb - ya)
        polygon([[xw, z_top], [xw - sx*p, z_top], [xw, z_top - p]]);
}
// stack bay in the main body: two side walls with shelves for the TP4056 and the ESP32,
// battery underneath, 45 deg front stops. Everything slides in from the back opening.
module battery_ribs_front() intersection() {
    y0 = bat_y0 - 4; y1 = split_y + lip_h;
    union() for (sx = [-1, 1]) {
        // side wall
        translate([sx * (stack_w/2 + 0.6) - 0.6, y0, wall]) cube([1.2, y1 - y0, stack_top - wall]);
        // battery front stop
        hull() {
            translate([sx * bat[0]/2 - (sx > 0 ? 0.3 : 0), bat_y0 - 0.01, wall]) cube([0.3, 0.01, bat[2]]);
            translate([sx > 0 ? bat[0]/2 - 4 : -bat[0]/2, bat_y0 - 4, wall]) cube([4, 0.01, bat[2]]);
        }
        // TP4056 slot: snug side guides, 45 deg shelf under + lip over each long edge, front stop
        board_slot(sx, tp_pcb[1], tp_pcb[2], tp_z0, tp_y0, y1, 1.0);
        // ESP32 slot: snug side guides, shelf, front stop + the same full-length lip rail as the TP4056 slot; bumps at the back end
        board_slot(sx, esp_pcb[1], esp_pcb[2], esp_z0, esp_y0, y1, 1.0);
        translate([sx > 0 ? esp_pcb[1]/2 - 0.6 : -stack_w/2, y_esp - 2.5, esp_z0 + esp_pcb[2] + 0.2])
            cube([stack_w/2 - esp_pcb[1]/2 + 0.6, 2.0, 0.6]);
    }
    outer_main();
}
// one side of a board slot. Board slides in from the back opening until its front edge hits the stop at ya,
// so its back edge ends flush with the body opening (board_y1). Everything prints upright, no support.
module board_slot(sx, bw, bt, z0, ya, yb, lip_reach) {
    xw = sx * stack_w/2;                      // side wall face
    xs = sx * (bw/2 + slot_clr);              // slot side face
    zt = bt + slot_zclr;
    shelf(sx, bw, ya - stop_len, yb, z0);     // 45 deg wedge under the board edge
    translate([min(xw, xs), ya - stop_len, z0 - eps])                       // side guide (narrows the slot)
        cube([abs(xw - xs), yb - ya + stop_len, zt + (lip_reach > 0 ? 1.0 : 0) + eps]);
    if (lip_reach > 0) let(xl = sx * (bw/2 - lip_reach))                    // lip over the board edge
        translate([min(xw, xl), ya - stop_len, z0 + zt]) cube([abs(xw - xl), yb - ya + stop_len, 1.0]);
    p = stack_w/2 - bw/2 + stop_reach;        // front stop: 45 deg underside, stands above the board
    intersection() {
        translate([0, ya, 0]) rotate([90, 0, 0]) linear_extrude(stop_len)
            polygon([[xw, z0 - p], [xw - sx*p, z0], [xw - sx*p, z0 + bt + 1.0], [xw, z0 + bt + 1.0]]);
        translate([-100, -100, stop_zmin]) cube(200);     // the TP4056 stopper now sits over the battery: keep its underside above the battery top
    }
}
// clean seam: thin matching chamfer on both outer edges at the parting plane
module seam_chamfer_front() union() {
    intersection() { half_y(split_y - seam_ch*0.5, split_y + eps); difference() { half_y(-200, 200); inner_solid(seam_ch); } }
    intersection() { half_y(split_y - seam_ch, split_y - seam_ch*0.5 + eps); difference() { half_y(-200, 200); inner_solid(seam_ch*0.5); } }
}
module seam_chamfer_back() union() {
    intersection() { half_y(split_y - eps, split_y + seam_ch*0.5); difference() { half_y(-200, 200); inner_solid(seam_ch); } }
    intersection() { half_y(split_y + seam_ch*0.5 - eps, split_y + seam_ch); difference() { half_y(-200, 200); inner_solid(seam_ch*0.5); } }
}
// lid: remove the inner part of its wall where the lip slides in (outer skin lip_keep stays)
module rebate() intersection() {
    half_y(split_y - eps, split_y + lip_h + 0.3);
    union() {
        shell_band(lip_keep, wall + 0.6);
        intersection() { translate([-200, -200, lip_thick_z - 1]) cube(400); shell_band(lip_keep, lip_keep + lip_clr + lip_t + lip_h + 0.4); }
    }
}
module dimples() intersection() {
    extrude_y(-100, 200) snap_windows2d();
    half_y(split_y + snap_y0 - 0.05, split_y + snap_y0 + snap_top + snap_ramp + 0.25);   // 0.05 play behind the holding face
    shell_band(lip_keep - snap_h, lip_keep + 0.1);                                        // leaves lip_keep - snap_h = 0.8 of outer skin
}
// ------------------------------------------------------------
// SCREW FIT: 4 bosses in the body (pilot holes) + 4 bosses in the lid (clearance hole + head pocket)
// ------------------------------------------------------------
function scr_sx(p) = p[0] < 0 ? -1 : 1;
// outer skin y at (x, z) on the back (head above z 40, body below)
function scr_yout(x, z) = z > 40 ? -head_y(x, z) : body_cy + body_sy * sqrt(max(0, pow(body_r(z), 2) - x*x));
function scr_floor(p) = scr_yout(p[0] + scr_sx(p) * scr_head_d/2, p[1]) - scr_head_h;   // pocket floor y: the outer edge keeps scr_head_h of rim
module scr_boss2d(p) hull() {
    sx = scr_sx(p);
    translate([p[0], p[1]]) circle(d = scr_boss_d, $fn = 48);
    translate([p[0] + sx*scr_reach, p[1]]) circle(d = scr_boss_d, $fn = 48);
    translate([p[0] + sx*scr_reach, p[1] - scr_reach]) circle(d = scr_boss_d, $fn = 48);   // 45 deg underside
}
module screw_front() if (screw_on) for (p = scr_pts) intersection() {
    extrude_y(split_y - scr_body_len, scr_body_len) scr_boss2d(p);
    outer_main();
}
module screw_front_cuts() if (screw_on) for (p = scr_pts)
    extrude_y(split_y - scr_pilot_len, scr_pilot_len + 1) translate([p[0], p[1]]) circle(d = scr_pilot, $fn = 24);
// lid boss: inside the front lip ring where the lip slides (offset >= wall + 0.65), full to the skin behind the rebate
module screw_lid() if (screw_on) for (p = scr_pts) intersection() {
    extrude_y(split_y + scr_gap, 40) scr_boss2d(p);
    union() {
        intersection() { half_y(split_y, split_y + lip_h + 0.3); inner_solid(p[1] > lip_thick_z - 1 ? lip_keep + lip_clr + lip_t + lip_h + 0.5 : wall + 0.65); }   // above z 64 the lid rebate is cut deeper (thick lip root)
        half_y(split_y + lip_h + 0.3 - eps, 200);
    }
    outer_main();
}
module screw_lid_cuts() if (screw_on) for (p = scr_pts) {
    extrude_y(split_y - 1, 60) translate([p[0], p[1]]) circle(d = scr_clear, $fn = 24);
    extrude_y(scr_floor(p), 60) translate([p[0], p[1]]) circle(d = scr_head_d, $fn = 32);
}
echo(str("screw pocket floors y: ", [for (p = scr_pts) scr_floor(p)], "  outer y at axis: ", [for (p = scr_pts) scr_yout(p[0], p[1])]));

module back_shell() difference() {
    union() {
        intersection() {
            difference() { union() { outer_main(); tail(); } cavity(); }
            half_y(split_y, 200);
        }
        port_block();
        switch_block();
        battery_ribs();
        screw_lid();
    }
    rebate();
    if (snap_on) dimples();
    screw_lid_cuts();
    seam_chamfer_back();
    port_cuts();
    switch_cuts();
}

// ------------------------------------------------------------
// Component dummies (for fit checks)
// ------------------------------------------------------------
module components(only = -1) {
    if (only < 0 || only == 0) color("navy") translate([-34.5/2, y_if, win_zc - 23/2]) cube([34.5, oled_glass_t, 23]);
    if (only < 0 || only == 1) color("darkgreen") translate([-oled_pcb[0]/2, pcb_front_y, oled_zc - oled_pcb[1]/2]) cube([oled_pcb[0], oled_pcb[2], oled_pcb[1]]);
    if (only < 0 || only == 2) color("black") translate([-esp_pcb[1]/2, esp_y0, esp_z0]) cube([esp_pcb[1], esp_pcb[0], esp_pcb[2]]);
    if (only < 0 || only == 3) color("silver") translate([-4.5, y_esp - 7.3 + 0.5, esp_z0 + esp_pcb[2]]) cube([9, 7.3, usb_h]);   // ESP32 USB-C faces the opening
    if (only < 0 || only == 4) color("blue") translate([-tp_pcb[1]/2, tp_y0, tp_z0]) cube([tp_pcb[1], tp_pcb[0], tp_pcb[2]]);
    if (only < 0 || only == 5) color("silver") translate([-4.5, usb_face_y - 7.3, tp_z0 + tp_pcb[2]]) cube([9, 7.3, usb_h]);
    if (only < 0 || only == 6) color("gold") translate([-bat[0]/2 + 0.25, bat_y0 + 0.25, wall + 0.3]) cube(bat - [0.5, 0.5, 0.5]);
    if (only < 0 || only == 7) color("gray") { translate([-10.5/2, y_sw - sw_depth, sw_z - 4.5/2]) cube([10.5, sw_depth, 4.5]);
                                                 translate([-sw_lever[0]/2 - sw_travel/2, y_sw, sw_z - sw_lever[1]/2]) cube([sw_lever[0], sw_lever[2], sw_lever[1]]); }
    if (only < 0 || only == 8) color("red") at_tb() translate([-tp_board[0]/2, -tp_board[1]/2, -tp_board[2]]) cube(tp_board);
}
// pcb fit envelope used by the head (OLED pcb + glass) must be inside the head inner
module oled_envelope() {
    translate([-bay_in[0]/2, pcb_front_y, oled_zc - bay_in[1]/2]) cube([bay_in[0], oled_pcb[2], bay_in[1]]);
    translate([-glass_in[0]/2, y_if, win_zc - glass_in[1]/2]) cube([glass_in[0], oled_glass_t, glass_in[1]]);
}

// ------------------------------------------------------------
// Output selector
// ------------------------------------------------------------
module print_front() { front_shell(); if (modelled_supports) all_supports(); }   // printed UPRIGHT, with the snap-off supports
module print_back()  { back_shell(); if (modelled_supports) lid_supports(); }   // printed UPRIGHT, tail on a snap-off support

if      (part == "assembly")    { front_shell(); back_shell(); }   // wings are built into the front shell
else if (part == "outer")       { outer_main(); trunk(); tail(); for (sx = [-1, 1]) { ele_foot(sx); ear(sx); arm(sx); } }
else if (part == "front")       front_shell();
else if (part == "back")        back_shell();
else if (part == "wing")        wing(1);
else if (part == "wingL")       wing(-1);
else if (part == "print_front") print_front();
else if (part == "print_back")  print_back();
else if (part == "print_wingR") wing_print(1);
else if (part == "print_wingL") wing_print(-1);
else if (part == "rim")         hood_rim();
else if (part == "supports")    all_supports();
else if (part == "oled_out")    difference() { oled_envelope(); union() { head_hull(1.0); body_outer(-1.0); } }   // must be EMPTY
else if (part == "check_front") intersection() { front_shell(); union() { components(0); components(1); for (k = [2, 4, 5, 6, 8]) components(k); } }
else if (part == "check_back")  intersection() { back_shell(); union() { for (k = [2:7]) components(k); } }
else if (part == "check_parts") intersection() { front_shell(); back_shell(); }   // front and lid must not overlap: must be EMPTY
else if (part == "check_all")   intersection() { union() { front_shell(); back_shell(); } components(); }
