// printed part vs printed part (assembled): only contacts / intended snaps allowed
include <../src/main.scad>
pa = 0; pb2 = 1;
module p(j) {
    if (j == 0) base(); if (j == 1) deck(); if (j == 2) keyplate(); if (j == 3) keycaps();
    if (j == 4) shell(); if (j == 5) back(); if (j == 6) knob();
}
intersection() { p(pa); p(pb2); }
