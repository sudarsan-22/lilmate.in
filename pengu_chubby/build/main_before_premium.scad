// ============================================================
// Project : Pengu CHUBBY desk buddy (lilmate) - one-piece main body + snap-on back lid
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
lip_keep  = 0.9;
lip_clr   = 0.12;       // tighter snap = no visible gap at the seam
seam_ch   = 0.35;       // small matching chamfer on both seam edges (clean, even line)
snap_h    = 0.40;

/* [Body: round sitting ball] */
body_cy  = 3;
body_R   = 26.5;
body_sy  = 0.9;
body_zm  = 20;
body_alo = 35;
body_aup = 26;
body_fil = 3;

/* [Head] */
head_c   = [0, 0, 63];
head_rx  = 19;          // lobe x radius (half width = head_sx + head_rx = 31)          // radius of each lobe in x  (half width = head_sx + head_rx = 37)
head_ry  = 26;          // depth radius (front/back)
head_sx  = 12;          // flat-ish front: lobes offset +-x
head_top = [2, 23];     // top at +25     // upper lobes: z offset, z radius  -> top at +29
head_bot = [-12, 12];   // bottom at -24   // lower lobes: z offset, z radius  -> bottom at -27 (full chin)

/* [Face] */
rim_r      = 1.4;       // hood edge ridge radius
visor_half = [21.5, 10.8];
visor_rad  = 9.5;
visor_dz   = -1;      // visor centre vs head centre (sits low like the reference)
visor_rec  = 1.2;

/* [OLED] */
oled_pcb    = [35.4, 33.5, 1.2];
oled_glass_t= 1.5;
oled_win    = [31, 17];
oled_win_dz = 0;
y_if        = -18.2;    // OLED glass front plane: 2 mm closer to the visor (pcb corners keep >=1 mm plastic outside)    // OLED glass front plane (solved)    // OLED glass front plane
bay_clr     = 0.6;      // OLED pcb clearance per side (was 0.25: too tight)
bay_depth   = 3.5;      // holder depth behind the pcb (short = easy to fit)
bay_wall    = 1.4;

/* [ESP32-C3 Mini + TP4056] */
esp_pcb   = [22.5, 18.0, 1.0];
tp_pcb    = [26.0, 17.5, 1.6];
usb_h     = 3.3;
usb_hole  = [9.6, 3.9];            // horizontal USB-C opening (x, z)
plug_mold = [13.5, 7.8];           // horizontal cable-plug niche (x, z)
spine_t   = 1.6;
board_z   = 11;
port_wall = 1.2;

/* [Battery] */
bat = [20.5, 30.5, 5.5];           // x, y, z: battery lies lengthwise (front-back), leads at the back end

/* [Switch] */
// SS-12F15 metal slide switch (ears bent down): body 10.5 x 4.5 x 5.1, lever 3 x 3, 4 high, 3.2 travel
sw_body  = [11.8, 5.2];            // pocket (x, z) incl. bent ears + clearance
sw_depth = 5.1;                    // body depth (y)
sw_lever = [3, 3, 4];              // lever x, z, height
sw_travel= 3.2;
sw_slot  = [sw_lever[0] + sw_travel + 0.8, sw_lever[1] + 0.6];
sw_plate = 1.4;                    // wall the lever pokes through
sw_z     = 61;                     // back of the head, on the flat vertical band

/* [Touch] */
touch_t   = 1.6;
touch_box = [17, 12.5];          // TTP223 15 x 11 + clearance
touch_y   = -5;                  // centre y of the touch pocket

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
y_back    = min(body_in_y(tp_pcb[1]/2 + 0.3, tp_z0), body_in_y(tp_pcb[1]/2 + 0.3, tp_z0 + tp_pcb[2] + usb_h)) - 0.4;
esp_z0    = tp_z0 + tp_pcb[2] + usb_h + 1.6;          // ESP32 pcb bottom
y_esp     = split_y + lip_h - 0.6;                    // ESP32 back end (USB-C) just inside the opening
bat_y0    = body_cy - bat[1]/2;                                 // battery front end
bat_y1    = body_cy + bat[1]/2;                                 // battery back end
y_sw      = head_c.y + head_ry - wall - 0.2;   // switch sits on the flat back of the head (inner wall face)

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

echo(str("y_esp=", y_esp, " bat_y=[", bat_y0, ",", bat_y1, "] y_back=", y_back, " y_sw=", y_sw, " oled_zc=", oled_zc));

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
module head_inner() intersection() { head_hull(wall); half_y(y_if, 200); }

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
module body_inner() body_rev(-wall, body_sy_in);

