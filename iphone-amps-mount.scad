include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <BOSL2/rounding.scad>

$fn=50; 
diam=50;
amps_width = 30;
amps_height = 38;
base_thickness = 6.5;
middle_diam = 30;

// central_screw_spec = "M4x0.7";
central_screw_spec = "M3x0.5";
wing_diam = 25;

n_nubs = 20;
module base_piece(spin=0, orient=UP, anchor=CENTER)
{
    thickness = base_thickness;
    width = 45;
    height=50;
    nub_diam = middle_diam+3;
    attachable(spin=spin, orient=orient, anchor=anchor, size=[width, height,thickness]) {
        diff() {
            cuboid([amps_width+11, amps_height+11, thickness], anchor=CENTER, rounding=5, edges=[FRONT+RIGHT, FRONT+LEFT, BACK+LEFT, BACK+RIGHT]) {
                tag("remove")
                ycopies(l=38, n=2) {
                    xcopies(l=30, n=2) {
                        // bolt shaft hole
                        // cyl(d=3, l=thickness+1);
                        position(TOP)
                        screw_hole("M4x0.7", head="socket", l=thickness+1, anchor=TOP);
                    }
                }
                // tag("remove")
                // ycopies(l=amps_height, n=2) {
                //     xcopies(l=amps_width, n=2) {
                //         position(TOP)
                //         // bolt head countersink
                //         cyl(d=5, l=4, anchor=TOP);
                //     }
                // }
                tag("remove")
                // screw_hole("M4x0.7", l=thickness, head="flat", counterbore=true, thread=true);
                screw_hole(central_screw_spec, l=thickness, thread=true);
                tag("remove")
                position(TOP)
                cyl(d=nub_diam, l=3, anchor=TOP);
                tag("keep")
                position(TOP)
                zrot_copies(n=n_nubs, r=(nub_diam+1)/2) cyl(d=3, l=3, anchor=TOP);
            }
        }
        children();
    }
}

module rotating_piece(base_diam, threaded=true, spin=0, orient=UP, anchor=CENTER, add_bolt_container=false)
{
    swivel_diam = 10;
    swivel_hole_up_disp = swivel_diam/2 - 1;
    thickness = 3;
    left_shift = 8;
    swivel_mult = 1.25;
    joint_thickness = 4;
    attachable(spin=spin, orient=orient, anchor=anchor, size=[diam, diam, thickness]) {
        diff() {
            cyl(d=base_diam, l=thickness, anchor=CENTER) {
                tag("remove")
                screw_hole(central_screw_spec, l=thickness, head="flat", counterbore=true);
                left(left_shift)
                position(TOP)
                cuboid([joint_thickness,swivel_diam*swivel_mult,swivel_hole_up_disp], anchor=BOTTOM, rounding=-2, edges=BOTTOM) {
                //     position(TOP)
                //     top_half() cyl(d=20, l=5, anchor=CENTER, orient=RIGHT) {
                //         tag("remove")
                //         screw_hole("1/4,20", l=6);
                //         if (add_bolt_container) {
                //             down(1)
                //             position(BOTTOM)
                //             tag("remove")
                //             offset_sweep(regular_ngon(n=6, d=13, spin=30), l=3);
                //         }
                //     }
                //     rotate([90, -90, 0])
                //     translate([-8/2, 5/2, 0])
                //     fillet(r=3, l=40, anchor=CENTER, orient=UP, spin=0);
                }
                position(TOP)
                up(swivel_hole_up_disp) left(left_shift) {
                    cyl(d=swivel_diam*swivel_mult, l=joint_thickness, anchor=CENTER, orient=RIGHT) {
                        tag("remove")
                        // screw_hole("1/4,20", thread=true, l=6);
                        left(2)
                        screw_hole("M4x0.7", l=joint_thickness+1, thread=threaded);
                    }
                }
                zrot(360/n_nubs/2)
                zrot_copies(n=n_nubs, r=(middle_diam-1.6)/2) cyl(d=3, l=3);
            }
        }
        children();
    }
}

module phone_mount(base_diam, threaded=true, spin=0, orient=UP, anchor=CENTER, add_bolt_container=false)
{
    swivel_diam = 10;
    swivel_hole_up_disp = swivel_diam/2 - 1;
    thickness = 3;
    joint_thickness = 4;
    left_shift = 8-joint_thickness;
    swivel_mult = 1.25;
    attachable(spin=spin, orient=orient, anchor=anchor, size=[diam, diam, thickness]) {
        diff() {
            cyl(d=base_diam, l=thickness, anchor=CENTER) {
                for (data = [[true, left_shift], [false, left_shift+joint_thickness*2+0.25]])
                {
                    left(data[1])
                    position(TOP)
                    cuboid([joint_thickness,swivel_diam*swivel_mult,swivel_hole_up_disp], anchor=BOTTOM, rounding=-2, edges=BOTTOM) {
                    //     position(TOP)
                    //     top_half() cyl(d=20, l=5, anchor=CENTER, orient=RIGHT) {
                    //         tag("remove")
                    //         screw_hole("1/4,20", l=6);
                    //         if (add_bolt_container) {
                    //             down(1)
                    //             position(BOTTOM)
                    //             tag("remove")
                    //             offset_sweep(regular_ngon(n=6, d=13, spin=30), l=3);
                    //         }
                    //     }
                    //     rotate([90, -90, 0])
                    //     translate([-8/2, 5/2, 0])
                    //     fillet(r=3, l=40, anchor=CENTER, orient=UP, spin=0);
                    }
                    position(TOP)
                    up(swivel_hole_up_disp) left(data[1]) {
                        cyl(d=swivel_diam*swivel_mult, l=joint_thickness, anchor=CENTER, orient=RIGHT) {
                            tag("remove")
                            // screw_hole("1/4,20", thread=true, l=6);
                            left(2)
                            // screw_hole("M4x0.7", l=joint_thickness+1, thread=data[0]);
                            if (!data[0]) {
                                zrot(90)
                                xrot(-90)
                                position(CENTER)
                                teardrop(d=4, l=joint_thickness+1, anchor=CENTER);
                            }
                            else
                            {
                                zrot(90)
                                xrot(-90)
                                position(CENTER)
                                teardrop(d=3, l=joint_thickness+1, anchor=CENTER);
                            }
                        }
                    }
                }
            }
        }
        children();
    }
}

module wing_cap() {
    diff() {
        cyl(d=15, l=5) {
            cuboid([wing_diam, 7, 5], rounding=3, edges=[FRONT+LEFT, FRONT+RIGHT, BACK+LEFT, BACK+RIGHT]);
            position(TOP)
            tag("remove")
            nut_trap_inline(4, "1/4", anchor=TOP);
            tag("remove")
            screw_hole("1/4,20", l=6);
        }
    }
}

base_piece() {
//     position(TOP)
//     up(0.5)
    // rotating_piece(base_diam=middle_diam, anchor=BOTTOM, spin=0, threaded=false);
}

// Up(wing_diam/2 + 3)
// rotate([0, 90, 0])
// wing_cap();

// phone_mount(50, threaded=false);
// rotating_piece(base_diam=middle_diam, anchor=BOTTOM);
