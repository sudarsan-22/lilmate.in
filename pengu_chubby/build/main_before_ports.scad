// ============================================================
// Project : Pengu CHUBBY desk buddy (lilmate)
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
$fn  = 96;
eps  = 0.01;

/* [Shell] */
wall      = 2.2;
split_y   = 2;
lip_h     = 3.0;
lip_keep  = 0.9;
lip_clr   = 0.15;
snap_h    = 0.40;

/* [Body: round sitting ball] */
body_cy  = 3;
body_R   = 33;
body_sy  = 0.885;
body_zm  = 24;
body_alo = 31;
body_aup = 30;
body_fil = 4;

/* [Head] */
head_c   = [0, 0, 72];
head_rx  = 32;          // radius of each lobe in x  (half width = head_sx + head_rx = 37)
head_ry  = 32;          // depth radius (front/back)
head_sx  = 5;          // flat-ish front: lobes offset +-x
head_top = [2, 27];     // upper lobes: z offset, z radius  -> top at +29
head_bot = [-13, 14];   // lower lobes: z offset, z radius  -> bottom at -27 (full chin)

/* [Face] */
rim_r      = 1.6;       // hood edge ridge radius
visor_half = [25.8, 13];
visor_rad  = 11;
visor_dz   = -3.0;      // visor centre vs head centre (sits low like the reference)
visor_rec  = 1.2;

/* [OLED] */
oled_pcb    = [35.4, 33.5, 1.2];
oled_glass_t= 1.5;
oled_win    = [31, 17];
oled_win_dz = 0;
y_if        = -22.5;    // OLED glass front plane
bay_clr     = 0.25;
bay_wall    = 1.4;

/* [ESP32-C3 Mini + TP4056] */
esp_pcb   = [22.5, 18.0, 1.0];
tp_pcb    = [26.0, 17.5, 1.6];
usb_h     = 3.3;
usb_hole  = [3.9, 9.6];
plug_mold = [7.8, 13.5];
spine_t   = 1.6;
board_z   = 12;
port_z    = board_z + esp_pcb[1]/2;
port_wall = 1.2;

/* [Battery] */
bat = [30.5, 20.5, 5.5];

/* [Switch] */
sw_body = [8.8, 3.8];
sw_slot = [4.6, 2.2];
sw_z    = 38;

/* [Touch] */
touch_t   = 1.6;
touch_box = [17, 12.5];          // TTP223 15 x 11 + clearance
touch_y   = -9;                  // centre y of the touch pocket

/* [Wings] */
wing_az  = -33;                // azimuth of wing normal (deg, 0 = +x)
wing_z   = 33;
pin_d    = 1.95;

/* [Feet] */
foot_x = 18.5;

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

brd_x     = spine_t/2 + max(esp_pcb[2], tp_pcb[2]) + usb_h + 0.3;
y_back    = min(body_in_y(brd_x, board_z), body_in_y(brd_x, board_z + esp_pcb[1])) - 0.4;
esp_usb_x = -(spine_t/2 + esp_pcb[2] + usb_h/2);
tp_usb_x  =  (spine_t/2 + tp_pcb[2]  + usb_h/2);
tp_z0     = port_z - tp_pcb[1]/2;
y_sw      = min(body_in_y(sw_body[0]/2 + 1.2, sw_z - 3), body_in_y(sw_body[0]/2 + 1.2, sw_z + 3)) - 0.4;

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

echo(str("y_back=", y_back, " y_sw=", y_sw, " oled_zc=", oled_zc));

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

module outer_main() union() { head_outer(); body_outer(); }
module cavity()     union() { head_inner(); body_inner(); }

module outline2d() projection(cut = true) translate([0, 0, split_y]) rotate([-90, 0, 0]) outer_main();
module cavity2d()  projection(cut = true) translate([0, 0, split_y + 0.5]) rotate([-90, 0, 0]) cavity();

// ------------------------------------------------------------
// Face details
// ------------------------------------------------------------
// hood edge with widow's peak (x, z relative to head centre), left half
hood_half = [[-30, -20], [-32.6, -12], [-33.2, -2], [-31, 8], [-27, 14.4], [-21.5, 17.4],
             [-14.5, 17.1], [-7, 15.1], [0, 13.0]];
hood_ctrl = concat(hood_half, [for (i = [len(hood_half)-2:-1:0]) [-hood_half[i][0], hood_half[i][1]]]);

