include <BOSL2/std.scad>
include <rosetta-stone/handles.scad>

$fn=50;
handle_mount_spacing = 120;
handle_height = 20;
handle_thickness = 12;
screw_profile = "M3";
skinnyness_of_middle_fin=0.5;

diff() {
handle(
    handle_mount_spacing=handle_mount_spacing,
    handle_height=handle_height,
    handle_thickness=handle_thickness,
    screw_length=10,
    skinnyness_of_middle_fin=skinnyness_of_middle_fin,
    screw_profile=screw_profile)
    position(BOTTOM)
    tag("remove") xcopies(n=2, handle_mount_spacing) floating_hole(d=7, l=2, channel_w=3.3, layer_height=0.3, anchor=BOTTOM);
}
