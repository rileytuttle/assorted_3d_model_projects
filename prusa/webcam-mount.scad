include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn=50;

module webcam_mount()
{
    diff() {
        cyl(d=20, l=40, anchor=BOTTOM) {
            position(BOTTOM) screw_hole("M3", thread=false, l=5, anchor=TOP, orient=DOWN)
                position(BOTTOM) nut_trap_inline(3, anchor=BOTTOM);
            up(0.01) position(TOP) tag("remove") cyl(d=10,l=40-5+0.01, anchor=TOP);
            #position(BOTTOM) up(20) screw_hole("M3", l=20, orient=FRONT, teardrop=true)
                position(BOTTOM) nut_trap_inline(3, anchor=BOTTOM, spin=30);
            tag("remove") position(BOTTOM) up(10) cuboid([100, 4, 100], anchor=BOTTOM, rounding=2, edges=[FRONT+BOTTOM, BACK+BOTTOM], teardrop=true);
        }
    }
}

webcam_mount();
