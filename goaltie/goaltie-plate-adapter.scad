include <BOSL2/std.scad>
include <rosetta-stone/std.scad>


$fn=50;
plate_hole_d_inch = 1.;
plate_hole_d = plate_hole_d_inch * INCH;
goaltie_pole_d_inch = 0.60;
goaltie_pole_d = goaltie_pole_d_inch * INCH;
holder_l_inch = 6;
holder_l = holder_l_inch * INCH;
flange_d = 100;
flange_thickness = 10;

module post_holder() {
    diff() {
        cyl(d=flange_d, l=flange_thickness) {
            position(TOP) cyl(d=plate_hole_d, l=holder_l, anchor=BOTTOM)
            tag("remove") cyl(d=goaltie_pole_d, l=holder_l);
        }
    }
}

module pipe_spacer() {
    pipe_inner_d =  0.824 * INCH;
    diff() {
        cyl(d=pipe_inner_d, l=8 * INCH) {
            tag("remove") cyl(d=goaltie_pole_d, l=8*INCH);
            position(TOP) tag("remove") cyl(d1=goaltie_pole_d, d2=pipe_inner_d-1, l=20, anchor=TOP, rounding2=-0.5);
        }
    }
}

back_half(300)
pipe_spacer();
