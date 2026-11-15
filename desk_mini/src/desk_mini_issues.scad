// desk_mini - ISSUE VIEW (original parts + dummies that make the problems visible)
//  A  display tray (obj_1) + dummy 0.96" OLED module  -> RED = empty slack around the module (loose fit)
//  B  back plate (obj_4)  + RED pins marking the 2 screw holes that the self-lock will replace
//  C  cover shell (obj_3) + NEW buzzer holder (ring) + dummy buzzer
// All numbers are mm. Original STLs are untouched; only the buzzer ring is new.
O = "/home/sudarsan/Documents/crazy_projects/lilmate_3D_design/desk_mini/reference/original/";
$fn = 64;
part = "all";   // all | shell_only

// --- display module (ASSUMED std 0.96" I2C OLED PCB, confirm with calipers)
mod = [27.3, 27.8, 4.0];
pocket = [30.0, 30.4];
tray_floor = 0.8;

// --- buzzer (user: 11 mm dia -> typed "1.1"; +0.7 clearance, 3 mm tall)
bz_d = 11; bz_clear = 0.7; bz_h = 3; ring_wall = 1.2; plate_t = 2;
bz_c = [362.9, -108.95];                 // centre of the 2x3 sound-hole grid (shell STL coords)
wire_gap = 4;                            // wire notch in the ring, facing -x

module shell_orig() import(str(O, "obj_3_total final.stl_8.stl"));
module buzzer_ring() translate([bz_c[0], bz_c[1], plate_t - 0.01])
  difference() {
    cylinder(d = bz_d + bz_clear + 2*ring_wall, h = bz_h + 0.01);
    translate([0,0,-0.1]) cylinder(d = bz_d + bz_clear, h = bz_h + 0.3);
    translate([-(bz_d+4), -wire_gap/2, 0]) cube([bz_d, wire_gap, bz_h + 1]);
  }
module shell_new() union() { shell_orig(); buzzer_ring(); }

if (part == "shell_only") shell_new();
else {
  // A: tray
  translate([-124.25, -72.8, 0]) {
    color("lightgray") import(str(O, "obj_1_total final.stl_2.stl"));
    c = [124.25 + 17, 72.8 + 17.2];
    color("royalblue") translate([c[0]-mod[0]/2, c[1]-mod[1]/2, tray_floor]) cube(mod);
    color("red") translate([0,0,tray_floor]) difference() {
      translate([c[0]-pocket[0]/2, c[1]-pocket[1]/2, 0]) cube([pocket[0], pocket[1], 0.6]);
      translate([c[0]-mod[0]/2, c[1]-mod[1]/2, -1]) cube([mod[0], mod[1], 3]);
    }
  }
  // B: back plate with screw markers
  translate([50, 0, 0]) translate([-126.75, 160.25, 0]) {
    color("lightgray") import(str(O, "obj_4_total final.stl_5.stl"));
    for (y = [-130.3, -156.3]) color("red") translate([132.7, y, -2]) cylinder(d = 3, h = 9);
  }
  // C: shell with buzzer holder
  translate([100, 0, 0]) translate([-333.41, 127.75, 0]) {
    color("lightgray") shell_new();
    color("orange") translate([bz_c[0], bz_c[1], plate_t]) cylinder(d = bz_d, h = bz_h);
  }
}
