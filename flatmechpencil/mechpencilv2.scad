include <BOSL2/std.scad>
include <rosetta-stone/std.scad>
include <rosetta-stone/compliant-fins.scad>

$fn=50;

pencil_thickness = 4;
pencil_length = 100;
pencil_width = 15;
lead_thickness = 0.9;
lead_cutout_thickness = lead_thickness+0.3;

module collet_shape(orient=UP) {
    ang=70;
    attachable(orient=orient) {
        teardrop(d=3, l=2, chamfer2=0.5, anchor=FRONT, ang=ang)
            position(BACK)
            teardrop(d=2, l=2.5, anchor=FRONT, ang=ang);
        children();
    }
}

module main_pencil_body() {
    attachable(size=[pencil_width, pencil_length, pencil_thickness]) {
        // bottom_half()
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
fin_ang = 25;
fin_thickness = 0.5;
fin_n = 25;
fin_length = 4;
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

module collet_mock_up(orient=UP) {
    attachable(orient=orient) {
        cyl(d=3, l=2, anchor=TOP)
            position(BOTTOM) cyl(d=2, l=6, anchor=TOP)
                position(BOTTOM) cyl(d=2.5, l=3, anchor=TOP);
        children();
    }
}

module pencil_body() {
    union() {
        difference() {
            diff() {
                main_pencil_body() {
                    tag("remove")
                    teardrop(d=lead_cutout_thickness, l=pencil_length + 1); 
                    position(FRONT)
                    back(10)
                    tag("remove") collet_shape()
                        cuboid([3, 5, pencil_thickness+1], anchor=BACK, chamfer=0.5, edges=[FRONT+LEFT, FRONT+RIGHT]);
                }
            }
            fwd(pencil_length/2)
            back(14.5)
            lead_tube_cutout_shape(anchor=FRONT)
                position(FRONT)
                back(move_gap)
                teardrop(d=2.5, l=3, anchor=FRONT, ang=60, chamfer1=-0.25);
        }
        // fwd(6)
        back(1)
        {
            left(3.5)
            multiple_fins(n=fin_n, spread=tube_length-10, height=fin_length, width=pencil_thickness, thickness=0.5, angle=-fin_ang, spin=90);
            right(3.5)
            multiple_fins(n=fin_n, spread=tube_length-10, height=fin_length, width=pencil_thickness, thickness=0.5, angle=fin_ang, spin=90);
        }
    }
}

pencil_body();
// fwd(40)
// #collet_mock_up(orient=FRONT);
// collet_shape();
// lead_tube_cutout_shape();

