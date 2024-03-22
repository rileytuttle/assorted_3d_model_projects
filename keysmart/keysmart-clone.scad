include <BOSL2/std.scad>
include <BOSL2/rounding.scad>
include <BOSL2/screws.scad>
include <rosetta-stone/std.scad>

$fn=50;
plate_thickness = 3;
hole_dist = 3 * INCH;
module body_no_hole(mag_holes=false) {
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
        diff("mag-remove") {
            back(end_r)
            down(thickness/2)
            offset_sweep(path, l=thickness, top=os_teardrop(r=2));
            if (mag_holes) {
                xcopies(n=2, l=50) {
                    position(TOP)
                    force_tag("mag-remove")
                    magnet_cutout_cyl(6.1, 2.1, plate_thickness, anchor=TOP, layerheight=0.1);
                }
            }
        }
        children();
    }
}

module threaded_side(mag_holes=false) {
    diff() {
        body_no_hole(mag_holes=mag_holes) {
            position("left-hole") {
                down(plate_thickness)
                left(2.5)
                cyl(d=10, l=8, anchor=TOP, chamfer1=1)
                    position(TOP)
                    right(2.5)
                    cyl(d=15, l=2.75, anchor=TOP);
                tag("remove") screw_hole("#6-32", thread=true, l=plate_thickness+8, anchor=TOP);
            }
            position("right-hole") {
                down(plate_thickness)
                cyl(d=5.6, l=3, anchor=TOP) {
                    position(TOP)
                    cyl(d=15, l=0.4, anchor=TOP);
                    position(TOP)
                    tag("remove") cyl(d=4.3, l=8, anchor=TOP);
                }
                tag("remove") screw_hole("#6-32", thread=true, l=plate_thickness+8, anchor=TOP);
            }
            position(TOP)
            {
                fwd(5)
                tag("remove") text3d("EZKI", 0.2, size=10, anchor=TOP);
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

module blade_spacer(anchor=CENTER) {
    height = 1;
    diam = 15;
    attachable(size=[diam, diam, height], anchor=anchor) {
        diff() {
            cyl(d=diam, l=height)
                tag("remove") screw_hole("#6-32", thread=false, l=height+0.1);
        }
        children();
    }
}

module key_spacer(anchor=CENTER) {
    height = 4.5;
    diam1 = 12;
    diam2 = 8;
    attachable(size=[diam1, diam1, height], anchor=anchor) {
        diff() {
            cyl(d=diam1, l=height, chamfer2=1)
                tag("remove") cyl(d=4.3, l=height+0.1, chamfer=-0.5);
        }
        children();
    }
}

// module clip_spacer() {
//     attachable(size=[diam1, diam1, height], anchor=anchor) {
// }

// up(6)
// xrot(180)
// threaded_side(mag_holes=true);
    // position("left-hole")
// down(12)
// left(hole_dist/2)
// blade_spacer(anchor=BOTTOM);
// down(12)
// right(hole_dist/2)
key_spacer(anchor=BOTTOM);
// down(6)
// non_threaded_side();

// text3d("キ", 1, font="noto");
