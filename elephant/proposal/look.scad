// LOOK-ONLY proposal model of the elephant (for images, not for printing)
// Axes: X right, -Y front (face), Z up. Units mm.
$fn = 72;

C_body = [0.86, 0.84, 0.88];
C_pink = [0.86, 0.70, 0.92];
C_dark = [0.08, 0.08, 0.10];
C_eye  = [0.85, 0.95, 1.00];

module ell(c, r) translate(c) scale(r) sphere(1);

// ---------- head: round, egg-like (slightly fuller lower half) ----------
head_c = [0, 0, 65];
module head() hull() {
    ell(head_c + [0, 0, 3],  [34, 30, 24]);
    ell(head_c + [0, 0, -6], [31, 28, 20]);
}

// ---------- visor: glossy black pill flush on the face + smile eyes ----------
visor_c = [0, 68];
module pill2d(w, h, r) offset(r = r) square([w - 2*r, h - 2*r], center = true);
module on_face(th) intersection() {          // thin layer that follows the face surface
    difference() { scale([1 + th/34, 1 + th/30, 1 + th/24]) translate(-head_c) translate(head_c) head(); }
    translate([0, -60, 0]) rotate([90, 0, 0]) translate([0, 0, -60]) linear_extrude(60) children();
}
module visor() color(C_dark) intersection() {
    scale([1.012, 1.012, 1.0]) head();
    translate([0, -10, 0]) rotate([90, 0, 0]) linear_extrude(40) translate(visor_c) pill2d(44, 20.5, 10);
}
module eyes() color(C_eye) intersection() {
    scale([1.02, 1.02, 1.0]) head();
    translate([0, -10, 0]) rotate([90, 0, 0]) linear_extrude(40)
        for (sx = [-1, 1]) translate([sx * 9.5, visor_c[1] - 1.5])
            intersection() {
                difference() { circle(r = 4.6); circle(r = 3.3); }
                translate([-6, 0]) square([12, 6]);
            }
}

// ---------- trunk: short and thick, curls to the right just under the visor ----------
trunk_pts = [[0, -27.5, 58, 5.4], [0, -30.5, 53, 5.0], [0.5, -31.2, 47.5, 4.6], [2.2, -30.6, 43, 4.1],
             [5.2, -29.6, 41.2, 3.7], [7.6, -28.8, 43.0, 3.3], [8.0, -28.4, 46.0, 2.9]];
module trunk() color(C_body) {
    n = len(trunk_pts);
    P = concat([for (i = [0:n-2], k = [0:2]) trunk_pts[i] + (trunk_pts[i+1] - trunk_pts[i]) * k/3], [trunk_pts[n-1]]);
    for (i = [0:len(P)-2]) hull() {
        translate([P[i][0], P[i][1], P[i][2]])       sphere(r = 1.18 * P[i][3]   * (i % 2 == 1 ? 0.975 : 1));
        translate([P[i+1][0], P[i+1][1], P[i+1][2]]) sphere(r = 1.18 * P[i+1][3] * ((i+1) % 2 == 1 ? 0.975 : 1));
    }
}

// ---------- ears: big leaf/D shape, set high and back, angled toward the viewer ----------
module ear2d() offset(r = 3) offset(r = -3) hull() {
    translate([13, 8])   rotate(-15) scale([14, 18.5]) circle(r = 1, $fn = 160);   // round dome top
    translate([15, -12]) rotate(25)  scale([9, 8])     circle(r = 1, $fn = 128);   // lower lobe
    translate([1, 0])    scale([3.5, 11]) circle(r = 1, $fn = 96);                 // root behind the head
}
module ear_body() minkowski() { linear_extrude(0.01) offset(delta = -3.8) ear2d(); sphere(r = 3.8, $fn = 40); }
module ear_inner() translate([0, 0, 2.0]) minkowski() { linear_extrude(3) offset(delta = -8) ear2d(); sphere(r = 2.6, $fn = 32); }
module ear(sx) translate([sx * 27, 7, 70]) rotate([0, 0, sx * 28]) mirror([sx < 0 ? 1 : 0, 0, 0]) rotate([90, 0, 0]) {
    color(C_body) difference() { ear_body(); ear_inner(); }
    color(C_pink) translate([0, 0, -0.8]) intersection() { ear_inner(); translate([-50, -50, -10]) cube([100, 100, 11.6]); }
}

// ---------- body: round pear, sitting ----------
module body() color(C_body) intersection() {
    hull() {
        ell([0, 2, 22], [25.5, 23, 22]);
        ell([0, 2, 9],  [24, 22, 9]);
    }
    translate([-100, -100, 0]) cube(200);
}

// ---------- arms: big round ovals hugging the belly ----------
module arm(sx) color(C_body) translate([sx * 24.5, -9, 27]) rotate([0, sx * 14, 0]) rotate([-12, 0, 0]) scale([8.6, 9, 11.8]) sphere(1);

// ---------- feet: big round soles facing forward, pink pad + 3 toe beans ----------
module foot(sx) {
    x = sx * 18.5;
    color(C_body) intersection() {
        hull() { ell([x, -10, 11], [10.8, 9, 11]); ell([x, -21.5, 11], [10.8, 2.6, 10.8]); }
        translate([-100, -100, 0]) cube(200);
    }
    color(C_pink) {
        ell([x, -23.6, 8.6], [5.4, 1.2, 4.4]);
        for (t = [-1, 0, 1]) ell([x + t*4.8, -23.2, 16.2 - abs(t)*1.5], [2.0, 1.2, 2.0]);
    }
}

// ---------- assembly ----------
color(C_body) head();
visor();
eyes();
trunk();
for (sx = [-1, 1]) { ear(sx); arm(sx); foot(sx); }
body();
