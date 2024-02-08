include <BOSL2/std.scad>
include <BOSL2/threading.scad>

$fn=30;

mag_outer_diam = 66;
wall_thickness = 1.5;
pole_diam = 19.5;
mag_inner_diam = 30;
chassis_outer_diam = mag_outer_diam+wall_thickness*2;
chassis_bottom_thickness = 1;

module cut_tube_base(d, l, cut_offset, spin=0, orient=UP, anchor=CENTER) {
    attachable(spin=spin, anchor=anchor, orient=orient, size=[d, d, l]) {
        diff() {
            cyl(d=d, l=l)
            tag("remove")
            translate([-cut_offset, 0, 0]) cube([d,d,l+1], anchor=RIGHT);
        }
        children();
    }
}

module bottom(spin=0, orient=UP, anchor=CENTER) {
    anchors_list = [
        named_anchor("top-bottom-joint", [0, 0, -40/2+25], orient=UP, spin=0)
    ];
    attachable(spin=spin, orient=orient, anchor=anchor, size=[30, 30, 40], anchors=anchors_list) {
        diff() {
            tube(id=pole_diam, od=mag_inner_diam, h=40) {
                tag("remove")
                translate([-pole_diam/2-wall_thickness, 0, 0]) cube([50, 50, 45], anchor=RIGHT);
                tag("keep")
                position(BOTTOM)
                tube(id=mag_outer_diam, wall=wall_thickness, h=25, anchor=BOTTOM);
                tag("keep")
                position(BOTTOM)
                cyl(d=chassis_outer_diam, h=chassis_bottom_thickness, anchor=TOP);
                // remove screw hole
                tag("remove")
                position(TOP)
                translate([0, 0, -5])
                teardrop(d=3.5, l=20, anchor=FRONT, spin=90);
            }
        }
        children();
    }
}

module top(spin=0, orient=UP, anchor=CENTER) {
    cut_offset = pole_diam/2+wall_thickness+0.5;
    anchors_list = [
        named_anchor("mount-hole", [-cut_offset-wall_thickness, 0, 15/2-5], orient=LEFT, spin=0),
        named_anchor("top-bottom-joint", [0, 0, -15/2], orient=UP, spin=0)
    ];
    attachable(spin=spin, orient=orient, anchor=anchor, size=[chassis_outer_diam, chassis_outer_diam, 15], anchors=anchors_list) {
        diff("remove1", "keep1") {
            cut_tube_base(d=34, cut_offset=cut_offset+wall_thickness, l=15) {
                position(BOTTOM)
                cyl(d=chassis_outer_diam, l=wall_thickness, anchor=BOTTOM);
                tag("remove1")
                cut_tube_base(d=31, cut_offset=cut_offset, l=15+3);
                // remove screw hole
                tag("remove1")
                position(TOP)
                translate([0, 0, -5])
                teardrop(d=3.5, l=20, spin=90, anchor=FRONT);
            }
        }
        children();
    }
}

module disengager(spin=0, orient=UP, anchor=CENTER) {
    inner_diam = chassis_outer_diam+1;
    outer_diam = inner_diam + 1*2; // adding wall thickness
    attachable(spin=spin, orient=orient, anchor=anchor) {
        diff() {
            cyl(d=outer_diam, l=chassis_bottom_thickness) {
                position(TOP)
                tube(id=inner_diam, od=inner_diam+1*2, l=40, anchor=BOTTOM);
                position(TOP)
                cyl(d=17, l=30, anchor=BOTTOM, chamfer2=1)
                    tag("remove")
                    position(BOTTOM)
                    right(1)
                    threaded_rod(d=8.25, pitch=1.25, l=30.1, anchor=BOTTOM+RIGHT, internal=true);
            }
        }
        children();
    }
}

// color_this("blue")cover_piece()
//     up(70)
//     bottom();
// position("top-bottom-joint")
// top(anchor=BOTTOM);

// cut_tube_base(19, 7, 3);


// import("backupstls/magnetic-pick-disengager.stl", convexity=3);
disengager();
