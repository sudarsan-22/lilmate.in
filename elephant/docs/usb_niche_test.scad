// TEST COUPON (src/main.scad is unchanged): USB-C niche in the lid made DEEPER by moving the plug niche floor + guide plate inward.
// The TP4056 board, its stopper and every housing stay exactly as they are; only port_y_mold moves (dd mm deeper than now).
//   cp = "front": 10 mm of the body stack bay (to hold the real TP4056)   cp = "back": the lid chunk around the port, dd = extra depth
cp = "back"; dd = 0;
include <../3d/src/main.scad>
port_y_mold = usb_face_y + 5.6 - dd;
box_x = 34;  box_z = 26;
module cut(y0, y1) translate([-box_x/2, y0, 0]) cube([box_x, y1 - y0, box_z]);
if (cp == "front") intersection() { front_shell(); cut(split_y - 10, split_y + 4); }
if (cp == "back")  intersection() { back_shell();  cut(split_y - 1, 32); }
