include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn=50;
post_d = 35.5;
screw_type="M4x0.7";
mic_arm_post_d = 12.5;
module mic_arm_post_mount()
{
    wall=7;
    h = 40;
    flange_thickness=wall;
    gap=3;
    diff() {
        tube(id=post_d, wall=wall, l=h) {
            back(wall) position(FRONT) cube([flange_thickness*2+gap, 20+wall, h], anchor=BACK) {
                tag("remove") cube([gap, 50, 100], anchor=CENTER);
                shift_over = 2;
                tag("remove") position(RIGHT) fwd(wall/2) left(shift_over)
                zcopies(n=2, l=17)
                screw_hole(screw_type, l=flange_thickness*2+gap-shift_over, thread=false, head="socket", anchor="head_bot", orient=RIGHT, teardrop=true, spin=90)
                    position(BOTTOM) nut_trap_inline(2, screw_type, anchor=BOTTOM, spin=30);
            }
            fwd(wall) position(BACK) cuboid([30, 40+wall, h], rounding=15, edges=[BACK+LEFT, BACK+RIGHT], anchor=FRONT) {
                tag("remove") fwd(15) position(BACK) cyl(d=mic_arm_post_d, l=h)
                zrot(-55) position(RIGHT) left(mic_arm_post_d/2) screw_hole("M3x0.5", thread=true, head="socket", counterbore=20, l=10+mic_arm_post_d/2, anchor=BOTTOM, orient=RIGHT, teardrop=true, spin=90)
                up(mic_arm_post_d/2+1) position(BOTTOM) nut_trap_side(50, "M3", anchor=BOTTOM, spin=90, poke_len=50);
            }
        }
    }
}

mic_arm_post_mount();
