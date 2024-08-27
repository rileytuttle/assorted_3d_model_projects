include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <BOSL2/rounding.scad>
include <back-seat-bolt-adapter-plate.scad>

$fn=50;

module air_hose_adapter(anchor=CENTER, orient=UP, spin=0) 
{
    attachable(size=[30, 35, 10], anchor=anchor, orient=orient, spin=spin)
    {
        diff() {
            cuboid([30,35,10], rounding=2, except=BOTTOM) {
                position(TOP)
                grid_copies(n=2, spacing=[18,20]) screw_hole("M4", head="socket", anchor=TOP, l=10, teardrop=true);
                position(TOP)
                intersect() {
                join_prism(rect([25, 5]), base="plane", length=25, fillet=2, end_round=2, anchor="root");
                    tag("intersect") cube([27, 10, 100], anchor=BOTTOM);
                }
                tag("remove")
                position(TOP)
                up(12)
                cyl(d=12, l=5, orient=BACK, rounding=-1);
            }
            
        }
        children();
    }
}

// air_hose_adapter(anchor=FRONT, orient=FRONT)
// position(FRONT)
// fwd(10)
// back_seat_adapter_plate();
// position("bottom")
// back(44)
air_hose_adapter();
