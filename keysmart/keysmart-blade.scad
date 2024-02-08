include <BOSL2/std.scad>
include <rosetta-stone/std.scad>
include <BOSL2/screws.scad>
include <BOSL2/rounding.scad>

$fn=30;

screw_to_screw_dist = 96;
blade_slot_length = 75;
distance_between_locks = 23;
distance_from_blade_tip_to_first_notch = 27;
distance_between_notches = 5.5;
center_notch_from_blade_top = 2;
blade_channel_length = 65;
body_length = blade_channel_length+3;
top_body_meat = 9;
blade_height = 19.25;
body_height = blade_height + 3 + top_body_meat;
blade_bottom_length = 61;
blade_top_length = 31;
blade_thickness = 1.4;
blade_x = (blade_bottom_length - blade_top_length)/2;
blade_h = sqrt(blade_height^2 + blade_x^2);
blade_ang = atan(blade_x/blade_height);

module blade_channel(length, anchor=CENTER, orient=UP, spin=0) {
    channel_length_extra = length - blade_bottom_length;
    shrinkage = 1;
    small_blade_height = blade_height-shrinkage*2;
    little_extra = tan(blade_ang)*shrinkage;
    small_blade_h = small_blade_height / cos(blade_ang);
    // echo(str("small blade h ", small_blade_h));
    path1 = turtle([
        "left", 90,
        "move", blade_height,
        "right", 90,
        "move", blade_x+blade_top_length+channel_length_extra,
        "right", 90-blade_ang,
        "move", blade_h,
        "right", 90 + blade_ang,
        // "move", blade_bottom_length,
        ]);
    size = [length, blade_height, blade_thickness];
    
    chamfer_width = 2;
    anchor_list = [
        named_anchor("attachpoint1", [chamfer_width, blade_height/2, 2.5]),
        named_anchor("bottomright", [length, 0, 0]),
        named_anchor("notch", [length-blade_x-35-1, blade_height+1.75, 0]),
    ];
    attachable(spin=spin, orient=orient, anchor=anchor, size=size, anchors=anchor_list) {
        offset_sweep(path1, height=2.5, top=os_chamfer(width=chamfer_width, height=1.5));
        children();
    }
}

module keyblade() {

    diff() {
    cuboid([screw_to_screw_dist, 23, 4.25]) {
            xcopies(l=75, n=2) {
                tag("remove")
                cyl(d=6.2, l=10);
                tag("remove")
                position(BOTTOM)
                translate([0, 0, 1.5])
                cyl(d=11, l=10, anchor=BOTTOM);
            }
            tag("remove")
            position(BOTTOM+LEFT)
            // translate([0, 0, 0 -95/2+50/2-0.1, 0, 3])
            translate([-0.1, 0, 3])
            blade_channel(blade_slot_length, anchor=BOTTOM+LEFT);
            // position(BOTTOM)
            // translate([-95/2+50/2-0.1, 0, 3])
            // trapezoid3d(bottomwidth=19, topwidth=15, height=60, length=1.5, spin=90, anchor=BOTTOM);
        }
    }
}

module spring_lock_cutout(thickness, anchor=CENTER, orient=UP, spin=0, just_first_part=false) {
    left_move = 12;
    first_arc_r = 1;
    // first_arc_r = 0;
    second_arc_r = 3;
    up_move_1 = 2;
    // up_move_1 = 0;
    up_move = 10;
    stroke_thickness = 1;
    down_move = 0.75;
    third_arc_r = 5;
    attachable(spin=spin, orient=orient, anchor=anchor, size=[0, 0, thickness]) {
        if (just_first_part) {
            path = turtle(["left", 180, "move", up_move, "arcleft", second_arc_r, 90]);
            down(thickness/2)
            back(up_move)
            left(second_arc_r)
            linear_extrude(thickness) {
                zrot(90)
                stroke(path, width=stroke_thickness);
            }
        }
        else
        {

            path = turtle(["left", 90, "arcright", third_arc_r, 90, "move", up_move_1, "arcleft", first_arc_r, 90, "move", left_move, "left", 90, "move", down_move, "arcright", second_arc_r, 180, "move", up_move]);
            // path2 = turtle(["move", up_move_1+10]);
            back(down_move)
            down(thickness/2)
            fwd(first_arc_r+up_move_1+third_arc_r)
            right(left_move+first_arc_r+second_arc_r+third_arc_r)
            linear_extrude(thickness) {
                zrot(90)
                    stroke(path, width=stroke_thickness);
                // if (false) {
                //     right(4)
                //     zrot(90)
                //         stroke(path2, width=stroke_thickness);
                // }
            }
        }
        children();
    }
}

