// TEST COUPON (src/main.scad default is unchanged): display (OLED) area of the front shell.
//   dv = "A": current design   dv = "B": 45 deg wedge under the holder floor removed   dv = "C": FLAT top above the OLED slot (no 45 deg peak / slash lines)
dv = "A";
include <../3d/src/main.scad>
bay_wedge = (dv != "B");
bay_peak  = (dv != "C");
module dcut() translate([-26, -30, 42]) cube([52, 24, 50]);
intersection() { front_shell(); dcut(); }