module hood_rim() {
    P  = cr_path(hood_ctrl, 10);
    N  = len(P); M = 18;
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
        difference() { head_hull(-1); head_hull(0.5); }
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
    translate([0, ty, 0]) scale([1, sy, 1]) translate([0, -ty, 0]) {
        translate([-1.8, ty, zt + 2.0]) rotate([0, 18, 0]) scale([7.2, 7.0, 10.0]) sphere(1);
        curl = [[[3.5, zt + 3.5], 6.2], [[8.8, zt + 6.2], 5.4], [[13.4, zt + 4.8], 4.4], [[15.4, zt + 1.2], 3.4]];
        for (i = [0:len(curl)-2]) hull() {
            translate([curl[i][0][0],   ty, curl[i][0][1]])   sphere(r = curl[i][1]);
            translate([curl[i+1][0][0], ty, curl[i+1][0][1]]) sphere(r = curl[i+1][1]);
        }
    }
}

module belly() intersection() {
    body_outer(0.6);
    extrude_y(-60, 55) translate([0, 28]) scale([24, 20]) circle(r = 1);
    half_y(-200, split_y - 6);
    translate([-200, -200, 1.0]) cube(400);
}

// upright paw: pad + three toe bumps on top
module foot(sx) {
    x = sx * foot_x;
    intersection() {
        union() {
            hull() {
                ell([x, -21, 8.5],  [11.5, 8.5, 9.0]);
                ell([x, -19, 1.5],  [10, 9, 2]);
            }
            for (t = [-1, 0, 1])
                ell([x + t*6.0, -22.0, 14.6 - abs(t)*1.3], [4.7, 6.2, 4.3]);
        }
        translate([-200, -200, 0]) cube(400);
    }
}

// ------------------------------------------------------------
// FRONT SHELL internals
// ------------------------------------------------------------
module oled_bay_walls() {
    y1 = split_y + lip_h;
    intersection() {
        extrude_y(y_if - eps, y1 - y_if)
            translate([0, oled_zc]) difference() {
                square([bay_in[0] + 2*bay_wall, bay_in[1] + 2*bay_wall], center = true);
                square([bay_in[0], bay_in[1]], center = true);
            }
        outer_main();
    }
    for (sx = [-1, 1])
        translate([sx * bay_in[0]/2, 0, oled_zc])
            hull() {
                translate([-sx*0.8 - 0.01, pcb_back_y + 0.15, -3.5]) cube([0.02, 0.01, 7]);
                translate([0, pcb_back_y + 0.15, -3.5]) cube([0.02, 2.2, 7]);
            }
}
module oled_bay_cuts() {
    extrude_y(y_if, split_y + lip_h + 1 - y_if) translate([0, oled_zc]) square(bay_in, center = true);
    for (sx = [-1, 1]) {
        xw = sx * (bay_in[0]/2 + bay_wall/2);
        for (dz = [-4.2, 4.2])
            translate([xw - bay_wall, pcb_back_y - 1.4, oled_zc + dz - 0.35]) cube([2*bay_wall, 12, 0.7]);
        translate([xw - bay_wall, pcb_back_y - 1.4, oled_zc - 4.55]) cube([2*bay_wall, 0.7, 9.1]);
    }
    translate([-6, pcb_back_y, oled_zc + bay_in[1]/2 - 1]) cube([12, 20, bay_wall + 3]);
}

// TTP223 pocket under the head top: follows the dome, leaves touch_t of plastic
module touch_pocket() intersection() {
    head_hull(touch_t);
    translate([-touch_box[0]/2, touch_y - touch_box[1]/2, head_c.z + 14]) cube([touch_box[0], touch_box[1], 40]);
}

module snap_windows2d() {
    for (sx = [-1, 1]) {
        translate([sx * 35, head_c.z]) square([12, 10], center = true);
        translate([sx * 27.5, 14]) square([12, 8],  center = true);
    }
    translate([0, head_c.z + 28]) square([12, 10], center = true);
}

