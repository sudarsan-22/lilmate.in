// desk_mini v2 - edits on the original STLs (originals untouched)
//  shell : buzzer holder moved 10 mm (sound holes moved with it), full snug ring, no wire notch
//  plate : board opening 2 mm wider (18 -> 20), whole U-wall and USB notch stretch with it
//  body  : obj_7 brought into the project unchanged (USB-port depth change pending)
O = "/home/sudarsan/Documents/crazy_projects/lilmate_3D_design/desk_mini/reference/original/";
$fn = 72;
part = "all";   // all | shell | plate | body

// ---------- shell (STL coords) ----------
plate_t = 2;
move_x  = -10;                       // "up" in the slicer view = away from the USB slot = -x
holes_x = [359.9, 363.9];  holes_y = [-102.4, -108.8, -115.1];  hole_d = 2;
bz_c    = [362.9 + move_x, -108.95];
bz_d = 11.5; bz_gap = 0.2; bz_h = 3;           // buzzer 11.5, pocket 11.7 (0.2 total gap)
ring_od = 13.5;                                  // holder outer diameter (user: 1.35 cm)
ring_wall = (ring_od - (bz_d + bz_gap)) / 2;     // = 0.9

module shell_v2() {
  difference() {
    union() {
      import(str(O, "obj_3_total final.stl_8.stl"));
      // plug the six original sound holes
      for (x = holes_x, y = holes_y) translate([x, y, 0]) cylinder(d = hole_d + 0.4, h = plate_t);
      // full ring, no gap
      translate([bz_c[0], bz_c[1], plate_t - 0.01])
        cylinder(d = bz_d + bz_gap + 2*ring_wall, h = bz_h + 0.01);
    }
    // hollow pocket for the buzzer (sits on the plate)
    translate([bz_c[0], bz_c[1], plate_t]) cylinder(d = bz_d + bz_gap, h = bz_h + 1);
    // new sound holes: same 2x3 grid, row pitch tightened (6.35 -> 3.2) so all six sit INSIDE the buzzer pocket
    for (dx = [-2, 2], dy = [-3.2, 0, 3.2]) translate([bz_c[0] + dx, bz_c[1] + dy, -1]) cylinder(d = hole_d, h = plate_t + 1);
  }
}

// ---------- back plate (local coords: x 0..29, y 0..34) ----------
widen = 2;  ymid = 17;
// cut lines kept clear of the two 3 mm screw holes (y 2.45..5.45 and 28.45..31.45)
ylo = 5.6; yhi = 28.4;
module plate_src() translate([-126.75, 160.25, 0]) import(str(O, "obj_4_total final.stl_5.stl"));
module plate_v2() {
  h = widen / 2;
  difference() {
    union() {
      intersection() { plate_src(); translate([-1, -1, -1]) cube([31, ylo + 1, 20]); }              // fixed bottom edge
      intersection() { plate_src(); translate([-1, yhi, -1]) cube([31, 10, 20]); }                  // fixed top edge
      translate([0, -h, 0]) intersection() { plate_src(); translate([-1, ylo, -1]) cube([31, ymid - ylo, 20]); }   // lower half moved down
      translate([0,  h, 0]) intersection() { plate_src(); translate([-1, ymid, -1]) cube([31, yhi - ymid, 20]); } // upper half moved up
      // fill the gap with the cross-section at the middle
      translate([0, ymid - h, 0]) rotate([-90, 0, 0]) linear_extrude(widen)
        projection(cut = true) translate([0, 0, -ymid]) rotate([90, 0, 0]) plate_src();
    }
    // original screw holes stay where they were (self-lock replaces them later)
    for (y = [3.95, 29.95]) translate([5.95, y, -1]) cylinder(d = 3, h = 10);
    // snap-clip catch: 4.4 mm counterbore from z=0.5 up (leaves a 0.5 mm ledge ring around the 3 mm neck)
    for (y = [3.95, 29.95]) translate([5.95, y, clip_ledge]) cylinder(d = 4.4, h = 5);
  }
}

