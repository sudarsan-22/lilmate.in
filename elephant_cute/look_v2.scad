// LOOK-ONLY proposal v2 ("cuter"): rounder head, oval visor, puffy round ears, chunkier body/arms/feet. NOT for printing.
// sel: 0 body colour, 1 pink, 2 dark visor, 3 eyes
sel = 0;
$fn = 72;
module ell(c, r) translate(c) scale(r) sphere(1);

HZ = 74;                                  // head centre height (body is bigger now)
head_c = [0, 0, HZ];
module head() hull() {
    ell(head_c + [0, 0, 2],  [33, 30, 29]);     // 66 wide x ~61 tall: nearly round (was 68 x 53, squat egg)
    ell(head_c + [0, 0, -6], [30, 28, 24]);
}
// visor: a true OVAL (was a pill with straight sides)
module visor_2d() scale([22, 12.8]) circle(1, $fn = 120);
visor_c = [0, HZ + 1.5];
module on_face(k) intersection() {
    scale([k, k, 1.0]) head_at();
    translate([0, -10, 0]) rotate([90, 0, 0]) linear_extrude(60) children();
}
module head_at() head();
module visor() intersection() {
    scale([1.012, 1.012, 1.0]) head();
    translate([0, -10, 0]) rotate([90, 0, 0]) linear_extrude(40) translate(visor_c) visor_2d();
}
module eyes() intersection() {
    scale([1.02, 1.02, 1.0]) head();
    translate([0, -10, 0]) rotate([90, 0, 0]) linear_extrude(40)
        for (sx = [-1, 1]) translate([sx * 9.5, visor_c[1] - 2.2])
            intersection() { difference() { circle(r = 5.6); circle(r = 3.9); } translate([-7, 0]) square([14, 7]); }
}
// trunk: same short curl, a touch chubbier, under the visor
trunk_pts = [[0, -28.5, 66, 6.0], [0, -31.5, 60, 5.6], [0.5, -32.2, 54, 5.2], [2.4, -31.6, 49, 4.7],
             [5.6, -30.4, 47.2, 4.2], [8.2, -29.5, 49.2, 3.7], [8.6, -29.0, 52.5, 3.3]];
module trunk() {
    n = len(trunk_pts);
    P = concat([for (i = [0:n-2], k = [0:2]) trunk_pts[i] + (trunk_pts[i+1] - trunk_pts[i]) * k/3], [trunk_pts[n-1]]);
    for (i = [0:len(P)-2]) hull() {
        translate([P[i][0], P[i][1], P[i][2]])       sphere(r = P[i][3]   * (i % 2 == 1 ? 0.975 : 1));
        translate([P[i+1][0], P[i+1][1], P[i+1][2]]) sphere(r = P[i+1][3] * ((i+1) % 2 == 1 ? 0.975 : 1));
    }
}
// ears: BIG ROUND puffy lobes (no corners), pink bowl inside - like the reference
ear_r = [19, 8, 21];                                    // x radius, thickness, z radius
module ear_shape() hull() { ell([0, 0, 0], ear_r); ell([3, 0, -9], [17, 7.2, 15]); }
module ear_bowl() translate([0, -4.2, 1.5]) scale([0.74, 1, 0.76]) ear_shape();
module ear_xf(sx) translate([sx * 38, 7, HZ + 5]) rotate([0, 0, sx * 26]) rotate([0, sx * -6, 0]) children();
module ear_body(sx) ear_xf(sx) difference() { ear_shape(); ear_bowl(); }
module ear_pink(sx) ear_xf(sx) intersection() { ear_shape(); translate([0, -4.2 - 3.2, 1.5]) scale([0.725, 1, 0.745]) ear_shape(); }
// body: chubby pear, as wide as the head (was 3/4 of it)
module body() intersection() {
    hull() { ell([0, 2, 28], [30, 27, 24]); ell([0, 2, 12], [31, 28, 12]); }
    translate([-100, -100, 0]) cube(200);
}
module arm(sx) translate([sx * 29.5, -9, 33]) rotate([0, sx * 12, 0]) rotate([-10, 0, 0]) scale([10.2, 10.5, 14]) sphere(1);
module foot_body(sx) { x = sx * 21;
    intersection() { hull() { ell([x, -11, 13], [12.4, 10, 13]); ell([x, -23, 13], [12.4, 3, 12.6]); }
                     translate([-100, -100, 0]) cube(200); } }
module foot_pink(sx) { x = sx * 21;
    ell([x, -25.6, 10.2], [6.2, 1.3, 5.0]);
    for (t = [-1, 0, 1]) ell([x + t*5.6, -25.2, 19.0 - abs(t)*1.8], [2.4, 1.3, 2.4]); }

if (sel == 0) { head(); trunk(); body(); for (sx = [-1, 1]) { ear_body(sx); arm(sx); foot_body(sx); } }
if (sel == 1) { for (sx = [-1, 1]) { ear_pink(sx); foot_pink(sx); } }
if (sel == 2) visor();
if (sel == 3) eyes();
