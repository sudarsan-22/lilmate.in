// TEST COUPON (src/main.scad default is unchanged): display (OLED) area of the front shell.
//   dv = "A": current design        dv = "B": flat holder floor, the 45 deg wedge under it removed (bay_wedge = false)
dv = "A";
include <../3d/src/main.scad>
bay_wedge = (dv == "A");
module dcut() translate([-26, -30, 42]) cube([52, 24, 50]);
intersection() { front_shell(); dcut(); }
