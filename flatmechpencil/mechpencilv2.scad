include <BOSL2/std.scad>
include <rosetta-stone/std.scad>
include <rosetta-stone/compliant-fins.scad>
include <BOSL2/screws.scad>

$fn=50;

pencil_thickness = 4;
pencil_length = 115;
pencil_width = 17;
lead_thickness = 0.9;
lead_cutout_thickness = lead_thickness+0.2;
collet_press_fit_d = 2.5;
collet_ring_d = 3.5;
pencil_lead_length = 60;

module collet_shape(orient=UP) {
    first_d = collet_ring_d;
    second_d = collet_press_fit_d;
    chamfer = (first_d - second_d)/2;
    ang=70;
    attachable(orient=orient) {
        // teardrop(d=first_d, l=2, chamfer2=chamfer, anchor=FRONT, ang=ang) {
        teardrop(d=first_d, l=2.5, anchor=FRONT, ang=ang) {
            position(BACK)
            teardrop(d=second_d, l=2.5, anchor=FRONT, ang=ang);
            position(FRONT)
            cuboid([1.5, 4.5, 10], anchor=FRONT+BOTTOM);
        }
        children();
    }
}

module collet_press_fit_cutout() {
    tab_width = 1;
    first_gap_w = 2-tab_width;
    second_gap_w = 3;
    gap_d = 2.75;
    tab_d = 2.25;
    chamfer = (gap_d-tab_d)/2;
    ang=60;

    attachable() {
        back(tab_width/2)
        teardrop(d=tab_d+0.1, l=tab_width, chamfer=-chamfer, ang=ang)
            position(BACK)
            teardrop(d=gap_d, l=first_gap_w, ang=ang, anchor=FRONT)
                position(BACK)
                teardrop(d=tab_d, l=tab_width, chamfer=-chamfer, ang=ang, anchor=FRONT)
                    position(BACK)
                    teardrop(d=gap_d, l=second_gap_w, ang=ang, anchor=FRONT, chamfer2=1);
        children();
    }
}

module main_pencil_body() {
    attachable(size=[pencil_width, pencil_length, pencil_thickness]) {
        // bottom_half()
        // top_half()
        // left_half()
        intersect() {
            cuboid([pencil_width, pencil_length, pencil_thickness], anchor=CENTER, chamfer=0.5) {
                tag("intersect")
                position(FRONT)
                fwd(1)
                cyl(d1=pencil_width+1, d2=0, h=10, orient=FRONT, anchor=TOP)
                    position(BOTTOM)
                    cube([pencil_width+1, pencil_thickness+1, pencil_length], anchor=TOP);
            }
        }
        children();
    }
}

move_gap = 3.5;
tube_length = 75;
fin_ang = 20;
// fin_thickness = 0.6;
fin_n = 10;
fin_length = 4.75;
module lead_tube_cutout_shape(anchor=CENTER) {
    side_width = 2;
    full_length = tube_length;
    vertical_gap = fin_length;
    full_width = pencil_width+1;
    tube_width = pencil_width-2*vertical_gap - 2*side_width;
    fudge_width = 0.1;
    sides_size = [(full_width - tube_width - 2*vertical_gap)/2 + fudge_width, full_length-move_gap + fudge_width, pencil_thickness+2];
    attachable(anchor=anchor, size=[full_width, full_length, pencil_thickness+1]) {
        diff() {
            cube([full_width, full_length, pencil_thickness+1], anchor=CENTER)
                tag("remove") {
                    position(FRONT+LEFT) left(fudge_width) fwd(fudge_width) cuboid(sides_size, anchor=LEFT+FRONT); 
                    position(FRONT+RIGHT) right(fudge_width) fwd(fudge_width) cuboid(sides_size, anchor=RIGHT+FRONT);
                    position(FRONT) back(move_gap) cuboid([tube_width, full_length-move_gap+fudge_width, pencil_thickness+2], anchor=FRONT);
                }
        }
        children();
    }
}

