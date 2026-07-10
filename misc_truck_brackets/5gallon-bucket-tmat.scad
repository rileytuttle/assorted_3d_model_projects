include <../openscad-library-manager/BOSL2/std.scad>

module cleat()
{
  difference() {
    translate([746, 405, 0]) import("5gallonbucketcleatorig.stl");
    translate([-5, 5, 0]) cuboid([20, 20, 100], anchor=BOTTOM+FRONT, spin=45);
  }
}

cleat();
