include <BOSL2/std.scad>
include <rosetta-stone/ball-mount-bits.scad>
include <BOSL2/screws.scad>
include <rosetta-stone/std.scad>

$fn=50;

layer_height = 0.2;

module claw_top()
{
    diff() {
        ball_with_circular_base(1 * INCH-0.5, [32, 6], [12, 12], -5) {
            push_down = 11;
            down(push_down)
            position(TOP)
            screw_hole("#10-24", thread=false, l=100, anchor=TOP)
            position(TOP)
            tag("remove")
            cyl(d=10, l=push_down, anchor=BOTTOM);
            position(BOTTOM)
            tag("remove")
            zrot_copies(n=6, r=11) {
                floating_hole(d=7, l=3, layer_height=layer_height, anchor=BOTTOM);
            }
        }
    }
}

claw_top();
