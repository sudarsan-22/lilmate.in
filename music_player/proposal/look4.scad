// Music player - LOOK proposal round 4 (after R&D, see research_notes.md). Look only, no internals.
// Rules: one hero element per design, body colour + one accent + black, features cut INTO the shell
// (no sticker decals), honest monochrome OLED face (white pixels), no fake speaker grilles.
// Parts: 1.3" OLED (128x64), ESP32-C3 Super Mini, YX6300 (microSD + 3.5 mm), TP4056 + Li-Po, TTP223, switch.
design = 0;        // 0 = all three, 10 = J Pocket Walkman, 11 = K Mochi Pebble, 12 = L Tiny Retro PC
view   = 0;        // 0 = front 3/4, 1 = back 3/4
$fn = 96;
only   = "";       // "" = everything in colour; else export just that colour part (for the Blender render)

c_glass = [0.07, 0.07, 0.09];
c_pix   = [0.96, 0.97, 1.00];          // OLED white pixels
c_shadow= [0.30, 0.30, 0.32];

// ---------- helpers ----------
// box with corner radius rp seen from the front (XZ) and edge radius re on the front/back edges. Centered.
module rr_box(w, h, d, rp, re) hull()
    for (x = [-1, 1], z = [-1, 1], y = [-1, 1])
        translate([x*(w/2 - rp), y*(d/2 - re), z*(h/2 - rp)]) rotate([90, 0, 0])
            rotate_extrude($fn = 48) intersection() { translate([rp - re, 0]) circle(re, $fn = 32); translate([0, -re]) square([rp, 2*re]); }
module rrect(s, r) offset(r) offset(-r) square(s, center = true);
// 2D shape placed on the front plane y = yf (centre x, z), extruded from yf - out to yf + in
module on_front(x, z, yf, out, inn) translate([x, yf - out, z]) rotate([-90, 0, 0]) mirror([0, 1, 0]) linear_extrude(out + inn) children();
module on_side(xs, y, z, out, inn, s = 1)   // s = +1 right side (x = xs), -1 left side
    translate([xs + s*out, y, z]) rotate([0, -s*90, 0]) rotate([0, 0, s*90]) linear_extrude(out + inn) children();

// monochrome OLED face (white pixels only). w x h = visible area
module oled_face(x, z, yf, w, h, extra = 0) {
    ew = w*0.13; eh = h*0.42;
    pc("pix") {
        for (s = [-1, 1]) on_front(x + s*w*0.2, z + h*0.08, yf, 0.15, 0.05) rrect([ew, eh], ew*0.45);
        on_front(x, z - h*0.2, yf, 0.15, 0.05) difference() { circle(w*0.05); translate([-w, 0]) square(2*w); }
        if (extra == 1) {     // now-playing strip: progress bar + track dots
            on_front(x - w*0.38, z - h*0.4, yf, 0.15, 0.05) square([w*0.5, 0.7], center = false);
            on_front(x - w*0.38, z - h*0.4 - 0.3, yf, 0.12, 0.05) difference() { square([w*0.76, 1.3]); translate([0.3, 0.3]) square([w*0.76 - 0.6, 0.7]); }
        }
    }
}

