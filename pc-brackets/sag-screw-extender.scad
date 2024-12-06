include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn=50;

module extender()
{
    diff()
    {
        cyl(d=15, l=50, anchor=BOTTOM) {
        tag("remove") position(BOTTOM) screw_hole("M8x1.0", l=20, thread=true, anchor=BOTTOM);
        position(TOP) screw("M8x1.0", l=20, anchor=BOTTOM, bevel1=false);
        }
    }
}

extender();
