include <../openscad-library-manager/BOSL2/std.scad>
include <../openscad-library-manager/tmat/std.scad>

$fn=50;

module bucket() {
  bottom_diam=138.5*2;
  top_diam=302;
  height=360;
  cyl(d1=bottom_diam, d2=top_diam, l=height, anchor=BOTTOM)
  position(BOTTOM) cyl(d=bottom_diam, l=1*INCH, anchor=TOP);
}

module cleat(anchor=CENTER, orient=UP, spin=0) {
  attachable(anchor=anchor, orient=orient, spin=spin) {
    diff() {
      cuboid([4*INCH,4*INCH,4 * INCH], anchor=BOTTOM)
      position(BOTTOM) move_copies([[INCH, INCH],[INCH, -INCH],[-INCH, -INCH]]) tmatx(anchor=BOTTOM, orient=DOWN);
      tag("remove") translate([-2*INCH*2, 2*INCH*2]) scale([1.01, 1.01, 1]) bucket();
    }
    children();
  }
}

// #bucket();
// right(2*INCH*2) fwd(2*INCH*2)
// cleat();

tmatx(anchor=BOTTOM, orient=DOWN)
position(BOTTOM) cuboid([1.5*INCH, 1.5*INCH, 0.5*INCH], anchor=TOP);
