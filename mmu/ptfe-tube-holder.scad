include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn=50;
module holder() {
    diff() {
        cuboid([8, 30, 20], anchor=CENTER, chamfer=1) {
            tag("remove")
            position(FRONT)
            fwd(0.01)
            zcopies(l=11, n=2)
            tube_hole(30.1, 10, orient=BACK, anchor=BOTTOM);
            // bolt hole
            tag("remove")
            screw_hole("M3", l=10, orient=RIGHT, thread=false, teardrop=true, spin=0)
                nut_trap_inline(8-3, "M3", $slop=0.1, spin=90);
        }
            
    }
    
}

module tube_hole(overall_length, holding_length, spin=0, orient=UP, anchor=CENTER) {
    ptfe_outer=4;
    filament_outer=2.5;
    attachable(spin=spin, anchor=anchor, orient=orient, size=[ptfe_outer+1, ptfe_outer+1, overall_length]) {
        // filament hole
        cyl(d=filament_outer, l=overall_length)
            position(BOTTOM)
            up(2)
            // pfte holding section
            cyl(d=ptfe_outer+0.15, l=holding_length, anchor=BOTTOM, chamfer1=1.1)
                position(TOP)
                // ptfe entrance section
                cyl(d=ptfe_outer+1, l=overall_length-holding_length-2, anchor=BOTTOM, chamfer1=0.45, chamfer2=-0.5);
        children();
    }
}

// redirector_path = turtle(["move", 10, "arcleft", 5, 30, "move", 10]);
// module filament_redirector_tube() {
//     attachable() {
//         path_extrude2d(redirector_path, caps=false) {
//             circle(d=2.25);
//         }
//         children();
//     }
// }

// module filament_redirector() {
//         path_extrude2d(redirector_path, caps=false) {
//             square([10,10], anchor=CENTER);
//         }
// }

// holder();
// tube_hole(30, 10);

// filament_redirector_tube() show_anchors();

redirector_inner_diam = 40;
redirector_thickness = 3;
redirector_pitch = 2;
redirector_diam = 100;
module filament_redirector_top() {
    diff() {
        cyl(d=redirector_diam, l=redirector_thickness)
            tag("remove")
            threaded_rod(d=redirector_inner_diam+10, pitch=redirector_pitch, l=redirector_thickness+1, $slop=0.2);
    }
}

module filament_redirector_bottom() {
    diff() {
        cyl(d=redirector_diam, l=redirector_thickness) {
            position(TOP)
            cyl(d=redirector_inner_diam+10, l=3, anchor=BOTTOM)
                position(TOP)
                threaded_rod(d=redirector_inner_diam+10, pitch=redirector_pitch, l=redirector_thickness, anchor=BOTTOM);
            position(BOTTOM)
            tag("remove")
            down(0.01)
            cyl(d=redirector_inner_diam, l=redirector_thickness*2+3+1, anchor=BOTTOM);
        }
    }
}

// filament_redirector_top() {
// }
// left(110)
// filament_redirector_bottom();

holder();
