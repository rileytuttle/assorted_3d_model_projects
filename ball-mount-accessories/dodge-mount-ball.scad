include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <rosetta-stone/ball-mount-bits.scad>

$fn=50;

module test_disk() {

diff() {
cyl(d=32, l=4, anchor=CENTER)
    tag("remove")
    zrot_copies(n=3, r=10)
    #screw_hole("M4", thread=true, l=5);
}

}

module ball_base_17mm()
{
    diff() {
    ball_with_circular_base(17, [32, 7], [10, 10], flare_neck_bottom = -5) {
            position(BOTTOM)
            zrot_copies(n=3, r=10)
            screw_hole("#8-36", thread=true, l=6, anchor=TOP, orient=DOWN);
            position(BOTTOM)
            up(1)
            screw_hole("M4", thread=true, l=20, anchor=TOP, orient=DOWN, head="socket")
                position(TOP) cyl(d=7, l=2, anchor=BOTTOM);
        }
    }
}

ball_base_17mm();
