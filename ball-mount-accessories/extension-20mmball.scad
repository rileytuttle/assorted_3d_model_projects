include <rosetta-stone/ball-mount-bits.scad>
include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn=50;


right_half()
left(2)
diff() {
    extension(20, 22, anchor=LEFT)
    position(CENTER) screw_hole("M4", thread = true, l = 27, anchor=CENTER, orient=RIGHT)
        position(TOP) cyl(d=7, l=20, anchor=BOTTOM);
}
