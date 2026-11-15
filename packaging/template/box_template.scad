// Cutting + scoring template for the lilmate tuck-top box (hand cutting with a knife, see packaging/README.md)
// One frame (tile) per box panel, joined across a 1.4 mm gap by bow-tie keys. The gap IS the score line between panels.
// Outer edges of every tile are the knife guides (exact box outline); slots inside a tile are score guides for a blunt stylus.
// Coordinates: flat dieline, x right, y up, lid row on top, same layout as packaging/<product>/<product>_box.png
// Render a part:  openscad -D 'part="lid"' -D Lo=98 -D Wo=98 -D Ho=71 -o lid.stl box_template.scad
part = "assembly";   // assembly | assembly_keys | front | sideR | back | sideL | lid | base | key | check
Lo = 98; Wo = 98; Ho = 71;     // box OUTSIDE size (x length, y width, z height)
thick = 3;      // template thickness = knife guide height
rim   = 15;     // frame width
gap   = 1.4;    // score slot / gap between tiles (blunt stylus)
G  = 15;        // glue flap
TK = 18;        // tuck flap
FL = min(20, Wo/3);   // dust flap height
slot_end = 6;   // score slots stop this far from the edge (frame stays in one piece)
tick = 2.5;     // edge notch that shows where the score line continues
Lk = 8; hw = 11; nw = 5.5; kclr = 0.15; kt = thick - 0.4;   // bow-tie key: half length, head width, neck width, clearance, thickness
$fn = 48;

X1 = G; X2 = G + Lo; X3 = X2 + Wo; X4 = X3 + Lo; X5 = X4 + Wo;
yb = TK + Wo; yt = yb + Ho; ylid = yt + Wo;          // body bottom, body top, lid top
h2 = gap/2;

module R(x0, y0, x1, y1) translate([x0, y0]) square([x1 - x0, y1 - y0]);
module slot(x0, y0, x1, y1) { // thin score slot with 'tick' notches continuing to the edge
    R(x0, y0, x1, y1);
}
module window(x0, y0, x1, y1) if (x1 - x0 - 2*rim > 12 && y1 - y0 - 2*rim > 12) R(x0 + rim, y0 + rim, x1 - rim, y1 - rim);
// ticks: small notches at both ends of a score line (horizontal line at y, from xa to xb tile edges)
module hline(y, xa, xb) { R(xa + slot_end, y - gap/2, xb - slot_end, y + gap/2); for (x = [xa, xb - tick]) R(x, y - gap/2, x + tick, y + gap/2); }
module vline(x, ya, yb_) { R(x - gap/2, ya + slot_end, x + gap/2, yb_ - slot_end); for (y = [ya, yb_ - tick]) R(x - gap/2, y, x + gap/2, y + tick); }

module bowtie(c = 0) offset(delta = c) polygon([[-Lk, -hw/2], [0, -nw/2], [Lk, -hw/2], [Lk, hw/2], [0, nw/2], [-Lk, hw/2]]);
// pockets on vertical joint x = xj (key axis along x), at heights ys
module vkeys(xj, ys) for (y = ys) translate([xj, y]) bowtie(kclr);
module hkeys(yj, xs) for (x = xs) translate([x, yj]) rotate(90) bowtie(kclr);
function frac(a, b, f) = a + (b - a)*f;