// soft collar that blends the head underside into the body (no sharp crease)
module neck_collar() ell([0, body_cy - 1.5, head_c.z + head_bot[0] - head_bot[1] + 0.5], [21, 19, 3.2]);
module outer_main() union() { head_outer(); body_outer(); neck_collar(); }
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
        C  = S - U*0.45)
        [for (j = [0:M-1]) let(f = 360*j/M) C + rim_r*(cos(f)*U + sin(f)*V)]];
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
    // funnel from the visor floor to the flat OLED window
    hull() {
        extrude_y(head_c.y - head_ry - 2, 0.01) visor2d(-1.6);
        extrude_y(y_if - 0.01, 0.01) translate([0, win_zc]) rrect(oled_win, 1.5);
    }
}

// curled tuft: tall lobe + curl to the right
module tuft() {
    zt = head_c.z + head_top[0] + head_top[1];   // head top
    ty = -3;
    sy = 0.8;
    translate([0, ty, zt]) scale([0.82, 0.82*sy, 0.82]) translate([0, -ty, -zt]) {
        translate([-1.8, ty, zt + 2.0]) rotate([0, 18, 0]) scale([7.2, 7.0, 10.0]) sphere(1);
        curl = [[[3.5, zt + 3.5], 6.2], [[8.8, zt + 6.2], 5.4], [[13.4, zt + 4.8], 4.4], [[15.4, zt + 1.2], 3.4]];
        for (i = [0:len(curl)-2]) hull() {
            translate([curl[i][0][0],   ty, curl[i][0][1]])   sphere(r = curl[i][1]);
            translate([curl[i+1][0][0], ty, curl[i+1][0][1]]) sphere(r = curl[i+1][1]);
        }
    }
}

// blush cheeks: soft raised ovals under the visor corners (paint pink)
module cheeks() for (sx = [-1, 1]) intersection() {
    head_hull(-0.7);
    extrude_y(-60, 50) translate([sx * 17.5, oled_zc - 14.2]) rotate(sx * 8) scale([4.3, 2.7]) circle(r = 1, $fn = 48);
    half_y(-200, -6);
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
            ell([x, foot_y - 6.8, 5.6], [3.4, 1.3, 2.5]);
            for (t = [-1, 0, 1])
                ell([x + t*3.5, foot_y - 6.1, 10.0 - abs(t)*0.9], [1.35, 1.1, 1.35]);
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
        extrude_y(pcb_front_y - eps, bay_end - pcb_front_y)
            translate([0, oled_zc]) difference() {
                square([bay_in[0] + 2*bay_wall, bay_in[1] + 2*bay_wall], center = true);
                square([bay_in[0], bay_in[1]], center = true);
            }
        outer_main();
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
    extrude_y(pcb_front_y, split_y + lip_h + 1 - pcb_front_y) translate([0, oled_zc]) square(bay_in, center = true);
    // corner slits -> flexible side walls
    intersection() {                                   // never cut the outer skin
        for (sx = [-1, 1], sz = [-1, 1])
            translate([sx * (bay_in[0]/2 + bay_wall/2) - 0.3, pcb_front_y + 0.2, oled_zc + sz * (bay_in[1]/2 + 0.3) - 0.3])
                cube([0.6, 30, 0.6 + bay_wall]);
        head_hull(1.0);
    }
}

// TTP223 pocket under the head top: follows the dome, leaves touch_t of plastic
module touch_pocket() intersection() {
    head_hull(touch_t);
    translate([-touch_box[0]/2, touch_y - touch_box[1]/2, head_c.z + 10]) cube([touch_box[0], touch_box[1], 40]);
}

module snap_windows2d() {
    for (sx = [-1, 1]) {
        translate([sx * 30, head_c.z]) square([12, 10], center = true);
        translate([sx * 24.5, 14]) square([12, 8],  center = true);
    }
    translate([0, head_c.z + 24]) square([12, 10], center = true);
}

