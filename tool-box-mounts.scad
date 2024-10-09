include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn=50;

module template_300x50mm()
{
    increase = 15;
    thickness = 1;
    diff() {
        cube([300+15, 100+15, thickness],anchor=CENTER) {
            position(TOP) cube([20, 100+15, 10], anchor=BOTTOM) {
                tag("remove") ycopies(n=2, l=100) screw_hole("M3", thread=false, l=20, orient=RIGHT, teardrop=true, spin=90)
                position(BOTTOM) nut_trap_inline(3, "M3", anchor=BOTTOM, spin=30);
            }
            tag("remove") xcopies(n=2, l=300) ycopies(n=3, spacing=50) screw_hole("M6", l=thickness+1);
            tag("remove") cube([300-15, 100-15, 100], anchor=CENTER);
        }
    }
}

left_half(200)
template_300x50mm();

right_half(200)
template_300x50mm();