module lead_tube_cutout_shape_v3(anchor=CENTER) {
    side_width = 2;
    full_length = pencil_length;
    slide_gap = 0.3;
    vertical_gap = 1;
    full_width = pencil_width+1;
    tube_width = pencil_width-2*vertical_gap - 2*side_width;
    fudge_width = 0.1;
    sides_size = [(full_width - tube_width - 2*vertical_gap)/2 + fudge_width, full_length + fudge_width, pencil_thickness+2];
    attachable(anchor=anchor, size=[full_width, full_length, pencil_thickness+1]) {
        back(move_gap)
        union() {
            xrot(-90)
            linear_extrude(pencil_length-30)
            diff() {
                triangle_y = 1.5;
                triangle_y2 = 1.5;
                left(5)
                rect([slide_gap, pencil_thickness], anchor=LEFT) {
                    position(RIGHT) {
                        right_triangle([triangle_y, pencil_thickness/2], anchor=LEFT+FRONT);
                        yflip() right_triangle([triangle_y, pencil_thickness/2], anchor=LEFT+FRONT);
                    }
                    tag("remove")
                    position(LEFT) {
                        right_triangle([triangle_y2, pencil_thickness/2], anchor=LEFT+FRONT);
                        yflip() right_triangle([triangle_y2, pencil_thickness/2], anchor=LEFT+FRONT);
                    }
                }
                right(5)
                xflip()
                rect([slide_gap, pencil_thickness], anchor=LEFT) {
                    position(RIGHT) {
                        right_triangle([triangle_y, pencil_thickness/2], anchor=LEFT+FRONT);
                        yflip() right_triangle([triangle_y, pencil_thickness/2], anchor=LEFT+FRONT);
                    }
                    tag("remove")
                    position(LEFT) {
                        right_triangle([triangle_y2, pencil_thickness/2], anchor=LEFT+FRONT);
                        yflip() right_triangle([triangle_y2, pencil_thickness/2], anchor=LEFT+FRONT);
                    }
                }
            }
            cube([10, move_gap, pencil_thickness], anchor=BACK);
        }
        children();
    }
}

module collet_mock_up(orient=UP) {
    attachable(orient=orient) {
        cyl(d=collet_ring_d, l=2, anchor=TOP)
            position(BOTTOM) cyl(d=2, l=6, anchor=TOP)
                position(BOTTOM) cyl(d=2.5, l=3, anchor=TOP);
        children();
    }
}

module pencil_body_v2() {
    union() {
        difference() {
            diff() {
                main_pencil_body() {
                    tag("remove")
                    teardrop(d=lead_cutout_thickness, l=pencil_length + 1); 
                    position(FRONT)
                    back(10)
                    tag("remove") collet_shape() {
                        cuboid([3, 5, pencil_thickness+0.01], anchor=BACK, chamfer=0.5, edges=[FRONT+LEFT, FRONT+RIGHT]);
                        cuboid([3, 5, pencil_thickness+0.01], anchor=BACK, chamfer=-2.5, edges=[FRONT+TOP]);
                    }
                }
            }
            fwd(pencil_length/2)
            back(14.5)
            lead_tube_cutout_shape(anchor=FRONT)
                position(FRONT)
                back(move_gap)
                teardrop(d=collet_press_fit_d, l=3, anchor=FRONT, ang=60, chamfer1=-0.5);
        }
        // fwd(6)
        back(2)
        {
            disp = 4.125;
            left(disp)
            multiple_fins(n=fin_n, spread=tube_length-10, height=fin_length, width=pencil_thickness, thickness=0.5, angle=-fin_ang, spin=90);
            right(disp)
            multiple_fins(n=fin_n, spread=tube_length-10, height=fin_length, width=pencil_thickness, thickness=0.5, angle=fin_ang, spin=90);
        }
    }
}

module compliant_spring(spin=0) {
    fin_ang=10;
    gap=0.3;
    thickness=2;
    width=pencil_thickness;
    fin_n=4;
    fin_space = 2;
    fin_thickness = 0.8;
    fin_height=pencil_width-thickness-gap-2*2;
    clear_space=4.5;
    up_move = 6;

