include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <rosetta-stone/ball-mount-bits.scad>
include <rosetta-stone/std.scad>

$fn=50;

m4_info = screw_info("M4x0.7", head="socket");

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
    ball_with_circular_base(17.5, [32, 7], [10, 10], flare_neck_bottom = -5) {
            position(BOTTOM)
            zrot_copies(n=3, r=10)
            screw_hole("#8-36", thread=false, l=10, anchor=TOP, orient=DOWN)
                down(5) position(TOP) nut_trap_inline(5, "#8-36", anchor=TOP, spin=90);
            position(BOTTOM)
            up(1)
            screw_hole("M4", thread=true, l=20, anchor=TOP, orient=DOWN, head="socket") {
                position("shaft_top")
                floating_hole(d=struct_val(m4_info, "head_size"),
                              l=struct_val(m4_info, "head_height")+1,
                              channel_w=struct_val(m4_info, "diameter"),
                              layer_height=0.3, anchor=TOP, orient=DOWN);
            }
            // nut_thickness = 3;
            // additional_nut_thickness = 1;
            // #position(TOP) nut_trap_inline(nut_thickness+additional_nut_thickness, "M4", anchor=TOP);
        }
    }
}

ball_base_17mm();
// floating_hole(d=struct_val(m4_info, "head_size"),
//               l=struct_val(m4_info, "head_height")+1,
//               channel_w=struct_val(m4_info, "diameter") + 0.25,
//               layer_height=0.3);
