// Deck Buddy SIMPLE INSERT (Elephant style) - TEST. Body frame: x centre 130.95, y = 87.5 + height from table, z = 40.64 - depth from front (z=0 = back opening).
// view = "insert" | "asm" | "clash" | "print"
view = "insert";
BODY = "../reference/original/obj_7_corp+face.stl_1.stl";
XC = 130.95; Y0 = 87.5; ZF = 40.64; e = 0.01;
module blk(x0,x1,h0,h1,d0,d1) translate([XC+x0, Y0+h0, ZF-d1]) cube([x1-x0, h1-h0, d1-d0]);
module mir(f=[1,0,0]) { children(); translate([2*XC,0,0]) mirror([1,0,0]) translate([-0,0,0]) children(); }
module sym() { children(); translate([XC,0,0]) mirror([1,0,0]) translate([-XC,0,0]) children(); }   // mirror about x = XC
// ---- OLED bay (plain, open top and back): PCB 35.4 x 33.5 x 1.2 at d 13.5..14.7, h 17.1..50.6 ----
module ext(d0,d1) translate([XC,Y0,ZF-d1]) linear_extrude(d1-d0) children();
module r2(x0,x1,h0,h1) translate([x0,h0]) square([x1-x0,h1-h0]);
module bay() {
  // lower part follows the bowl of the body (free half width only 16.4 at h15, 18.4 at h17): bottom bar + web, side walls from h18.4
  ext(12.2,18.2) for (s=[1,-1]) scale([s,1]) {
     polygon([[0,15.4],[16,15.4],[18.3,16.9],[19.2,17.6],[19.4,18.4],[18.0,18.4],[18.0,17.0],[16,17.1],[0,17.1]]);
     r2(18.0,19.4,18.4,47.0);
  }
  ext(15.4,18.2) for (s=[1,-1]) scale([s,1]) r2(18.0,19.4,47.0,52.3);   // upper side walls start behind the body bump (d 13-15, h 49)
  ext(12.2,18.2) r2(-16.0,16.0,15.4,17.1);
  ext(15.4,18.2) r2(-19.4,19.4,50.9,52.3);                              // top wall behind the PCB path: ties the bay to the rails (PCB drops in from the top at d 13.5-14.7)                              // bottom bar (PCB rests on it)
  sym() blk(14.0,18.2, 48.4,50.0, 14.8,16.0);                           // two snap catches behind the PCB top corners
}
// ---- ESP32 rails: board 18 x 22 at h 48.3..49.3, d 18.6..40.6 ----
module esp_rails() sym() {
  blk(9.2,10.4, 47.1,51.0, 14.8,40.64);                  // guide wall 1.2
  blk(8.0,9.2,  47.1,48.3, 18.6,40.64);                  // shelf under the board edge
  blk(8.0,9.2,  49.6,50.9, 18.6,40.64);                  // lip over the board edge (0.3 clearance)
}
// ---- TP4056 rails: board 17 x 27 at h 54.2..55.2, d 13.6..40.6, front stop 2 ----
module tp_rails() sym() {
  blk(8.7,10.4, 50.7,57.5, 13.6,40.64);                  // guide wall (joins the bay top)
  blk(7.5,8.7,  53.0,54.2, 13.6,40.64);                  // shelf
  blk(7.5,8.7,  55.5,56.8, 13.6,40.64);                  // lip
}
module tp_stop() blk(-10.4,10.4, 53.0,57.5, 12.2,13.6);   // front stop in FRONT of the PCB top edge (PCB drops in from the top)
module insert() { bay(); esp_rails(); tp_rails(); tp_stop(); }
module board(w,l,h0,d0) blk(-w/2,w/2,h0,h0+1,d0,d0+l);
module boards() { color("green") board(17,27,54.2,13.6); color("blue") board(18,22,48.3,18.6); color("white") blk(-17.7,17.7,17.1,50.6,13.5,14.7); }
if (view=="insert") insert();
if (view=="asm") { color("lightsteelblue",0.35) import(BODY,convexity=10); color("orange") insert(); boards(); }
if (view=="clash") intersection() { import(BODY,convexity=10); insert(); }
if (view=="clash_boards") intersection() { insert(); boards(); }
if (view=="print") translate([0,-Y0-15.4,28.44]) rotate([0,180,0]) translate([-XC,0,-0]) insert();   // front face (d 12.2) on the bed, rails grow upward
if (view=="clash_tp")  intersection() { insert(); board(17,27,54.2,13.6); }
if (view=="clash_esp") intersection() { insert(); board(18,22,48.3,18.6); }
if (view=="clash_pcb") intersection() { insert(); blk(-17.7,17.7,17.1,50.6,13.5,14.7); }