module lip() extrude_y(split_y - eps, lip_h + eps) difference() {
    offset(delta = -(lip_keep + lip_clr)) outline2d();
    cavity2d();
}
module lip_bumps() {
    extrude_y(split_y + 1.1, 1.2) intersection() {
        difference() {
            offset(delta = -(lip_keep + lip_clr) + snap_h) outline2d();
            offset(delta = -(lip_keep + lip_clr) - 0.2) outline2d();
        }
        snap_windows2d();
    }
    extrude_y(split_y + 0.6, 2.2) intersection() {
        difference() {
            offset(delta = -(lip_keep + lip_clr) + snap_h/2) outline2d();
            offset(delta = -(lip_keep + lip_clr) - 0.2) outline2d();
        }
        snap_windows2d();
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
wing_pins_local = [[0, 5], [0.5, -5]];                    // (a, b)

module wing_T(sx)     mirror([sx < 0 ? 1 : 0, 0, 0]) multmatrix(wing_M) children();
module wing_T_inv(sx) multmatrix(wing_M_inv) mirror([sx < 0 ? 1 : 0, 0, 0]) children();

module wing_shape() rotate([0, 0, -15]) hull() {
    ell([0, 4.5, 0],   [9.2, 8.2, 5.8]);
    ell([1.0, -6.5, 0.3], [6.4, 6.2, 4.4]);
}
module wing_pin_cyl() for (p = wing_pins_local)
    translate([p[0], p[1], 0]) cylinder(d = pin_d, h = 24, center = true, $fn = 16);
module wing_local(sx) difference() {
    wing_shape();
    wing_T_inv(sx) body_outer(0.15);
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
                    union() { outer_main(); belly(); tuft(); for (sx = [-1, 1]) foot(sx); }
                    cavity();
                }
                half_y(-200, split_y);
            }
            lip();
            lip_bumps();
            oled_bay_walls();
        }
        face_cuts();
        oled_bay_cuts();
        touch_pocket();
        wing_holes();
        translate([-5, split_y - 1.5, -1]) cube([10, 5, 2.2]);   // pry notch
    }
    hood_rim();
}

// ------------------------------------------------------------
// BACK SHELL (same mechanics as pengu v2)
// ------------------------------------------------------------
module spine() intersection() {
    union() {
        translate([-spine_t/2, split_y, board_z - 2]) cube([spine_t, 60, esp_pcb[1] + 4]);
        for (zz = [board_z - 1.4, board_z + esp_pcb[1] + 0.2])
            translate([-spine_t/2 - esp_pcb[2] - 1.0, split_y, zz]) cube([esp_pcb[2] + 1.0 + eps, 60, 1.2]);
        for (zz = [tp_z0 - 1.4, tp_z0 + tp_pcb[1] + 0.2])
            translate([spine_t/2 - eps, split_y, zz]) cube([tp_pcb[2] + 1.0, 60, 1.2]);
        translate([-spine_t/2 - esp_pcb[2] - 1.0, y_back - esp_pcb[0] + 1, board_z - 0.25])            cube([0.8, 2.5, 0.3]);
        translate([-spine_t/2 - esp_pcb[2] - 1.0, y_back - esp_pcb[0] + 1, board_z + esp_pcb[1] - 0.05]) cube([0.8, 2.5, 0.3]);
    }
    intersection() { outer_main(); half_y(split_y, 200); }
}
module port_block() intersection() {
    difference() {
        extrude_y(y_back, 40) translate([(esp_usb_x + tp_usb_x)/2, port_z])
            rrect([tp_usb_x - esp_usb_x + plug_mold[0] + 2*1.2, plug_mold[1] + 2*1.2], 3);
        extrude_y(y_back + port_wall, 41) translate([(esp_usb_x + tp_usb_x)/2, port_z])
            rrect([tp_usb_x - esp_usb_x + plug_mold[0], plug_mold[1]], 2.4);
    }
    outer_main();
}
module port_cuts() {
    extrude_y(y_back + port_wall, 60) translate([(esp_usb_x + tp_usb_x)/2, port_z])
        rrect([tp_usb_x - esp_usb_x + plug_mold[0], plug_mold[1]], 2.4);
    for (px = [esp_usb_x, tp_usb_x])
        extrude_y(y_back - 1, 10) translate([px, port_z]) rrect(usb_hole, 1.2);
}
module switch_block() intersection() {
    union() {
        extrude_y(split_y, y_sw - split_y + 1.2) translate([0, sw_z]) difference() {
            square(sw_body + [2.4, 2.4], center = true);
            square(sw_body, center = true);
        }
        difference() {
            extrude_y(y_sw, 30) translate([0, sw_z]) rrect([sw_body[0] + 4, sw_body[1] + 4.4], 2);
            extrude_y(y_sw + 1.2, 31) translate([0, sw_z]) rrect([sw_body[0] + 1.6, sw_body[1] + 2], 1.5);
        }
    }
    outer_main();
}
module switch_cuts() {
    extrude_y(y_sw + 1.2, 40) translate([0, sw_z]) rrect([sw_body[0] + 1.6, sw_body[1] + 2], 1.5);
    extrude_y(y_sw - 1, 10) translate([0, sw_z]) rrect(sw_slot, 0.6);
}
module battery_ribs() intersection() {
    for (sx = [-1, 1]) translate([sx * (bat[0]/2 + 0.6), split_y + 15, wall + 2.6]) cube([1.2, 30, 5.6], center = true);
    intersection() { outer_main(); half_y(split_y, 200); }
}
module rebate() extrude_y(split_y - eps, lip_h + 0.3) difference() {
    offset(delta = -lip_keep) outline2d();
    offset(delta = -(wall + 0.8)) outline2d();
}
module dimples() extrude_y(split_y + 0.7, 2.0) intersection() {
    difference() {
        offset(delta = -lip_keep + 0.35) outline2d();
        offset(delta = -lip_keep - 0.1) outline2d();
    }
    snap_windows2d();
}
module back_shell() difference() {
    union() {
        intersection() {
            difference() { outer_main(); cavity(); }
            half_y(split_y, 200);
        }
        spine();
        port_block();
        switch_block();
        battery_ribs();
    }
    rebate();
    dimples();
    port_cuts();
    switch_cuts();
}

