// per-component fit check: each intersection must be EMPTY
use <../src/main.scad>
include <../src/main.scad>
ci = 0;
module e(i) {
    if (i == 0) e_oled(); if (i == 1) e_yx(); if (i == 2) e_ec11();
    if (i == 3) e_board(tp_pcb, tp_z, "red"); if (i == 4) e_board(esp_pcb, esp_z, "red");
    if (i == 5) e_switch(); if (i == 6) e_battery(); if (i == 7) e_keys();
}
module p(j) {
    if (j == 0) base(); if (j == 1) deck(); if (j == 2) keyplate(); if (j == 3) keycaps();
    if (j == 4) shell(); if (j == 5) back(); if (j == 6) knob();
}
pj = 0;
intersection() { e(ci); p(pj); }
