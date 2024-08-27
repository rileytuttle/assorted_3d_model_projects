include <BOSL2/std.scad>
include <base-holder.scad>
include <BOSL2/screws.scad>

$fn=50;

// important measurments
// like 48-50 square dims
// 28 deep

module back_plate() {

    diff() {
        cube([60, 60, 10], anchor=BOTTOM) {
            position(TOP)
            cube([48, 48, 28], anchor=BOTTOM);
            position(BOTTOM)
            tag("remove") ycopies(n=2, l=20) screw_hole("M4x0.7", thread=true, l=50, anchor=BOTTOM);
        }
    }
}

module holder_attaches_to_backplate()
{
    diff() {
        holder()
        position("screw-center")
        tag("remove") zcopies(n=2, l=20) screw_hole("M4x0.7", head="socket", l=10, anchor=TOP, orient=BACK);
    }
}

module back_plate_with_ram_mounts()
{
}

// holder_attaches_to_backplate();
