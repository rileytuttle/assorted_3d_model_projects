include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn=50;

module adapter()
{
    diff() {
        cyl(d=25, l=20)
        #position(TOP) screw_hole("1/4-20", thread=false, anchor=TOP, l=20, head="none")
        position(TOP) nut_trap_inline(4, anchor=TOP);
    }
    
}

module belt_hook()
{
    thickness = 17;
    width = 15;
    diff() {
        cuboid([75, width, thickness]) {       
            back(3) position(FRONT) tag("remove") cuboid([70, 2.5, thickness+1], anchor=FRONT, rounding=2.5/2, edges=[RIGHT+FRONT, RIGHT+BACK, LEFT+FRONT, LEFT+BACK]);
            back(0.1) tag("remove") position(BACK+LEFT) cuboid([40, 3+0.1, 5], anchor=LEFT+BACK, rounding=2.5, edges=[RIGHT+BOTTOM, RIGHT+TOP])
            back(0.1) position(FRONT) cuboid([40, 3+0.1, 13.5], anchor=BACK, rounding=13.5/2, edges=[RIGHT+BOTTOM, RIGHT+TOP]);
        }
    }
}

// adapter();
belt_hook();
