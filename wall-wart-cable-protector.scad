include <BOSL2/std.scad>

$fn=30;
wall_thickness = 3;

diff() {
    cuboid([26+wall_thickness, 26.5+wall_thickness, 28+30], rounding=5+wall_thickness/2, edges="Z") {
        tag("remove")
        cuboid([26, 26.5, 28 + 30 + 1], rounding=5, edges="Z");
        tag("remove") {
            translate([0, 0, 10]) {
                position(BOTTOM + LEFT) cyl(d=7, l=wall_thickness+1, orient=LEFT);
                position(BOTTOM + LEFT) cuboid([7, wall_thickness+1, 10], rounding=-2, edges=BOTTOM, anchor=TOP, spin=90);
            }
        }
    }
}
