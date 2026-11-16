// TEST COUPON (does NOT change src/main.scad): USB-C port area only, v10 (TP4056 flush, niche 7.25 deep).
//   cp = "front" : 10 mm of the body stack bay (TP4056 + ESP32 slots, battery floor) at the seam, to hold the real board
//   cp = "back"  : the lid chunk around the USB-C port (niche, guide plate, USB hole, tunnel tube)
// Print both upright. Slide the TP4056 into the front chunk, press the lid chunk on, plug the cable in.
cp = "back";   // front | back (set with -D cp=...; also pass -D part=\"none\" so main.scad outputs nothing)
include <../3d/src/main.scad>
box_x = 34;  box_z = 26;
module cut(y0, y1) translate([-box_x/2, y0, 0]) cube([box_x, y1 - y0, box_z]);
if (cp == "front") intersection() { front_shell(); cut(split_y - 10, split_y + 4); }
if (cp == "back")   intersection() { back_shell();  cut(split_y - 1, 32); }