// =====================================================================================
// J  "Pocket Walkman"  - hero = big coral dial (EC11 encoder: turn = volume, press = play)
// =====================================================================================
J_body = [0.95, 0.93, 0.88]; J_acc = [0.97, 0.43, 0.34];
module pocket_walkman() {
    W = 54; H = 94; D = 16; ys = -D/2;
    sz = 70; dz = 32;
    pc("J_body") difference() {
        translate([0, 0, H/2]) rr_box(W, H, D, 9, 4);
        // screen pocket
        color(c_glass) on_front(0, sz, ys, 1, 1.0) rrect([40, 25], 4);
        // dial pocket
        color(c_shadow) on_front(0, dz, ys, 1, 1.6) circle(19.2);
        // shell split line all round (front shell / back lid)
        color(c_shadow) translate([0, D/2 - 4.5, H/2]) rotate([90, 0, 0]) linear_extrude(0.5, center = true) difference() { rrect([W + 2, H + 2], 9); rrect([W - 1.0, H - 1.0], 8.5); }
        // top: 3.5 mm jack + lanyard slot; bottom: USB-C
        color(c_glass) translate([13, 0, H - 4]) cylinder(r = 3.1, h = 6);
        color(c_shadow) translate([-W/2 + 7, 0, H - 4]) rotate([90, 0, 0]) cylinder(r = 1.8, h = D + 2, center = true);
        color(c_glass) translate([0, 0, -1]) linear_extrude(5) rrect([9.4, 3.4], 1.6);
        // right side: rocker pocket; left side: switch slot + microSD
        color(c_shadow) on_side(W/2, 0, 62, 1, 0.8)  rrect([5.2, 17], 2.6);
        color(c_shadow) on_side(-W/2, 0, 62, 1, 1.0, -1) rrect([3.6, 12], 1.8);
        color(c_glass)  on_side(-W/2, 0, 30, 1, 2.0, -1) rrect([1.6, 12], 0.8);
        // engraved volume ticks around the dial
        for (a = [-130:20:130]) color(c_shadow) on_front(sin(a)*22.5, dz + cos(a)*22.5, ys, 1, 0.4) circle(a == 0 ? 0.9 : 0.5);
    }
    // glass + face
    pc("glass") on_front(0, sz, ys + 0.4, 0, 0.75) rrect([40.01, 25.01], 4);
    oled_face(0, sz + 1, ys + 0.35, 31, 17, 1);
    // coral dial with etched rings + cream centre button
    pc("J_acc") difference() {
        on_front(0, dz, ys - 1.0, 0, 2.9) circle(17.6);
        for (r = [8.4:2.2:16.2]) on_front(0, dz, ys - 1.0, 0.1, 0.35) difference() { circle(r + 0.35); circle(r); }
    }
    pc("J_body") translate([0, ys - 1.0, dz]) rotate([90, 0, 0]) scale([1, 1, 0.22]) sphere(6.6);
    pc("J_acc") on_front(0.4, dz, ys - 2.3, 0.3, 0.3) polygon([[-1.3, -1.8], [-1.3, 1.8], [1.8, 0]]);
    // side rocker with nubs (prev / next), accent
    pc("J_acc") on_side(W/2, 0, 62, 1.0, 0.8) rrect([4.4, 16], 2.2);
    pc("J_acc") for (k = [-2:2]) translate([W/2 + 1.0, 0, 62 + k*3]) sphere(0.8, $fn = 16);
    // slide switch knob + coral "ON" flag
    pc("J_body") translate([-W/2 - 0.6, 0, 64]) cube([2, 2.4, 4.4], center = true);
    pc("J_acc")  translate([-W/2 + 0.1, 0, 59.6]) cube([0.6, 2.6, 3.4], center = true);
    // back clip
    pc("J_body") translate([0, D/2 + 1.6, 52]) rr_box(18, 46, 2.4, 4, 1.1);
    pc("J_body") translate([0, D/2 + 0.8, 74]) rr_box(18, 6, 1.8, 2, 0.8);
    pc("shadow") translate([0, D/2 + 0.4, 22]) rotate([90, 0, 0]) mirror([1, 0, 0]) linear_extrude(0.6)
        text("lilmate", size = 3.2, font = "DejaVu Sans:style=Bold", halign = "center", valign = "center");
}