// ---------- main body obj_7 : remove the two centre notches at the face rim (top + bottom) ----------
yc = -145.25; nh = 3.0;                 // notch centre (body mid-width) and half width incl. margin
module body_orig() import(str(O, "obj_7_total final.stl_7.stl"));
module side_slice(z0, z1, lo) intersection() {
  body_orig();
  translate([330, lo ? yc - nh - 4 : yc + nh, z0]) cube([60, 4, z1 - z0]);
}
module notch_fill(z0, z1) intersection() {
  hull() { side_slice(z0, z1, true); side_slice(z0, z1, false); }
  translate([330, yc - nh, z0 - 0.01]) cube([60, 2*nh, z1 - z0 + 0.02]);
}
// ---- screwless mounting: two split snap pins replace the M2 pilot holes (local body x=6.0, y=4.05 / 30.05)
base_top = 6.5;            // body base top face (plate sits here)
clip_ledge = 0.5;          // plate: thin neck ring under the counterbore
well_d = 4.2; well_z = 2.0;                       // relief well around each pin so the prongs can flex
pin_d = 2.6; head_d = 3.5; slit = 0.7;
head_z0 = base_top + clip_ledge + 0.05;            // barb shoulder, just above the plate's neck ledge
head_z1 = head_z0 + 0.45; tip_z = base_top + 1.5 - 0.05;   // tip stays below the plate top face (flush)
pins = [[341.1 + 5.95, -162.25 + 3.95], [341.1 + 5.95, -162.25 + 29.95]];  // = plate hole centres
module snap_pin() difference() {
  union() {
    translate([0,0,well_z - 0.01]) cylinder(d = pin_d, h = head_z0 - well_z + 0.01);
    translate([0,0,head_z0]) cylinder(d = head_d, h = head_z1 - head_z0);
    translate([0,0,head_z1 - 0.001]) cylinder(d1 = head_d, d2 = pin_d - 0.4, h = tip_z - head_z1);
  }
  translate([-5, -slit/2, well_z + 0.4]) cube([10, slit, 10]);
}
// body side dimples for the cover's snap nubs (cover fit: x_c -> x_b = 724.0 - x_c; body z = cover z - 2)
module body_v2() difference() {
  union() {
    difference() {
      union() { body_orig(); notch_fill(42.3, 45.2); notch_fill(13.4, 14.9); }
      for (c = pins) translate([c[0], c[1], well_z]) cylinder(d = well_d, h = 20);
    }
    for (c = pins) translate([c[0], c[1], 0]) snap_pin();
  }
}

// ---------- tray obj_1 (local coords 0..34 x 0..34.4) : fill the two 4.8 mm notches ----------
module tray_v2() translate([-124.25, -72.8, 0]) difference() {
  union() {
    import(str(O, "obj_1_total final.stl_2.stl"));
    for (y = [72.8 - 0.01, 72.8 + 32.4]) translate([124.25 + 13.6, y, 0.7]) cube([6.8, 2.01, 5.8]);   // wide enough to swallow the rounded notch ends
  }
  // remove the 6 x 6 square pad in the middle of the tray floor (floor top z=0.7, pad top ~1.7)
  translate([124.25 + 13.9, 72.8 + 14.1, 0.7]) cube([6.2, 6.2, 1.5]);
}

// ---------- display cover / bezel obj_6 (local 0..30 x 0..30.4) : fill notches, add crush ribs ----------
rib = 0.3;
module bezel_v2() translate([-96.25, 156.65, 0]) union() {
  import(str(O, "obj_6_total final.stl_11.stl"));
  // fill the 4.8 mm notches in the two y walls (walls are 1.5 thick)
  for (y = [-156.65 - 0.01, -156.65 + 28.9]) translate([96.25 + 11.6, y, 1.0]) cube([6.8, 1.52, 5.0]);
  // 8 crush ribs inside the 27.0 x 27.4 cavity (open end z=6), tapered at the open end for easy insertion
  for (sx = [0, 1], yy = [7.5, 22.9]) {
    x0 = 96.25 + (sx ? 28.5 - rib : 1.5);
    hull() {
      translate([x0, -156.65 + yy - 2.5, 2.6]) cube([rib, 5, 2.4]);
      translate([x0 + (sx ? rib : 0), -156.65 + yy - 2.5, 5.99]) cube([0.01, 5, 0.01]);
    }
  }
  for (sy = [0, 1], xx = [6.5, 23.5]) {
    y0 = -156.65 + (sy ? 28.9 - rib : 1.5);
    hull() {
      translate([96.25 + xx - 2.5, y0, 2.6]) cube([5, rib, 2.4]);
      translate([96.25 + xx - 2.5, y0 + (sy ? rib : 0), 5.99]) cube([5, 0.01, 0.01]);
    }
  }
}

module body_src() translate([-341.1, 162.25, 0]) body_v2();

if (part == "shell") shell_v2();
else if (part == "plate") plate_v2();
else if (part == "body") body_v2();
else if (part == "tray") tray_v2();
else if (part == "bezel") bezel_v2();
else {
  color("lightgray") body_src();
  translate([55, 0, 0])  color("lightgray") plate_v2();
  translate([100, 0, 0]) translate([-333.41, 127.75, 0]) color("lightgray") shell_v2();
  // tray (obj_1) removed from the project on request
  translate([0, -50, 0]) color("lightgray") bezel_v2();
}
