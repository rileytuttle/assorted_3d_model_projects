include <../openscad-library-manager/BOSL2/std.scad>
include <../openscad-library-manager/BOSL2/screws.scad>
include <../openscad-library-manager/rosetta-stone/std.scad>

$fn=50;

aluminum_sheet_thickness = 1.5;
mount_hole_dist = 1.625 * INCH;
mount_screw = "1/4-20";
overall_thickness = 10;
bracket_width = 25;
cutout_width = 0.75 * INCH;

module bracket()
{

  diff()
  {
    cuboid([mount_hole_dist, bracket_width, overall_thickness]) {
      xcopies(n=2, spacing=mount_hole_dist) {
        cyl(d=bracket_width, l=overall_thickness);
        tag("remove") screw_hole(mount_screw, l=overall_thickness) position(BOTTOM) nut_trap_inline(6, anchor=BOTTOM);
      }
      tag("remove") position(TOP) cuboid([cutout_width, 100, aluminum_sheet_thickness], anchor=TOP);
    }
  }

}

bracket();