// =====================================================================================
// K  "Mochi Pebble"  - hero = the pebble form itself; pat its head (TTP223) to play / pause
// =====================================================================================
K_body = [0.98, 0.95, 0.93]; K_acc = [0.95, 0.56, 0.62];
module pebble_shape() hull() {          // soft mochi pillow: wide bottom, rounder top, flat-ish front
    translate([0, 0, 14]) rr_box(66, 28, 34, 13, 12);
    translate([0, 0, 38]) rr_box(54, 36, 34, 17, 12);
}
module mochi_pebble() {
    yf = -17; sz = 33; pz = 14.6;
    // accent bottom lid (battery cover) - the mochi sits on it
    pc("K_acc") intersection() { pebble_shape(); translate([0, 0, -1]) cylinder(r = 50, h = 5); }
    pc("K_body") difference() {
        intersection() { pebble_shape(); translate([0, 0, 4.3]) cylinder(r = 50, h = 60); }
        // window pocket
        color(c_glass) on_front(0, sz, yf, 1, 1.2) rrect([33, 22], 7.5);
        // control pill pocket below the face
        color(c_shadow) on_front(0, pz, yf, 1, 1.0) rrect([22, 5.6], 2.8);
        // back: USB-C, 3.5 mm jack, microSD
        color(c_glass) translate([0, 17, 10]) rotate([90, 0, 0]) linear_extrude(6, center = true) rrect([9.4, 3.4], 1.6);
        color(c_glass) translate([13, 14, 24]) rotate([90, 0, 0]) cylinder(r = 3.1, h = 14, center = true);
        color(c_glass) translate([-13, 14, 24]) rotate([90, 0, 0]) linear_extrude(14, center = true) rrect([12, 1.8], 0.9);
        // engraved touch ring on the crown = "pat here"
        color(c_shadow) translate([0, 0, 56]) difference() { cylinder(r = 7.4, h = 2, center = true); cylinder(r = 6.8, h = 3, center = true); }
    }
    // ear nubs, same colour (only a hint)
    pc("K_body") for (s = [-1, 1]) translate([s*17, 0, 52.5]) rotate([0, s*-22, 0]) scale([6.4, 5.6, 5]) sphere(1);
    // glass + face
    pc("glass") on_front(0, sz, yf + 0.5, 0, 0.8) rrect([33.01, 22.01], 7.5);
    oled_face(0, sz, yf + 0.45, 27, 16);
    // prev / play / next: three soft beads in one accent pill
    pc("K_acc") on_front(0, pz, yf + 1.0, 0.3, 0.2) rrect([21, 4.6], 2.3);
    pc("K_acc") for (k = [-1:1]) translate([k*6.6, yf - 0.3, pz]) scale([1, 0.55, 1]) sphere(k == 0 ? 2.3 : 1.8, $fn = 32);
}