module spring_lock_cutouts() {
    fwd(center_notch_from_blade_top) {
        left(4)
        spring_lock_cutout(thickness=6, anchor=TOP, just_first_part=true);
        left(distance_from_blade_tip_to_first_notch)
        spring_lock_cutout(thickness=6, anchor=TOP)
            cyl(d=2.7, l=6);
        left(distance_from_blade_tip_to_first_notch+distance_between_locks)
        spring_lock_cutout(thickness=6, anchor=TOP)
            cyl(d=2.7, l=6);
    }
}

module snap_notch(d, thickness, shrink=0.9, spin=0, orient=UP, anchor=CENTER) {
    attachable(anchor=anchor, spin=spin, orient=orient, size=[d, 0, thickness]) {
        cyl(d=d, l=thickness, anchor=CENTER)
            position(CENTER)
            cube([d*shrink, 10, thickness], anchor=FRONT);
        children();
    }
}

module snap_arm(joint_d, snap_d, thickness, length, neck_length, cutout_thickness, neck_shrink=0.85, spin=0, orient=UP, anchor=CENTER) {
    anchor_list = [
    ];
    attachable(anchor=anchor, spin=spin, orient=orient, size=[0, 0, thickness], anchors=anchor_list) {
        diff() {
            cyl(d=joint_d, l=thickness) {
                cube([length, joint_d, thickness], anchor=RIGHT)
                    position(LEFT+BACK)
                    cube([snap_d*neck_shrink, joint_d+neck_length, thickness], anchor=BACK)
                        position(FRONT)
                        cyl(d=snap_d*0.95, l=thickness);
                position(TOP)
                tag("remove")
                screw_hole("M3", thread=false, l=thickness+1, anchor=TOP, head="flat");
                tag("remove")
                position(BOTTOM)
                cyl(d=joint_outer_diam*1.1, l=cutout_thickness, anchor=BOTTOM);
            }
        }
        children();
    }
}

joint_outer_diam = 7;
thickness = 3;
arm_length=16;
neck_length = 3;
module utility_knife() {
    diff() {
        cube([body_length, body_height, thickness], anchor=CENTER) {
            tag("remove")
            up(0.1)
            left(0.01)
            back(3) // width of edge on the bottom
            position(TOP+LEFT+FRONT)
            blade_channel(length=blade_channel_length, anchor=TOP+LEFT+FRONT) {
                // fwd(3)
                // position(BACK+RIGHT+TOP)
                // left(distance_between_locks+distance_from_blade_tip_to_first_notch)
                // snap_notch(4, thickness+1, anchor=TOP);
                // position(BACK+RIGHT)
                // left(distance_from_blade_tip_to_first_notch+distance_between_locks)
                // fwd(2)
                // #cyl(d=5, l=thickness+1);
            }
            tag("remove")
            up(0.01)
            position(BACK+RIGHT+TOP)
            left(distance_between_locks+distance_from_blade_tip_to_first_notch-arm_length + 3)
            fwd(joint_outer_diam/2) // enough space for a hinging mechanism
                cyl(d=2.7, l=thickness+1, anchor=TOP) {
                    fwd(joint_outer_diam/2+0.2)
                    left(joint_outer_diam/2)
                    cube([arm_length-3, 10, thickness+1], anchor=RIGHT+FRONT);
                    position(TOP)
                    left(joint_outer_diam / 2)
                    back(joint_outer_diam / 2)
                    fillet(d=joint_outer_diam, l=thickness+1, spin=-90, anchor=TOP);
                    left(arm_length)
                    fwd(neck_length+joint_outer_diam/2)
                    snap_notch(4, thickness+1);
                    // tag("keep")
                    // up(6)
                    // position(TOP)
                    // snap_arm(joint_outer_diam, 4, thickness+1, arm_length, neck_length, anchor=TOP);
                }
                
        }
    }
}

// utility_knife();
// keyblade();
// blade_channel(blade_slot_length);
// spring_lock_cutout(thickness=6, just_first_part=true) show_anchors();
// up(10)
// back(10)
// snap_arm(joint_outer_diam, 4, thickness=6, cutout_thickness=thickness, length=arm_length, neck_length=neck_length, anchor=TOP);

module spring_lock_cutout_v2(spin=0, orient=UP, anchor=CENTER, remove_extra=true, extra_height=2) {
    bendable_length = 25;
    small_arc = 1;
    big_arc = 2;
    peg_length = 3.5;
    path = turtle([
        "left", 180,
        "move", bendable_length-small_arc,
        "arcleft", small_arc, 90,
        "move", peg_length,
        "arcright", big_arc, 180,
        "move", peg_length,
        "arcleft", small_arc, 90,
        "move", 15,
        ]);
    anchor_list = [
        named_anchor("notch", [0, -peg_length/2-small_arc/2, 5]),
    ];
    attachable(spin=spin, orient=orient, anchor=anchor, size=[0, 0, 10], anchors = anchor_list)
    {
        down(5)
        union() {
            right(bendable_length+big_arc)
            linear_extrude(10) {
                stroke(path, width=0.6);
            }
            if (remove_extra) {
                position(TOP)
                up(5)
                back(0.5)
                cuboid([4.5, extra_height, 4.25], anchor=TOP+FRONT, rounding=-1.5, edges=[TOP+LEFT, TOP+RIGHT], orient=BACK);
            }
        }
        children();
    }
}

