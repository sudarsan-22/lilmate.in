// TEST COUPON (does NOT change src/main.scad): stack bay of the front shell with BOTH board slots.
// variant = "new": (1) bottom (TP4056) stopper moved to the SAME depth as the top (ESP32) one: 22 mm in from the opening
//                  (the 27 mm board then sticks out 5 mm past the opening into the lid)
//                  (2) top (ESP32) slot gets the SAME full-length lip rail over both board edges as the bottom slot
// variant = "now": current design, for comparison
include <../3d/src/main.scad>
variant = "new";
cut = [32, 34, 28];                       // x (centred), y from y_cut0, z from 0
y_cut0 = -18;
stop_depth = 22;                          // distance of the stopper face from the opening (y = split_y)
module board_slot(sx, bw, bt, z0, ya0, yb, lip_reach) {
    ya = (variant == "new" && bw == tp_pcb[1]) ? split_y - stop_depth : ya0;     // bottom (TP4056) stopper -> same depth as the top
    lr = (variant == "new" && bw == esp_pcb[1]) ? 1.0 : lip_reach;          // top slot now has the lip too
    xw = sx * stack_w/2; xs = sx * (bw/2 + slot_clr); zt = bt + slot_zclr;
    shelf(sx, bw, ya - stop_len, yb, z0);
    translate([min(xw, xs), ya - stop_len, z0 - eps]) cube([abs(xw - xs), yb - ya + stop_len, zt + (lr > 0 ? 1.0 : 0) + eps]);
    if (lr > 0) let(xl = sx * (bw/2 - lr))
        translate([min(xw, xl), ya - stop_len, z0 + zt]) cube([abs(xw - xl), yb - ya + stop_len, 1.0]);
    p = stack_w/2 - bw/2 + stop_reach;
    translate([0, ya, 0]) rotate([90, 0, 0]) linear_extrude(stop_len)
        polygon([[xw, z0 - p], [xw - sx*p, z0], [xw - sx*p, z0 + bt + 1.0], [xw, z0 + bt + 1.0]]);
}
echo(str("variant ", variant, ": TP4056 stopper face y ", variant == "new" ? split_y - stop_depth : tp_y0, " | ESP32 stopper face y ", esp_y0, " | stop_depth ", stop_depth));
tp_ya = variant == "new" ? split_y - stop_depth : tp_y0;
module coupon() intersection() { front_shell(); translate([-cut.x/2, y_cut0, 0]) cube(cut); }
if (part == "none") coupon();
if (part == "chk_esp") intersection() { coupon(); components(2); }   // must be empty
if (part == "chk_tp")  intersection() { coupon(); translate([-tp_pcb[1]/2, tp_ya, tp_z0]) cube([tp_pcb[1], tp_pcb[0], tp_pcb[2]]); }   // must be empty
