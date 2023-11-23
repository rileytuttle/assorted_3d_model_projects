include <BOSL2/std.scad>
include <rosetta-stone/std.scad>

$fn=30;
eyeball_diam = 60;
eyeball_spread = 60;
template_thickness = 2;
template_width = 3;
eye_slit_diam = 10;
eye_slit_spread = 15;
pupil_dist = 60;
leela_pupil_diam = 15;
strap_slit_width = 1.5;
strap_slit_spread = 10;

module eyeball_outline() {
    diff() {
        slot(d=eyeball_diam, spread=eyeball_spread, h=template_thickness)
            tag("remove")
            slot(d=eyeball_diam-template_width*2, spread=eyeball_spread, h=template_thickness);
    }
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
    zcyl(l=l, d=d);
}

module strap_slit() {
    difference() {
        cube([10, 20, template_thickness], anchor=CENTER);
        cube([strap_slit_width, strap_slit_spread, template_thickness+1], anchor=CENTER);
    }
}

difference() {
    union() {
        eyeball_outline();
        support_post(l=eyeball_diam-template_width*2, orient=FRONT);
        support_post(l=eyeball_diam+eyeball_spread-template_width*2, orient=LEFT, spin=90);
        xcopies(l=pupil_dist, n=2)
        eye_slit_outline();
        pupil(d=leela_pupil_diam+template_width*2, l=template_thickness);
        xcopies(l=62*2, n=2)
        strap_slit();
    }
    xcopies(l=pupil_dist, n=2)
    eye_slit();
    pupil(d=leela_pupil_diam, l=template_thickness+1);
}

