include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn=50;

module pulley(anchor=CENTER, orient=UP, spin=0) {
    id=22.1;
    bearing_thickness = 7;
    filament_diam = 1.75;
    filament_r = filament_diam /2;
    full_diam = id+5;
    angle = 30;
    // path=turtle([
    //     "move", full_diam-id,
    //     "left", 90+45,
    //     "untily", bearing_thickness/2 - filament_r,
    //     "left", 45,
    //     "arcright", filament_r, 180,
    // ]);
    path=turtle([
        "move", full_diam-id,
        "left", 90+angle,
        "untily", bearing_thickness/2,
        "right", 90-angle,
        "untily", 2*bearing_thickness/2,
        "left", 90+angle,
        "untilx", 0,
    ]);
    // stroke(apply(translate([id/2, -bearing_thickness/2]), path), width=1);
    attachable(spin=spin, anchor=anchor, orient=orient, size=[full_diam, full_diam, bearing_thickness])
    {
        rotate_extrude() {
            polygon(apply(translate([id/2, -bearing_thickness/2]), path));
        }
        children();
    }
}

module filament_guide(arc_r, arc_a, thickness=1, spin=0, anchor=CENTER, orient=UP) {
    center_shift = arc_r * sin(arc_a/2);
    path = turtle([
        "left", 90,
        "arcright", arc_r, arc_a,
    ]);
    attachable(spin=spin, orient=orient, anchor=anchor) {
        left(center_shift)
        zrot(-(90-arc_a/2))
        linear_extrude(7+2) {
            stroke(path, width=thickness);
        }
        children();
    }
}

module base_plate() {
    // side_space = 8;
    // x_spacing = (size[0]-(side_space*2)) / 3;  // leave space either side
    // y_spacing = (size[1]-(side_space*2));
    x_spacing = 24.5;
    y_spacing = 21;
    side_space = 8;
    show_pulley=false;
    size = [side_space*2 + x_spacing*3, side_space*2 + y_spacing, 5];
    pulley_locs = [
        [side_space, y_spacing/2, 0],
        [side_space+x_spacing, -y_spacing/2, 0],
        [side_space+2*x_spacing, y_spacing/2, 0],
        [side_space+3*x_spacing, -y_spacing/2, 0],
    ];
    diff() {
        cube(size, anchor=CENTER) {
            position(LEFT+TOP) {
                move_copies(pulley_locs) {
                    cyl(d=15, l=2, anchor=BOTTOM) {
                        position(TOP)
                        tag("remove")
                        screw_hole("M8", thread=true, anchor=TOP, l=size[2]+2+1)
                        if (show_pulley) {
                            position(TOP)
                            #pulley(anchor=BOTTOM);
                        }
                    }
                }
                guide_r = 18;
                guide_a = 45;
                translate(pulley_locs[1])
                back(guide_r)
                color_this("blue")
                filament_guide(arc_r=guide_r, arc_a=guide_a, thickness=3, anchor=BOTTOM);
                translate(pulley_locs[2])
                fwd(guide_r)
                color_this("blue")
                filament_guide(arc_r=guide_r, arc_a=guide_a, thickness=3, anchor=BOTTOM, spin=180);
            }
        }
    }
}

base_plate();
// pulley();
