include <rosetta-stone/boards.scad>
include <BOSL2/screws.scad>

amps_hole_spacing = [30,38];
board_buffer = 5;
board_thickness = 4;
board_size = [amps_hole_spacing[0]+board_buffer*2, amps_hole_spacing[1]+board_buffer*2, board_thickness];
$fn=50;

module amps_to_threaded_plate()
{
    diff("screw-hole mount-cutouts")
    simulated_4_hole_board(board_size, amps_hole_spacing, 4.5) {
        position(TOP)
        cyl(l=4, d=20, anchor=BOTTOM, rounding1=-2, rounding2=2) {
            tag("screw-hole") {
                position(TOP)
                screw_hole("M5-0.8", length=10, thread=true, anchor=TOP);
            }
        }
        tag("mount-cutouts") {
            position("mount_hole1")
            translate([-1, -1, 4/2-1.5])
            linear_extrude(height=1.5)
                rect([10, 10], anchor=CENTER, rounding=[4,0,0,0]);

            position("mount_hole2")
            translate([-1, 1, 4/2-1.5])
            linear_extrude(height=1.5)
                rect([10, 10], anchor=CENTER, rounding=[0,0,0,4]);

            position("mount_hole3")
            translate([1, -1, 4/2-1.5])
            linear_extrude(height=1.5)
                rect([10, 10], anchor=CENTER, rounding=[0,4,0,0]);

            position("mount_hole4")
            translate([1, 1, 4/2-1.5])
            linear_extrude(height=1.5)
                rect([10, 10], anchor=CENTER, rounding=[0,0,4,0]);
        }
        tag("mount-cutouts") {
            position(BACK+LEFT)
            fillet(l=4, r=5, spin=-90);
            position(BACK+RIGHT)
            fillet(l=4, r=5, spin=180);
            position(FRONT+RIGHT)
            fillet(l=4, r=5, spin=90);
            position(FRONT+LEFT)
            fillet(l=4, r=5, spin=0);
        }
        // tag("mount-cutouts")
        // {
        //     thread_spec = screw_info("M4-0.7");
        //     position("mount_hole1")
        //     mount_threads4(thread_spec, [amps_hole_spacing[0], amps_hole_spacing[1], 5], anchor="mount_hole1");
        // }
    }
}

module amps_to_threaded_plate2()
{
    diff() {
        cuboid(board_size, rounding=5, edges=[LEFT+FRONT, LEFT+BACK, RIGHT+FRONT, RIGHT+BACK]) {
            position(TOP)
            cyl(l=5, d=24, anchor=BOTTOM, rounding1=-2, rounding2=2);
            tag("remove") position(BOTTOM) screw_hole("M5-0.8", length=20, thread=false, anchor=BOTTOM)
                up(5) position(BOTTOM) nut_trap_inline(5, anchor=TOP);
            position(TOP) grid_copies(n=2, size=amps_hole_spacing) screw_hole("M4", l=board_size[2], anchor=TOP, head="button");
        }
    }
}

module rav_4_mount_base()
{
    diff() {
        cuboid(board_size, rounding=5, edges=[LEFT+FRONT, LEFT+BACK, RIGHT+FRONT, RIGHT+BACK]) {
            down(1) position(TOP) tag("remove") grid_copies(n=2, amps_hole_spacing) screw_hole("M4", thread=false, l=board_thickness, anchor="shaft_top", head="button");
            position(TOP) cyl(d=20, l=5, anchor=BOTTOM)
                position(TOP) tag("remove") cuboid([10, 10, 4], anchor=TOP, chamfer=-1, edges=TOP);
            position(BOTTOM) screw_hole("M4", l=20, thread=false, anchor=BOTTOM)
                position(BOTTOM) nut_trap_inline(3.5, anchor=BOTTOM);
        }
    }
}

module ball_base_16mm()
{
    diff("remove", "no-remove") {
    intersect("intersect", "no-intersect") {
        cyl(d=9.8, l=10+4, anchor=BOTTOM, rounding1=-10) {
            tag("intersect") position(BOTTOM) cuboid([9.8, 9.8, 20], anchor=BOTTOM);
        }
    }
        up(6+14) onion(d=16, orient=DOWN)
            position(BOTTOM) tag("remove") screw_hole("M4", l=30, thread=false, head="socket", anchor=TOP, counterbore=5, orient=DOWN);
    }
}

// rav_4_mount_base();
// up(board_size[2]) ball_base_16mm();
// amps_to_threaded_plate();
amps_to_threaded_plate2();
