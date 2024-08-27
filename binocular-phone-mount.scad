include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <rosetta-stone/std.scad>

$fn=50;

module binocular_phone_mount()
{
    overall_thickness = 12;
    diff() {
        inner_d = 1.5*INCH;
        tube(id=inner_d, wall=4, l=overall_thickness) {
            position(LEFT) tag("remove")
            cube([5, 5, overall_thickness+1], anchor=LEFT);
            position(LEFT) right(4) {
                back(5) cube([20, 5, overall_thickness], anchor=RIGHT)
                    right(2) back(2) position(FRONT+LEFT) tag("remove") nut_trap_inline(10, "1/4-20", orient=BACK, anchor=LEFT+BOTTOM)
                        position(BOTTOM)
                        cyl(d=7, l=30, anchor=CENTER);
                fwd(5) cube([20, 5, overall_thickness], anchor=RIGHT);
            }
            disp_left = 12;
            position(RIGHT)
            left(disp_left)
            cube([60+disp_left, 40, overall_thickness], anchor=LEFT) {
                position(LEFT)
                right(disp_left-4)
                tag("remove") cyl(d=inner_d, l=overall_thickness+1, anchor=RIGHT);
                down(0.5) position(BOTTOM) slot(d=3.5, h=3.5, spread=40, anchor=BOTTOM)
                position(TOP) slot(d=6, h=overall_thickness-3+1, spread=40, anchor=BOTTOM);
                tag("remove") position(RIGHT+BACK) fwd(5) right(1) teardrop(d=3, l=70, spin=90, anchor=FRONT);
            }
        }
    }
}

// back_half(s=200)
binocular_phone_mount();
