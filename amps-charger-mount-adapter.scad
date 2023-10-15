include <rosetta-stone/boards.scad>
include <BOSL2/screws.scad>

amps_hole_spacing = [30,38];
board_buffer = 5;
board_thickness = 4;
board_size = [amps_hole_spacing[0]+board_buffer*2, amps_hole_spacing[1]+board_buffer*2, board_thickness];
$fn=10;

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
