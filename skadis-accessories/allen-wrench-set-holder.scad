include <skadis/skadis.scad>
include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn=50;

module allen_wrench_set_holder()
{
}

// module allen_wrench_set_lock()
// {
//     spacing = 103;
//     big_hole_d = 11;
//     small_hole_d = 7;
//     handle_thickness = 30;
//     lock_thickness = 12;
//     cuboid([spacing, lock_thickness, lock_thickness], anchor=CENTER, rounding=4, edges=[TOP+RIGHT, TOP+LEFT]) {
//         down(0.5) position(LEFT+FRONT) teardrop(d=big_hole_d, l=handle_thickness+lock_thickness, anchor=FRONT, cap_h=big_hole_d/2, orient=DOWN);
//         down(2.5) #position(RIGHT+FRONT) teardrop(d=small_hole_d, l=handle_thickness+lock_thickness, anchor=FRONT, cap_h=small_hole_d/2, orient=DOWN);
//     }
// }

module allen_wrench_set_lock()
{
    spacing = 103;
    big_hole_d = 11;
    small_hole_d = 7;
    handle_thickness = 30;
    diff() {
        cube([spacing+10, 12, 5], anchor=CENTER) {
        }
    }
}

// allen_wrench_set_holder();

// allen_wrench_set_lock();


skadis_plier(l=52, w=51, filet=3, h=7, thickness=7, retainer=true);