module tile2d(p) difference() {
    union() {
      if (p == "front") {
        intersection() { R(X1, yb, X2 - h2, yt); }
        polygon([[3, yb + 8], [X1, yb], [X1, yt], [3, yt - 8]]);
      }
      if (p == "sideR" || p == "sideL") {
        xa = p == "sideR" ? X2 + h2 : X4 + h2;  xb = p == "sideR" ? X3 - h2 : X5;
        R(xa, yb, xb, yt);
        intersection() { R(xa, yt, xb, yt + FL); polygon([[xa - 1, yt], [xb + 1, yt], [xb - 4 + (p == "sideL" ? 0 : 0), yt + FL], [xa + 4, yt + FL]]); }
        intersection() { R(xa, yb - FL, xb, yb); polygon([[xa - 1, yb], [xb + 1, yb], [xb - 4, yb - FL], [xa + 4, yb - FL]]); }
      }
      if (p == "back") R(X3 + h2, yb + h2, X4 - h2, yt - h2);
      if (p == "lid") {
        R(X3, yt + h2, X4, ylid);
        polygon([[X3 + 4, ylid], [X4 - 4, ylid], [X4 - 8, ylid + TK], [X3 + 8, ylid + TK]]);
      }
      if (p == "base") {
        R(X3, TK, X4, yb - h2);
        polygon([[X3 + 4, TK], [X4 - 4, TK], [X4 - 8, 0], [X3 + 8, 0]]);
      }
    }
    // windows (main panel only)
    if (p == "front")  window(X1 + 0, yb, X2 - h2, yt);
    if (p == "sideR")  window(X2 + h2, yb, X3 - h2, yt);
    if (p == "sideL")  window(X4 + h2, yb, X5, yt);
    if (p == "back")   window(X3 + h2, yb + h2, X4 - h2, yt - h2);
    if (p == "lid")    window(X3, yt + h2, X4, ylid);
    if (p == "base")   window(X3, TK, X4, yb - h2);
    // score slots inside the tile
    if (p == "front") vline(X1, yb, yt);
    if (p == "sideR") { hline(yt, X2 + h2 + 4, X3 - h2 - 4); hline(yb, X2 + h2 + 4, X3 - h2 - 4); }
    if (p == "sideL") { hline(yt, X4 + h2 + 4, X5 - 4); hline(yb, X4 + h2 + 4, X5 - 4); }
    if (p == "lid")  { hline(ylid, X3 + 4, X4 - 4); translate([(X3 + X4)/2, ylid]) circle(r = min(9, Lo/8)); }   // thumb notch
    if (p == "base") { hline(TK, X3 + 4, X4 - 4);  translate([(X3 + X4)/2, TK]) circle(r = min(9, Lo/8)); }
    // key pockets
    ys = [frac(yb, yt, 0.25), frac(yb, yt, 0.75)];
    if (p == "front") vkeys(X2, ys);
    if (p == "sideR") { vkeys(X2, ys); vkeys(X3, ys); }
    if (p == "back")  { vkeys(X3, ys); vkeys(X4, ys); hkeys(yt, [frac(X3, X4, 0.25), frac(X3, X4, 0.75)]); hkeys(yb, [frac(X3, X4, 0.25), frac(X3, X4, 0.75)]); }
    if (p == "sideL") vkeys(X4, ys);
    if (p == "lid")   hkeys(yt, [frac(X3, X4, 0.25), frac(X3, X4, 0.75)]);
    if (p == "base")  hkeys(yb, [frac(X3, X4, 0.25), frac(X3, X4, 0.75)]);
    // engraved name (small, in the rim)
}
module tile(p) difference() {
    linear_extrude(thick) tile2d(p);
    // engraved tile name, 0.6 deep, on the top face
    tx = p == "front" ? X1 + 6 : p == "sideR" ? X2 + 6 : p == "back" ? X3 + 6 : p == "sideL" ? X4 + 6 : X3 + 6;
    ty = p == "lid" ? yt + 4 : p == "base" ? TK + 4 : yb + 4;
    translate([tx, ty, thick - 0.6]) linear_extrude(1) text(p, size = 5, font = "DejaVu Sans:style=Bold");
}
module key() linear_extrude(kt) bowtie(0);
all = ["front", "sideR", "back", "sideL", "lid", "base"];
if (part == "assembly") { for (p = all) color("lightblue") tile(p); }
else if (part == "assembly_keys") { for (p = all) color("lightblue") tile(p);
    for (y = [frac(yb, yt, 0.25), frac(yb, yt, 0.75)], x = [X2, X3, X4]) color("orange") translate([x, y, 0]) key();
    for (x = [frac(X3, X4, 0.25), frac(X3, X4, 0.75)], y = [yb, yt]) color("orange") translate([x, y, 0]) rotate(90) key(); }
else if (part == "key") key();
else if (part == "check") intersection() {   // keys must not intersect any tile (clearance) -> empty
    union() for (p = all) tile(p);
    union() { for (y = [frac(yb, yt, 0.25), frac(yb, yt, 0.75)], x = [X2, X3, X4]) translate([x, y, 0]) linear_extrude(kt) bowtie(0);
              for (x = [frac(X3, X4, 0.25), frac(X3, X4, 0.75)], y = [yb, yt]) translate([x, y, 0]) rotate(90) linear_extrude(kt) bowtie(0); }
} else tile(part);
