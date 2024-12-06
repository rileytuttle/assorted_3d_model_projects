include <BOSL2/std.scad>
include <rosetta-stone/handles.scad>
include <BOSL2/screws.scad>

$fn=50;
handle_mount_spacing = 120;
handle_height = 20;
handle_thickness = 12;
screw_profile = "M4";
skinnyness_of_middle_fin=0.5;
flat_dist = 60;

diff() {
handle(
    handle_mount_spacing=handle_mount_spacing,
    handle_height=handle_height,
    handle_thickness=handle_thickness,
    // screw_length=10,
    flat_dist=flat_dist,
    skinnyness_of_middle_fin=skinnyness_of_middle_fin)
    position(BOTTOM) tag("remove") xcopies(n=2, l=handle_mount_spacing) screw_hole(screw_profile, l=10, anchor=TOP, orient=DOWN)
        down(5) position(TOP) nut_trap_inline(l=handle_height*2, anchor=TOP, spin=30);
}