    hyp = (fin_height - gap) / cos(fin_ang);
    x_disp = hyp * sin(fin_ang);
    quarter_move = (fin_thickness+fin_space/2) * fin_n / 4 + thickness/2;
    half_move = quarter_move * 2;
    path = turtle([
        "left", 90,
        "move", up_move,
        "right", fin_ang,
        "move", quarter_move,
        "right", 90-fin_ang,
        "move", clear_space,
        "right", 90-fin_ang,
        "move", hyp,
        "left", 90-fin_ang,
        "move", half_move,
        "left", 90-fin_ang,
        "move", hyp,
        "right", 90-fin_ang,
        "move", quarter_move+thickness/2,
        "right", 90-fin_ang,
        "move", quarter_move,
        "right", fin_ang,
        "move", up_move,
        ]);
    attachable(spin=spin) {
        union() {
            fwd(up_move+quarter_move*cos(fin_ang))
            path_extrude2d(path, caps=false) {
                rect([thickness, width], anchor=CENTER);
            }
            right(clear_space/2) {
                left(0.2)
                fwd(thickness/2)
                multiple_fins(fin_n/4, spacing=fin_space+0.25, height=fin_height, width=width, thickness=fin_thickness, angle=fin_ang, anchor=BACK);
                back(thickness/2+gap)
                right(quarter_move + half_move)
                right(x_disp)
                left(3.5)
                multiple_fins(fin_n/2, spacing=fin_space+0.25, height=fin_height, width=width, thickness=fin_thickness, angle=-fin_ang, anchor=BACK);
                fwd(thickness/2)
                right(2 * half_move+quarter_move)
                right(x_disp/2)
                left(2)
                multiple_fins(fin_n/4, spacing=fin_space+0.25, height=fin_height, width=width, thickness=fin_thickness, angle=fin_ang, anchor=BACK);
            }
        }
        children();
    }
}

module fin_and_click_button_pocket() {
    attachable() {
        diff() {
            cube([pencil_width+1, move_gap, pencil_thickness+1], anchor=BACK) {
                position(FRONT)
                cube([pencil_width-2*2, 20, pencil_thickness+1], anchor=BACK);
                position(BACK)
                    tag("remove")
                    fwd(1.75)
                    cyl(d=20, l=pencil_thickness+1, anchor=FRONT);
            }
        }
        children();
    }
}

module lead_storage_tube() {
    intersect()
    {
        xrot(-90)
        linear_extrude(pencil_lead_length+5) {
            trapezoid(h=3, w1=1, w2=4.5);
        }
        tag("intersect")
        fwd(1)
        cyl(d1=6, d2=0, l=10, anchor=TOP, orient=FRONT)
            position(BOTTOM)
            cube([200, 200, 200], anchor=TOP);
        
        
        //     tag("intersect")
        //         position(FRONT)
        //         fwd(1)
        //         cyl(d1=5, d2=0, l=5, anchor=TOP, orient=FRONT)
        //             position(BOTTOM)
        //             cube([100, 100, 100], anchor=TOP);
        // }
    }
}

module pencil_body_v3() {
    lead_tube_thickness = 2;
    diff("remove1") {
        main_pencil_body() {
            tag("remove1")
            position(FRONT)
            teardrop(d=lead_cutout_thickness, l=30, anchor=FRONT);
            position(FRONT)
            back(10)
            tag("remove1") collet_shape() {
                cuboid([collet_ring_d, 4, pencil_thickness+0.01], anchor=BACK, chamfer=0.5, edges=[FRONT+LEFT, FRONT+RIGHT]);
            }
            position(FRONT)
            tag("remove1")
            back(move_gap + 11)
            lead_tube_cutout_shape_v3()
                back(move_gap)
                collet_press_fit_cutout();
            position(BACK)
            fwd(5)
            tag("remove1")
            fin_and_click_button_pocket()
                fwd(18.5)
                tag("keep")
                trapezoid3d(bottomwidth=8, topwidth=6.25, length=move_gap+1.5, height=pencil_thickness, orient=FRONT);
            tag("remove1")
            fwd(33)
            #lead_storage_tube();
        }
        tag("keep")
        back(29.75)
        back(move_gap)
        left(5.2)
        compliant_spring(spin=90);
        // remove two cylinders to help build
        // tag("remove")
        // xcopies(n=2, l=6)
        // fwd(10)
        // #cyl(d=3, l=pencil_thickness);
    }
}

module full_lead_mock() {
    full_length = 60;
    diam = 0.9;
    attachable(size=[diam, diam, full_length])
    {
        cyl(d=diam, l=full_length, orient=FRONT);
        children();
    }
}

// bottom_half()
// pencil_body_v3();

// fwd(40)
// #collet_mock_up(orient=FRONT);
// collet_shape();
// lead_tube_cutout_shape_v3();
// up(10)
// left(3)
// fwd(10)
// #full_lead_mock();

// collet_press_fit_cutout();
// compliant_spring();
// fin_and_click_button_pocket();

// lead_storage_tube();

module screw_clamp() {
    screw("M3", l=5);
    right(5)
    screw_hole("M3", l=5, thread=true);
}
screw_clamp();
