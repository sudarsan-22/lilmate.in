// export helper for the Blender review renders: one solid per (part, material)
include <../src/main.scad>
sel = "base"; e = 0; cut = 0;          // e = explode, cut = 1 -> keep only x < 0 of printed parts
module cutter() if (cut == 1) xbox(-200, 0, -200, 200, -200, 200); else xbox(-200, 200, -200, 200, -200, 200);
module pp(n) intersection() { cutter(); children(); }
if (sel == "base")     pp() base();
if (sel == "deck")     pp() translate([0, 0, e*0.6]) deck();
if (sel == "keyplate") pp() translate([0, -e*0.6, e*0.6]) keyplate();
if (sel == "keys_grey")   pp() translate([0, -e*0.6, e*1.3]) for (i = [0, 2, 3]) kframe() translate([key_u[i], kv, 0]) keycap_local(i);
if (sel == "keys_orange") pp() translate([0, -e*0.6, e*1.3]) kframe() translate([key_u[1], kv, 0]) keycap_local(1);
if (sel == "shell")    pp() translate([0, 0, e*1.5]) shell();
if (sel == "back")     pp() translate([0, e*1.0, e*1.5]) back();
if (sel == "knob")     translate([e*0.8, 0, e*1.5]) knob();
if (sel == "pcb_blue")  translate([0, 0, e*1.5]) { ftilt() xbox(-oled_pcb[0]/2, oled_pcb[0]/2, pad_t, pad_t + oled_pcb[2], mz0 + oled_z0, mz0 + oled_z0 + oled_pcb[1]); xbox(yx_x0, yx_x0 + yx_pcb[0], yx_y0, yx_y0 + yx_pcb[1], mz0 + yx_z0, mz0 + yx_top); }
if (sel == "glass")     translate([0, 0, e*1.5]) ftilt() on_y(glass_y0, pad_t) translate([0, oled_zc]) square([oled_glass[0], oled_glass[1]], center = true);
if (sel == "pix")       translate([0, 0, e*1.5]) ftilt() for (s = [-1, 1]) on_y(glass_y0 - 0.05, glass_y0 + 0.1) translate([s*5.5, oled_zc + 1]) rrect([3.6, 7.5], 1.6);
if (sel == "metal")     { translate([0, 0, e*1.5]) { e_ec11(); xbox(sd_x - yx_sd[0]/2, sd_x + yx_sd[0]/2, yx_y0, yx_y0 + yx_sd[1], mz0 + yx_z0 - yx_sd[2], mz0 + yx_z0); }
                          translate([0, e*1.0, e*1.5]) e_switch(); e_battery(); }
if (sel == "black")     { translate([0, 0, e*1.5]) { translate([jack_p[0], jack_p[1], jack_p[2]]) rotate([0, 90, 0]) cylinder(d = yx_jack_d, h = 3);
                            xbox(yx_x0 - yx_jack_over + 3, yx_x0 - yx_jack_over + yx_jack_len, jack_p[1] - 3.2, jack_p[1] + 3.2, mz0 + yx_top, mz0 + yx_top + yx_jack_h);
                            xbox(yx_x0 + 14, yx_x0 + 26, yx_y0 + 6, yx_y0 + 14, mz0 + yx_top, mz0 + yx_top + 1.6); }
                          translate([0, e*1.0, e*1.5]) e_board(esp_pcb, esp_z, "x");
                          translate([0, -e*0.6, e*0.6]) kframe() for (u = key_u) translate([u, kv, pb_top]) { translate([-tact[0]/2, -tact[0]/2, 0]) cube([tact[0], tact[0], tact[1]]); cylinder(d = 3.5, h = tact[2]); } }
if (sel == "pcb_tp")    translate([0, e*1.0, e*1.5]) e_board(tp_pcb, tp_z, "x");
if (sel == "pcb_green") translate([0, -e*0.6, e*0.6]) kframe() xbox(-pb[0]/2, pb[0]/2, kv - pb[1]/2, kv + pb[1]/2, pb_top - pb[2], pb_top);
