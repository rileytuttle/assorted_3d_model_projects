include <ball-mount/ball-mount-bits.scad>
include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn=50;

module stud(anchor=CENTER)
{
    diam=17;
    neck_length=15;
    attachable(anchor=anchor, size=[diam, diam, diam/2 + neck_length]) {
    up((diam/2 + neck_length)/2)
    diff() {
        onion(d=diam, orient=DOWN, anchor=BOTTOM) {
            // neck
            cyl(d=10, l=neck_length, anchor=BOTTOM);
            up(4.5) position(BOTTOM) screw_hole("M6", head="button", anchor="shaft_top", l=30, orient=DOWN, counterbore=10, thread=true);
            tag("remove") torus(d_maj=diam, d_min=2);
        }
    }
    children();
    }
}

// screw("M6", head="button", l=48, anchor=BOTTOM)
// position(TOP)
// back_half(200)
// up(1)
stud(anchor=BOTTOM);
