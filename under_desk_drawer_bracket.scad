include <BOSL2/std.scad>
include <BOSL2/screws.scad>

diff("channel mount-hole")
cube([5,5,5], anchor=CENTER) {
    tag("channel") {
        position(RIGHT)
        translate([0.1,0,0])
        cuboid([2+0.1,2,6], anchor=RIGHT, rounding=0.5, edges=[FRONT+LEFT, BACK+LEFT]);
    }
    tag("mount-hole") {
        position(LEFT+FRONT)
        translate([0.25, 0, 0])
        screw_hole("M2x20", l=20, head="flat", orient=FRONT, anchor=LEFT+TOP);
    }
}