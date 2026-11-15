// TEST COUPON (does NOT change src/main.scad): stack bay of the front shell with BOTH board slots,
// where the bottom (TP4056) stopper is made the SAME SIZE as the top (ESP32) stopper.
// variant = "new"  -> bottom stopper copies the top one (reach 3.75, height 5.75, front-to-back 2)
// variant = "now"  -> current design (for side-by-side comparison)
include <../src/main.scad>
variant = "new";
cut = [32, 34, 28];                       // x (centred), y from y_cut0, z from 0
y_cut0 = -18;
module board_slot(sx, bw, bt, z0, ya, yb, lip_reach) {
    xw = sx * stack_w/2; xs = sx * (bw/2 + slot_clr); zt = bt + slot_zclr;
    shelf(sx, bw, ya - stop_len, yb, z0);
    translate([min(xw, xs), ya - stop_len, z0 - eps]) cube([abs(xw - xs), yb - ya + stop_len, zt + (lip_reach > 0 ? 1.0 : 0) + eps]);
    if (lip_reach > 0) let(xl = sx * (bw/2 - lip_reach))
        translate([min(xw, xl), ya - stop_len, z0 + zt]) cube([abs(xw - xl), yb - ya + stop_len, 1.0]);
    p = variant == "new" ? stack_w/2 - esp_pcb[1]/2 + stop_reach            // = 3.75 for both slots
                         : stack_w/2 - bw/2 + stop_reach;
    translate([0, ya, 0]) rotate([90, 0, 0]) linear_extrude(stop_len)
        polygon([[xw, z0 - p], [xw - sx*p, z0], [xw - sx*p, z0 + bt + 1.0], [xw, z0 + bt + 1.0]]);
}
echo(str("variant ", variant, ": TP4056 stopper reach ", variant == "new" ? stack_w/2 - esp_pcb[1]/2 + stop_reach : stack_w/2 - tp_pcb[1]/2 + stop_reach,
         ", ESP32 stopper reach ", stack_w/2 - esp_pcb[1]/2 + stop_reach));
if (part == "none")
    intersection() { front_shell(); translate([-cut.x/2, y_cut0, 0]) cube(cut); }
