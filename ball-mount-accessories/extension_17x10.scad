include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <rosetta-stone/ball-mount-bits.scad>

$fn=50;

right_half()
diff() {
    left(1)
    extension(17, 10, anchor=LEFT) {
        position(CENTER)
        screw_hole("M4", l=30, thread=true, head="socket", orient=RIGHT, anchor=CENTER)
        tag("remove")
        position(TOP) cyl(d=7, l=10, anchor=BOTTOM);
    }
    // #cyl(d=7, l=2, orient=RIGHT, anchor=TOP);
}
