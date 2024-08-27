include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/screws.scad>

$fn=50;

module back_seat_adapter_plate(anchor=CENTER, orient=UP, spin=0)
{
    anchors_list =
    [
        named_anchor("bottom", [0, 0, -10]),
    ];
    attachable(anchor=anchor, orient=orient, spin=spin, anchors=anchors_list)
    {
        diff()
        intersect() {
            join_prism(rect([25, 25]), base="plane", length=15, fillet=2, prism_end_T=xrot(-7.5), end_round=2) {
                position("root")
                fwd(25/2 + 4)
                cuboid([25, 45, 10], anchor=TOP+FRONT, rounding=1, except=TOP) {
                    tag("intersect")
                    position(BOTTOM)
                    cube([25, 45, 100], anchor=BOTTOM);
                    force_tag("remove")
                    position(BOTTOM+FRONT)
                    back(15.2913)
                    down(0.1)
                    grid_copies(n=2, spacing=[18, 20]) screw_hole("M4x0.7", thread=true, l=8.1, anchor=TOP, orient=DOWN, teardrop=true, spin=-90);
                }
                position("root")
                tag("remove")
                xrot(-7.5)
                screw_hole("M6", l=30, anchor=CENTER, teardrop=true, spin=90)
                    position(TOP)
                    down(5)
                    teardrop(d=15, l=50, orient=BACK, anchor=FRONT, cap_h=9);
                    // cyl(d=15, l=50, anchor=TOP, teardrop=true);
                // position("root")
                // xrot(-7.5)
                // #cube([100, 100, 1], anchor=CENTER);
            }
            
        }
        children();
    }
}