// ---- snap joint that FOLLOWS the curved skin (constant thickness, never pokes out) ----
module inner_solid(off) union() { head_hull(off); body_outer(-off); }
module shell_band(o1, o2) difference() { inner_solid(o1); inner_solid(o2); }   // layer between skin-offsets o1 < o2
lip_t = 1.0;
module lip() intersection() {
    half_y(split_y - eps, split_y + lip_h);
    shell_band(lip_keep + lip_clr, lip_keep + lip_clr + lip_t);
}
module lip_bumps() intersection() {
    extrude_y(-100, 200) snap_windows2d();
    union() {
        intersection() { half_y(split_y + 1.1, split_y + 2.3); shell_band(lip_keep + lip_clr - snap_h,     lip_keep + lip_clr + 0.2); }
        intersection() { half_y(split_y + 0.6, split_y + 2.8); shell_band(lip_keep + lip_clr - snap_h/2,   lip_keep + lip_clr + 0.2); }
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
module front_shell() {
    difference() {
        union() {
            intersection() {
                difference() {
                    union() { outer_main(); belly(); heart(); tuft(); cheeks(); for (sx = [-1, 1]) { foot(sx); wing_T(sx) wing_shape(); } }
                    cavity();
                }
                half_y(-200, split_y);
            }
            lip();
            lip_bumps();
            oled_bay_walls();
            battery_ribs_front();
        }
        face_cuts();
        oled_bay_cuts();
        touch_pocket();
        seam_chamfer_front();
        translate([-5, split_y - 1.5, -1]) cube([10, 5, 2.2]);   // pry notch
    }
    hood_rim();
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

module port_block() intersection() {
    difference() {
        extrude_y(y_back, 40) translate([tp_usb_x, port_z]) rrect([plug_mold[0] + 2*1.2 + 1, plug_mold[1] + 2*1.2 + 1], 3);
        extrude_y(y_back + port_wall, 41) translate([tp_usb_x, port_z]) rrect([plug_mold[0] + 1, plug_mold[1] + 1], 2.4);
    }
    outer_main();
}
module port_cuts() {
    extrude_y(y_back + port_wall, 60) translate([tp_usb_x, port_z]) rrect([plug_mold[0] + 1, plug_mold[1] + 1], 2.4);
    extrude_y(y_back - 1, 10) translate([tp_usb_x, port_z]) rrect(usb_hole, 1.2);      // TP4056 only
}
module switch_block() intersection() {
    union() {
        // tower: switch slides in from the open side, lever first, until the body hits the plate
        extrude_y(split_y, y_sw - split_y + sw_plate) translate([0, sw_z]) difference() {
            square(sw_body + [2.4, 2.4], center = true);
            square(sw_body, center = true);
        }
        // plate + sleeve out to the skin
        difference() {
            extrude_y(y_sw, 30) translate([0, sw_z]) rrect([sw_slot[0] + 6.4, sw_slot[1] + 5.4], 2.5);
            extrude_y(y_sw + sw_plate, 31) translate([0, sw_z]) rrect([sw_slot[0] + 4, sw_slot[1] + 3], 2);
        }
    }
    outer_main();
}
// small retaining bumps inside the tower (hold the switch body against the plate)
module switch_bumps() intersection() {
    for (sz = [-1, 1])
        translate([-3, y_sw - sw_depth - 1.6, sw_z + sz * (sw_body[1]/2) - (sz > 0 ? 0.4 : 0)])
            cube([6, 1.2, 0.4]);
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
            hull() {
                translate([sx * bat[0]/2 - (sx > 0 ? 0.3 : 0), bat_y1, wall]) cube([0.3, 0.01, bat[2]]);
                translate([sx > 0 ? bat[0]/2 - 4 : -bat[0]/2, bat_y1 + 4, wall]) cube([4, 0.01, bat[2]]);
            }
        }
    }
    intersection() { outer_main(); half_y(split_y, 200); }
}
// battery pocket, front half: side ribs + 45 deg corner stops (printed from the seam plane)
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
        // TP4056 slot: shelf under + lip over each long edge
        for (zz = [[tp_z0 - 1.2, 1.2], [tp_z0 + tp_pcb[2] + 0.25, 1.0]])
            translate([sx > 0 ? tp_pcb[1]/2 - 1.0 : -stack_w/2, y_back - tp_pcb[0] - 1, zz[0]])
                cube([stack_w/2 - tp_pcb[1]/2 + 1.0, y1 - (y_back - tp_pcb[0] - 1), zz[1]]);
        // ESP32 shelf (board rests on it; bumps at the back end keep it in)
        translate([sx > 0 ? esp_pcb[1]/2 - 1.0 : -stack_w/2, y_esp - esp_pcb[0] - 1, esp_z0 - 1.2])
            cube([stack_w/2 - esp_pcb[1]/2 + 1.0, y1 - (y_esp - esp_pcb[0] - 1), 1.2]);
        translate([sx > 0 ? esp_pcb[1]/2 - 0.6 : -stack_w/2, y_esp - 2.5, esp_z0 + esp_pcb[2] + 0.2])
            cube([stack_w/2 - esp_pcb[1]/2 + 0.6, 2.0, 0.6]);
    }
    outer_main();
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
    shell_band(lip_keep, wall + 0.6);
}
module dimples() intersection() {
    extrude_y(-100, 200) snap_windows2d();
    half_y(split_y + 0.7, split_y + 2.7);
    shell_band(lip_keep - 0.35, lip_keep + 0.1);
}
module back_shell() difference() {
    union() {
        intersection() {
            difference() { union() { outer_main(); tail(); } cavity(); }
            half_y(split_y, 200);
        }
        port_block();
        switch_block();
        switch_bumps();
        battery_ribs();
    }
    rebate();
    dimples();
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
    if (only < 0 || only == 2) color("black") translate([-esp_pcb[1]/2, y_esp - esp_pcb[0], esp_z0]) cube([esp_pcb[1], esp_pcb[0], esp_pcb[2]]);
    if (only < 0 || only == 3) color("silver") translate([-4.5, y_esp - 7.3 + 0.5, esp_z0 + esp_pcb[2]]) cube([9, 7.3, usb_h]);   // ESP32 USB-C faces the opening
    if (only < 0 || only == 4) color("blue") translate([-tp_pcb[1]/2, y_back - tp_pcb[0], tp_z0]) cube([tp_pcb[1], tp_pcb[0], tp_pcb[2]]);
    if (only < 0 || only == 5) color("silver") translate([-4.5, y_back - 7.3, tp_z0 + tp_pcb[2]]) cube([9, 7.3, usb_h]);
    if (only < 0 || only == 6) color("gold") translate([-bat[0]/2 + 0.25, bat_y0 + 0.25, wall + 0.3]) cube(bat - [0.5, 0.5, 0.5]);
    if (only < 0 || only == 7) color("gray") { translate([-10.5/2, y_sw - sw_depth, sw_z - 4.5/2]) cube([10.5, sw_depth, 4.5]);
                                                 translate([-sw_lever[0]/2 - sw_travel/2, y_sw, sw_z - sw_lever[1]/2]) cube([sw_lever[0], sw_lever[2], sw_lever[1]]); }
    if (only < 0 || only == 8) color("red") translate([-7.5, touch_y - 5.5, head_c.z + 18.5]) cube([15, 11, 1.6]);
}
// pcb fit envelope used by the head (OLED pcb + glass) must be inside the head inner
module oled_envelope() {
    translate([-bay_in[0]/2, pcb_front_y, oled_zc - bay_in[1]/2]) cube([bay_in[0], oled_pcb[2], bay_in[1]]);
    translate([-glass_in[0]/2, y_if, win_zc - glass_in[1]/2]) cube([glass_in[0], oled_glass_t, glass_in[1]]);
}

