include <openscad-library-manager/BOSL2/std.scad>
include <rosetta-stone/std.scad>
include <BOSL2/screws.scad>

$fn=50;

module thing()
{
    up(7) intersection() {
        xrot(180) translate([184.9, -163.1, 25.925]) import("VESA_Mount_02.stl");
        cuboid([100, 100, 30]);
    }
}

difference() {
union() {
    linear_extrude(height=7) projection() thing();
    thing();
    grid_copies(n=[2,2], spacing=[75, 75]) cyl(d=5, l=10, anchor=BOTTOM);
}
#grid_copies(n=[2,2], spacing=[75,75])
    screw_hole("M4", l=10, thread=true, anchor=BOTTOM)
    position(TOP) nut_trap_inline(5, anchor=TOP);
}
