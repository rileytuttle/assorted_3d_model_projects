include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/screws.scad>

$fn=50;
plate_thickness = 3;
module body_no_hole() {
    hole_dist = 80;
    end_r = 8;
    thickness = plate_thickness;
    path = turtle([
        "move", hole_dist/2,
        "arcright", end_r, 180,
        "move", hole_dist,
        "arcright", end_r, 180,
        // "move", hole_dist/2,
    ]);
    anchor_list = [
        named_anchor("left-hole", [-hole_dist/2, 0, thickness/2]),
        named_anchor("right-hole", [hole_dist/2, 0, thickness/2]),
    ];
    attachable(size=[hole_dist + end_r*2, end_r*2, thickness], anchors=anchor_list) {
        back(end_r)
        down(thickness/2)
        offset_sweep(path, l=thickness, top=os_circle(r=2));
        children();
    }
}

module threaded_side() {
    diff() {
        body_no_hole() {
            position("left-hole") {
                down(plate_thickness)
                cyl(d=9, l=8, anchor=TOP, chamfer1=1)
                    position(TOP)
                    cyl(d=12, l=2, anchor=TOP);
                tag("remove") screw_hole("#6-32", thread=true, l=plate_thickness+8, anchor=TOP);
            }
            position("right-hole") {
                down(plate_thickness)
                cyl(d=5, l=8, anchor=TOP, chamfer1=1)
                    position(TOP)
                    cyl(d=12, l=1, anchor=TOP);
                tag("remove") screw_hole("#6-32", thread=true, l=plate_thickness+8, anchor=TOP);
            }
        }
    }
}

module non_threaded_side() {
    diff() {
        body_no_hole() {
            tag("remove") {
                for (pos = ["left-hole", "right-hole"]) {
                    position(pos)
                    cyl(d=11, l=1.5, anchor=TOP)
                        position(BOTTOM)
                        cyl(d=6, l=1.75, anchor=TOP);
                }
            }
        }
    }
}

// up(6)
threaded_side();
// down(6)
// xrot(180)
// non_threaded_side();
