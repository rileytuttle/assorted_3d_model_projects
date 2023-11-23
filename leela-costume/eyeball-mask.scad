include <BOSL2/std.scad>
include <rosetta-stone/std.scad>
include <rosetta-stone/hinges.scad>

$fn=30;
eyeball_diam = 60;
eyeball_spread = 60;
template_thickness = 1.25;
template_width = 3;
eye_slit_diam = 5;
eye_slit_spread = 15;
pupil_dist = 70;
leela_pupil_diam = 20;
strap_slit_width = 1.5;
strap_slit_spread = 12;
number_of_fins = 20;
hinge_circ_radius = 100;
angle_per_fin = 3;
minimum_gap = 0.4;
height_of_cut = 0.6;
top_length_of_fin = 2*tan(angle_per_fin/2) * height_of_cut + minimum_gap;
translate_up_fudge = 60;
strap_slit_fudge = 62;

module eyeball_outline() {
    slot(d=eyeball_diam, spread=eyeball_spread, h=template_thickness);
}

module support_post(l, spin=0, orient=UP) {
    cuboid([template_width, template_thickness, l], rounding=-2, edges=[TOP, BOTTOM], except=[FRONT, BACK], orient=orient, spin=spin);
}

module eye_slit_outline() {
    slot(d=eye_slit_diam+template_width*2, spread=eye_slit_spread, h=template_thickness);
}

module eye_slit() {
    slot(d=eye_slit_diam, spread=eye_slit_spread, h=template_thickness);
}

module pupil(d, l) {
    zcyl(l=l, d=d, anchor=TOP);
}

module strap_slit() {
    cube([12, 20, template_thickness], anchor=CENTER);
}

difference() {
    union() {
        eyeball_outline();
        // support_post(l=eyeball_diam-template_width*2, orient=FRONT);
        // support_post(l=eyeball_diam+eyeball_spread-template_width*2, orient=LEFT, spin=90);
        xcopies(l=pupil_dist, n=2)
        eye_slit_outline();
        // pupil(d=leela_pupil_diam+template_width*2, l=template_thickness);
        xcopies(l=strap_slit_fudge*2, n=2)
        strap_slit();
    }
    xcopies(l=strap_slit_fudge*2, n=2) {
        xcopies(l=5, n=2) {
            cube([strap_slit_width, strap_slit_spread, template_thickness+1], anchor=CENTER);
        }
    }
    xcopies(l=pupil_dist, n=2)
    eye_slit();
    translate([0, 0, template_thickness/2])
    pupil(d=leela_pupil_diam, l=0.4);
    translate([0, translate_up_fudge, 0])
    #arc_copies(n=number_of_fins, r=hinge_circ_radius, sa=-90-45, ea=-90+45) {
        // echo(str("search ", search($idx, [45, 50])));
        // if (len(search($idx, omitted_hinge_list)) == 0) {
            translate([0, 0, -template_thickness/2-0.0001])
            rotate([0, 0, 90])
            hinge_fin(
                angle_per_fin = angle_per_fin,
                cut_depth = 70,
                height_of_cut = height_of_cut,
                top_length_of_fin = top_length_of_fin,
                minimum_gap=minimum_gap,
                anchor=TOP,
                orient=DOWN);
    }
}