// ------------------------------------------------------------
// Component dummies (for fit checks)
// ------------------------------------------------------------
module components(only = -1) {
    if (only < 0 || only == 0) color("navy") translate([-34.5/2, y_if, win_zc - 23/2]) cube([34.5, oled_glass_t, 23]);
    if (only < 0 || only == 1) color("darkgreen") translate([-oled_pcb[0]/2, pcb_front_y, oled_zc - oled_pcb[1]/2]) cube([oled_pcb[0], oled_pcb[2], oled_pcb[1]]);
    if (only < 0 || only == 2) color("black") translate([-spine_t/2 - esp_pcb[2], y_back - esp_pcb[0], board_z]) cube([esp_pcb[2], esp_pcb[0], esp_pcb[1]]);
    if (only < 0 || only == 3) color("silver") translate([esp_usb_x - usb_h/2, y_back - 7.3, port_z - 4.5]) cube([usb_h, 7.3, 9]);
    if (only < 0 || only == 4) color("blue") translate([spine_t/2, y_back - tp_pcb[0], tp_z0]) cube([tp_pcb[2], tp_pcb[0], tp_pcb[1]]);
    if (only < 0 || only == 5) color("silver") translate([tp_usb_x - usb_h/2, y_back - 7.3, port_z - 4.5]) cube([usb_h, 7.3, 9]);
    if (only < 0 || only == 6) color("gold") translate([-bat[0]/2 + 0.25, body_cy - bat[1]/2 + 0.25, wall + 0.3]) cube(bat - [0.5, 0.5, 0.5]);
    if (only < 0 || only == 7) color("gray") translate([-8.6/2, y_sw - 3.5, sw_z - 3.6/2]) cube([8.6, 3.5, 3.6]);
    if (only < 0 || only == 8) color("red") translate([-7.5, touch_y - 5.5, head_c.z + 22]) cube([15, 11, 1.6]);
}
// pcb fit envelope used by the head (OLED pcb + glass) must be inside the head inner
module oled_envelope() translate([-oled_pcb[0]/2, y_if, oled_zc - oled_pcb[1]/2]) cube([oled_pcb[0], oled_glass_t + oled_pcb[2], oled_pcb[1]]);

// ------------------------------------------------------------
// Output selector
// ------------------------------------------------------------
module print_front() translate([0, 0, split_y + lip_h]) rotate([-90, 0, 0]) front_shell();
module print_back()  translate([0, 0, -split_y]) rotate([90, 0, 0]) back_shell();

if      (part == "assembly")    { front_shell(); back_shell(); wing(1); wing(-1); }
else if (part == "outer")       { outer_main(); tuft(); belly(); for (sx = [-1, 1]) foot(sx); hood_rim(); wing(1); wing(-1); }
else if (part == "front")       front_shell();
else if (part == "back")        back_shell();
else if (part == "wing")        wing(1);
else if (part == "wingL")       wing(-1);
else if (part == "print_front") print_front();
else if (part == "print_back")  print_back();
else if (part == "print_wingR") wing_print(1);
else if (part == "print_wingL") wing_print(-1);
else if (part == "rim")         hood_rim();
else if (part == "oled_out")    difference() { oled_envelope(); union() { head_hull(0.8); body_outer(-0.8); } }   // must be EMPTY
else if (part == "check_front") intersection() { front_shell(); union() { components(0); components(1); components(8); } }
else if (part == "check_back")  intersection() { back_shell(); union() { for (k = [2:7]) components(k); } }