// ------------------------------------------------------------
// Output selector
// ------------------------------------------------------------
module print_front() translate([0, 0, split_y + lip_h]) rotate([-90, 0, 0]) front_shell();
module print_back()  translate([0, 0, -split_y]) rotate([90, 0, 0]) back_shell();

if      (part == "assembly")    { front_shell(); back_shell(); }   // wings are built into the front shell
else if (part == "outer")       { outer_main(); tuft(); belly(); heart(); cheeks(); tail(); for (sx = [-1, 1]) foot(sx); hood_rim(); wing(1); wing(-1); }
else if (part == "front")       front_shell();
else if (part == "back")        back_shell();
else if (part == "wing")        wing(1);
else if (part == "wingL")       wing(-1);
else if (part == "print_front") print_front();
else if (part == "print_back")  print_back();
else if (part == "print_wingR") wing_print(1);
else if (part == "print_wingL") wing_print(-1);
else if (part == "rim")         hood_rim();
else if (part == "oled_out")    difference() { oled_envelope(); union() { head_hull(1.0); body_outer(-1.0); } }   // must be EMPTY
else if (part == "check_front") intersection() { front_shell(); union() { components(0); components(1); components(6); components(8); } }
else if (part == "check_back")  intersection() { back_shell(); union() { for (k = [2:7]) components(k); } }
else if (part == "check_all")   intersection() { union() { front_shell(); back_shell(); } components(); }