module triangle_clip_hole(height, width, thickness, spin=0, anchor=CENTER, orient=UP) {
    assert(height != undef || width != undef);
    assert(height == undef ? width != undef : width == undef);
    h = height == undef ? width/tan(blade_ang) : height;
    w = width == undef ? height * tan(blade_ang) : width;
    rounded_triangle = round_corners(right_triangle([w, h], spin=180), r=[1, 3, 1]);
    attachable(spin=spin, orient=orient, anchor=anchor, size=[w, h, thickness]) {
        down(thickness/2)
        offset_sweep(rounded_triangle, height=thickness, top=os_chamfer(width=-1), bottom=os_chamfer(width=-1));
        children();
    }
}

module main_body(full_thickness, solid_thickness, length, height, top_part_height, spin=0, orient=UP, anchor=CENTER) {
    small_chamfer_width = 1;
    top_chamfer=1.5;
    path1 = round_corners(rect([length, height], anchor=LEFT+FRONT), r=4.5);
    path2 = round_corners(rect([length-top_chamfer, 24], anchor=LEFT+FRONT), r=4.5);
    attachable(spin=spin, orient=orient, anchor=anchor, size=[length, height, full_thickness]) {
        down(full_thickness/2)
        left(length/2)
        fwd(height/2)
        offset_sweep(path1, height = full_thickness - top_part_height, bottom=os_chamfer(width=small_chamfer_width), $fn=50) {
            up(full_thickness-top_part_height + top_part_height/2)
            rounded_prism(path1, apply(translate([0, top_chamfer, 0]), path2), height=top_part_height);
        }
        children();
    }
}

module modded_other_knife() {
    solid_thickness = 2.5;
    top_part_height = 1.5;
    height_above_solid = 2.5;
    full_thickness = solid_thickness + height_above_solid;
    spring_thin_thickness = 3.5;
    slot_path = glued_circles(d=3.4, spread=4.5, tangent=0, spin=90);
    full_length = 65;
    // full_height = 31; 
    // blade_channel_y_offset = 3;
    full_height = 27.5;
    blade_channel_y_offset = 2;
    clip_hole = true;
    keysmart_hole = false;
    magnet = true;

    diff() {
        main_body(full_thickness, solid_thickness, full_length, full_height, top_part_height) {
            // make springy guy thinner
            if (true) {
                position(BACK+LEFT+BOTTOM)
                tag("remove")
                up(spring_thin_thickness)
                right(35)
                cuboid([30, full_height - blade_height-blade_channel_y_offset-2, 2], rounding=2, edges=[BOTTOM+LEFT, BOTTOM+RIGHT], anchor=BOTTOM+RIGHT+BACK);
            }
            
            // remove blade channel
            tag("remove")
            position(FRONT+LEFT+BOTTOM)
            up(solid_thickness)
            back(blade_channel_y_offset)
            right(full_length-2)
            blade_channel(65, anchor="bottomright") {
                // remove spring cutout
                position("notch")
                up(height_above_solid)
                spring_lock_cutout_v2(anchor=TOP, remove_extra=true, extra_height = full_thickness - spring_thin_thickness)
                    tag("keep")
                    position("notch")
                    offset_sweep(slot_path, height=2.5, anchor=TOP, top=os_circle(r=1));

                if (magnet) {
                    // magnet cutout
                    position("bottomright")
                    down(0.21) // multiple of 0.2 layer height
                    left(14.5)
                    back(9)
                    zrot(blade_ang)
                    ycopies(n=2, l=6) {
                        cyl(d=5.1,l=1.95, anchor=TOP) {
                            position(BOTTOM)
                            cyl(d=2, l=10, anchor=TOP);
                            position(TOP)
                            intersection() {
                                cube([5.1, 2, 10], anchor=CENTER+BOTTOM);
                                cyl(d=5.1, l=10, anchor=BOTTOM);
                            }
                       }
                    }
                }
            }
            if (clip_hole) {
                // clip hole
                tag("remove")
                position(TOP+RIGHT+BACK)
                fwd(4.5)
                left(3.5)
                triangle_clip_hole(height=17, thickness=full_thickness, anchor=TOP);
            }
            else if (keysmart_hole) {
                // keysmart_hole
                tag("remove")
                position(TOP+RIGHT)
                left(6)
                cyl(d=4.5, l=full_thickness, chamfer=-1, anchor=TOP);
            }
        }
    }
}

modded_other_knife();
// main_body(5.5, 3, 65, 31, 1.5);
// triangle_clip_hole(height=17, thickness=5.5);

