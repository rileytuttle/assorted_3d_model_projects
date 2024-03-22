include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <rosetta-stone/ball-mount-bits.scad>

$fn=50;

module tripod_ball_mount() {
    platform_size = [40, 7];
    ball_d = 25;
    threaded_dist = 10;
    diff() {
        ball_with_circular_base(ball_d, platform_size, [12, 15]) {
            up(2)
            position(BOTTOM) nut_trap_inline(6, "1/4-20", anchor=BOTTOM);
            position(BOTTOM) up(platform_size[1]/2)
            ycopies(n=2, l=26)
            {
                screw_hole("M3", thread=true, l=12, orient=RIGHT, anchor=TOP);
                screw_hole("M3", thread=false, l=10, orient=RIGHT, anchor=BOTTOM)
                position(TOP) tag("remove") cyl(d=6, l=10, anchor=BOTTOM);
            }
            position(TOP)
            down(ball_d/2) {
                screw_hole("M4", thread=true, l=threaded_dist, anchor=TOP, orient=RIGHT); 
                screw_hole("M4", thread=false, l=6, anchor=BOTTOM, orient=RIGHT)
                position(TOP)
                tag("remove")
                cyl(d=7.5, l=10, anchor=BOTTOM);
            }
        }
    }

}

left_half() tripod_ball_mount();
right_half() tripod_ball_mount();
