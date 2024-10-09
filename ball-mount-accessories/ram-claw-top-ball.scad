include <BOSL2/std.scad>
include <rosetta-stone/ball-mount-bits.scad>
include <BOSL2/screws.scad>
include <rosetta-stone/std.scad>

$fn=50;

layer_height = 0.2;

module claw_top()
{
    diff() {
        ball_with_circular_base((1 * INCH + 1), [32, 6], [12, 12], -5) {
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

module claw_top_2_piece()
{
    diff() {
        circular_base_with_post(0.5 * INCH, (1 * INCH)-0.5, [32, 6], [12, 12], -5) {
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
            up(7) zcopies(n=4, spacing=5) cyl(d=12+2, l=2, rounding=1);
        }
    }
}

module claw_tpu_top()
{
    diff() {
        down(11/2)
        onion(d=(1 * INCH) -0.5, anchor=TOP, orient=DOWN) {
            tag("remove") cyl(d=12, l=50);
        }
        tag("remove") up(7) zcopies(n=4, spacing=5)cyl(d=12+2, l=2, rounding=1);
        down(3) tag("remove") cube([50, 50, 10], anchor=TOP);
    }
}

// claw_top_2_piece();
// back_half()
// right(25)
// claw_tpu_top();
// right(30)
claw_top();
// circular_base_with_post(0.5 * INCH, (1 * INCH)-0.5, [32, 6], [12, 12], -5);
