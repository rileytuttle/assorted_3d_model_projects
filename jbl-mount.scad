include <BOSL2/std.scad>
include <rosetta-stone/hinges.scad>
include <rosetta-stone/std.scad>
include <BOSL2/rounding.scad>

speaker_diam = 90;
speaker_radius = speaker_diam/2;
opening = 214;
$fn=10;
speaker_top_ang = 65;
speaker_edge_width = 5.5;
full_thickness = 15;
arm_thickness = 5;
module speaker_sim() {
    rotate_extrude()
        rect([speaker_radius, opening/2], anchor=BOTTOM+LEFT)
        position(TOP+RIGHT)
        trapezoid(w2=speaker_edge_width, h=4.5, ang=[speaker_top_ang,90], anchor=BOTTOM+RIGHT);
}

module make_half() {
    height=opening/2+4.5+5;
    difference() {
        rotate([90, 0, 0])
        translate([speaker_radius+arm_thickness, 0, 0])
        offset_sweep(rect([arm_thickness+11, height], rounding=[3, 3, 0, 0]), height=13, anchor=FRONT+RIGHT);
        speaker_sim();
    }
}


module speaker_mount() {
    difference() {
        union() {
            make_half();
            mirror([0, 0, 1]) make_half();
            rotate([90,0,0])
            translate([speaker_radius+arm_thickness,0,0])
            offset_sweep(rect([full_thickness-arm_thickness,130], rounding=[5,0,0,5], anchor=CENTER), height=13, anchor=LEFT) {
                position(BACK+LEFT)
                fillet(l=13, r=5);
                position(FRONT+LEFT)
                fillet(l=13, r=5, spin=-90);
            }
        }
        translate([speaker_radius + full_thickness/2, 0,0])
        // zcopies((130-30)/3, 4) rotate([90, 0, 0]) cyl(l=13.01, d=15, rounding=-2, teardrop=true);
        zcopies(70, 2) slot(d=10, h=13, spread=35, round_radius=2, orient=FRONT, spin=90);
    }
}

difference() {
    speaker_mount();
    translate([speaker_radius+2, 0, 90])
    hinge_profile(50, 30, 5, 13, 10, layer_height=0.5, orient=LEFT, minimum_gap=0.4);
    translate([speaker_radius+2, 0, -90])
    hinge_profile(50, 30, 5, 13, 10, layer_height=0.5, orient=LEFT, minimum_gap=0.4);
    translate([speaker_radius+6.5, 0, 0])
    hinge_profile(10, 17, full_thickness, 13, 10, layer_height=1.5, orient=LEFT, minimum_gap=0.4);
}

