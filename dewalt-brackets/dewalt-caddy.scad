include <BOSL2/std.scad>
include <base-holder.scad>
include <BOSL2/screws.scad>
include <rosetta-stone/std.scad>

$fn=50;

battery_width = 87;
screw_profile = "M4x0.7"; // [M5:M5x0.8, M4:M4x0.7]
handle_screw_head = "socket";
battery_holder_width = 60; // not a param need to figure out how to hide
battery_holder_depth = 9.8;
carriers_per_side = 3;
overall_width = battery_width*(carriers_per_side-1)+battery_holder_width;
echo(str("overall battery caddy width = ", overall_width));

trapezoid_inner_rounding = 0;
handle_thickness = 10;
handle_height = 50;
handle_width = 150;

bottom_plate_screw_head = "socket";
bottom_plate_thickness = 18;
bottom_plate_spacer = false;

module caddy() {
    diff() {
        cube([overall_width, handle_thickness, 78.44], anchor=BOTTOM) {
            position(BOTTOM)
            xcopies(n=carriers_per_side, spacing=battery_width) {
                back(5)
                holder();
                fwd(5)
                holder(spin=180);
                up(61)
                tag("remove") teardrop(d=3, l=70);
            }
            for (pos=[[TOP, UP, false], [BOTTOM, DOWN, true]])
            {
                position(pos[0]) tag("remove") xcopies(n=2, l=battery_width) {
                screw_hole(screw_profile, l=20, anchor=TOP, orient=pos[1], thread=pos[2])
                    position(TOP)
                    down(7)
                    nut_trap_side(10, screw_profile, spin=-90, thickness=5, anchor=TOP)
                        teardrop(d=3, l=20, spin=90, orient=pos[1]);
                }
            }
            tag("remove") xcopies(n=carriers_per_side-1, l=battery_width) screw_hole(screw_profile, thread=false, l=78.44-(20 *2));
        }
    }
}

module handle()
{
    assert(handle_width <= overall_width && handle_width > battery_width);
    inner_trap_edge_round = 2;
    outer_trap_edge_chamfer = 2;
    diff() {
        trapezoid3d(handle_width, handle_width-50, handle_height, handle_thickness, joint_top=outer_trap_edge_chamfer, joint_sides=outer_trap_edge_chamfer, chamfer=true) {
            tag("remove")
            rounded_prism(
                trapezoid(handle_height-25, handle_width-40, handle_width-50-22, rounding=trapezoid_inner_rounding),
                trapezoid(handle_height-25, handle_width-40, handle_width-50-22, rounding=trapezoid_inner_rounding),
                height=handle_thickness,
                joint_top=-inner_trap_edge_round, joint_bot=-inner_trap_edge_round, orient=FRONT)
                back(inner_trap_edge_round)
                position(FRONT)
                xcopies(n=carriers_per_side-1, l=battery_width)
                screw_hole(screw_profile, head=handle_screw_head, thread=false, l=15, anchor=TOP, orient=BACK, teardrop=true);
        }
    }
}

module bottom_plate(spacer=false)
{
    diff() {
        cuboid([overall_width, handle_thickness+2*17.3, bottom_plate_thickness], anchor=TOP, chamfer=2, except=[TOP, BOTTOM]) {
            if (spacer) {
                xcopies(n=2, l=battery_width)
                screw_hole(screw_profile, l=bottom_plate_thickness);
            } else {
                down(5)
                position(TOP)
                xcopies(n=2, l=battery_width)
                screw_hole(screw_profile, head=bottom_plate_screw_head, l=5, anchor="head_bot", orient=DOWN, thread=false, counterbore=10);
            }
            tag("remove")
            xcopies(n=2, l=(overall_width + battery_width)/2)
            cuboid([50, 25, 20], rounding=3, except=[TOP, BOTTOM]);
            tag("remove")
            cuboid([65, 25, 20], rounding=3, except=[TOP, BOTTOM]);
        }
    }
}

// #caddy();
// up(120)
// fwd(5)
// xrot(-90)
// handle();
// down(5)
bottom_plate(bottom_plate_spacer);