// =====================================================================================
// L  "Tiny Retro PC"  - hero = 4 chunky keycaps; microSD hides in the "floppy" slot
// =====================================================================================
L_body = [0.91, 0.87, 0.78]; L_key = [0.74, 0.71, 0.66]; L_acc = [0.98, 0.52, 0.22];
module keycap(x, y, z, tilt, col) translate([x, y, z]) rotate([tilt, 0, 0]) {
    pc(col) difference() {
        hull() { linear_extrude(0.1) rrect([12, 12], 2.4); translate([0, 0, 5]) linear_extrude(0.1) rrect([9.8, 9.8], 2); }
        translate([0, 0, 5.4 + 30]) sphere(30.4, $fn = 120);      // dished top
    }
    pc("glass") translate([0, 0, 4.85]) linear_extrude(0.5) children();
}
module retro_pc() {
    MW = 52; MH = 46; MD = 26; mz = 14 + MH/2; my = 2;
    // keyboard base: slope rises ~19 deg toward the monitor
    ky = -22; kz = 10.5; kt = 19.3;
    pc("L_body") difference() {
        hull() {
            translate([0, -30.5, 3.5]) rr_box(60, 7, 3, 2, 1.4);
            translate([0, 5, 7]) rr_box(60, 14, 34, 3, 2.6);
        }
        for (i = [0:3]) color(c_shadow) translate([-21 + i*14, ky, kz]) rotate([kt, 0, 0]) cube([13.2, 13.2, 4], center = true);
    }
    keycap(-21, ky, kz, kt, "L_key") polygon([[1, -1.6], [1, 1.6], [-1.4, 0]]);
    keycap( -7, ky, kz, kt, "L_acc") polygon([[-1.2, -1.8], [-1.2, 1.8], [1.8, 0]]);
    keycap(  7, ky, kz, kt, "L_key") polygon([[-1, -1.6], [-1, 1.6], [1.4, 0]]);
    keycap( 21, ky, kz, kt, "L_key") { translate([-1.1, 0.4]) circle(0.55, $fn = 12); translate([1.1, 0.4]) circle(0.55, $fn = 12); translate([0, -0.9]) difference() { circle(1.2, $fn = 24); translate([-2, 0]) square(4); } }
    // monitor: front box + tapered CRT back
    pc("L_body") difference() {
        union() {
            translate([0, my, mz]) rr_box(MW, MH, MD, 5, 2.4);
            hull() { translate([0, my + MD/2 - 3, mz]) rr_box(MW - 4, MH - 4, 2, 4, 0.9); translate([0, my + MD/2 + 11, mz + 2]) rr_box(MW - 18, MH - 16, 2, 4, 0.9); }
        }
        // deep bezel step + screen recess
        color([0.80, 0.76, 0.67]) on_front(0, mz + 4, my - MD/2, 1, 2.2) rrect([44, 32], 4.4);
        // floppy slot = microSD
        color(c_shadow) on_front(-4, mz - 17, my - MD/2, 1, 0.8) rrect([30, 6], 1.5);
        color(c_glass) on_front(-8, mz - 17, my - MD/2, 1, 5) rrect([16, 1.8], 0.9);
        // side vents (left)
        for (k = [0:4]) color(c_shadow) translate([-MW/2, my + 2, mz + 10 - k*4.2]) cube([2.4, 14, 1.6], center = true);
        // back: USB-C + 3.5 mm jack
        color(c_glass) translate([-7, my + MD/2 + 11, mz]) rotate([90, 0, 0]) linear_extrude(6, center = true) rrect([9.4, 3.4], 1.6);
        color(c_glass) translate([7, my + MD/2 + 11, mz]) rotate([90, 0, 0]) cylinder(r = 3.1, h = 6, center = true);
    }
    // slightly domed CRT glass + face
    pc("glass") intersection() {
        translate([0, my - MD/2 + 2.2, mz + 4]) scale([1, 0.06, 1]) sphere(40);
        on_front(0, mz + 4, my - MD/2 + 2.2, 3, 0.1) rrect([40, 28], 4);
    }
    oled_face(0, mz + 4.5, my - MD/2 - 0.3, 32, 18, 1);
    // floppy eject button + power LED in accent
    pc("L_acc") on_front(5.5, mz - 17, my - MD/2 + 0.8, 0.6, 0.2) rrect([4.4, 2.4], 0.9);
    pc("L_acc") translate([19, my - MD/2 - 0.1, mz - 17]) rotate([90, 0, 0]) cylinder(r = 1.1, h = 0.6, $fn = 24);
    // volume knob on the right side (accent, knurled)
    pc("L_acc") translate([MW/2 + 1.6, my - 4, mz - 8]) rotate([0, 90, 0]) difference() {
        cylinder(r = 6.2, h = 4, center = true);
        for (a = [0:15:359]) rotate(a) translate([6.4, 0, 0]) cylinder(r = 0.6, h = 5, center = true, $fn = 8);
    }
}

function colv(n) = n == "J_body" ? J_body : n == "J_acc" ? J_acc : n == "K_body" ? K_body : n == "K_acc" ? K_acc
                 : n == "L_body" ? L_body : n == "L_key" ? L_key : n == "L_acc" ? L_acc
                 : n == "glass" ? c_glass : n == "pix" ? c_pix : c_shadow;
module pc(n) { if (only == "") color(colv(n)) children(); else if (only == n) children(); }

module show(m) {
    if (m == 10) pocket_walkman(); else if (m == 11) mochi_pebble(); else retro_pc();
}
if (design == 0) { translate([-75, 0, 0]) show(10); show(11); translate([75, 0, 0]) show(12); }
else rotate([0, 0, view == 1 ? 180 : 0]) show(design);
