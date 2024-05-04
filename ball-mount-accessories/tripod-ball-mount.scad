include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <rosetta-stone/ball-mount-bits.scad>
include <rosetta-stone/std.scad>

$fn=50;

module tripod_ball_mount() {
    platform_size = [40, 7];
    ball_d = 25;
    threaded_dist = 10;
    diff() {
        ball_with_circular_base(ball_d, platform_size, [12, 15], flare_neck_bottom=-10) {
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

module tripod_double_ball_mount()
{
    size = [50, 36, 7];
    left_ball_disp = 14;
    right_ball_disp = 15;
    diff() {
        cuboid(size, anchor=BOTTOM, rounding=2, edges=[TOP, RIGHT+FRONT, RIGHT+BACK, LEFT+FRONT, LEFT+BACK]) {
            push_up = 20;
            up(push_up) {
                left(left_ball_disp)
                sphere(d=25.5)
                    cyl(d=12, l=push_up-size[2]/2, anchor=TOP, rounding1=-3);
                right(right_ball_disp)
                sphere(d=17.5)
                    cyl(d=10, l=push_up-size[2]/2, anchor=TOP, rounding1=-3);
            }
            position(BOTTOM)
            up(2)
            nut_trap_inline(6, "1/4-20", anchor=BOTTOM);
            tag("remove") cyl(d=7, l=10);
            for (i=[-left_ball_disp, right_ball_disp])
            {
                position(BOTTOM)
                up(4)
                tag("remove")
                translate([i, 0, 0]) screw_hole("M4", thread=true, l=27, anchor=BOTTOM)
                position(BOTTOM)
                cyl(d=8, l=10, anchor=TOP);
            }
        }
    }
}

// left_half() tripod_ball_mount();
// right_half() tripod_ball_mount();

tripod_double_ball_mount();
