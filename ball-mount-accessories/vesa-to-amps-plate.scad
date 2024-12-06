include <BOSL2/std.scad>
include <rosetta-stone/std.scad>
include <BOSL2/screws.scad>

$fn=50;

module vesa_to_amps_plate()
{
    diff() {
        cuboid([90, 90, 5], rounding=5, except=[TOP, BOTTOM]) {
            grid_copies(n=2, size=[75,75]) screw_hole("M4", l=5);
            position(TOP)
            rounded_prism(rect([amps_spacing[0]+15,amps_spacing[1]+15]), height=5, anchor=BOTTOM, joint_top=1, joint_bot=-1, joint_sides=5, splinesteps=1);
            screw_info_struct = screw_info("M4", head="socket");
            echo(str(screw_info_struct));
            position(BOTTOM) grid_copies(n=2, size=amps_spacing)
                screw_hole(screw_info_struct, l=20, anchor=TOP, orient=DOWN)
                position("shaft_top") 
                floating_hole(
                    d=struct_val(screw_info_struct, "head_size")+0.75,
                    channel_w=struct_val(screw_info_struct, "diameter")+0.5,
                    l=struct_val(screw_info_struct, "head_height"),
                    anchor=TOP, orient=DOWN);
        }
            
    }
}

vesa_to_amps_plate();
