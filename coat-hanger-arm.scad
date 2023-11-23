include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <rosetta-stone/std.scad>

$fn=10;

module nub(anchor=CENTER, spin=0, orient=UP) {
    attachable(anchor=anchor, spin=spin, orient=orient, size=[25, 25, 6]) {
        cyl(l=6, d=25, rounding=3) {
            position(TOP)
            cyl(d=16, l=9, rounding1=-2, anchor=BOTTOM, teardrop=true);
            position(BOTTOM)
            cyl(d=16, l=9, rounding2=-2, anchor=TOP, teardrop=true);
        }
        children();
    }
}

diff ("screw-hole flat-side") {
    teardrop(d=16, l=150, orient=FRONT, ang=90-35) {
    // cyl(d=16, l=150) {
        for (i=[-40, 40]) {
            rotate([90, 0, 0])
            translate([0, 0, i])
            nub();
        }
        position(BACK)
        sphere(d=25);
        // tag("screw-hole") {
        //     position(FRONT)
        //     screw_hole("1/4-20", length=5, thread="none", anchor=BOTTOM, oversize=-0.1, orient=BACK) {
        //         // position(TOP) nut_trap_side(30, "1/4-20", thickness=5.5)
        //         position(TOP) nut_trap_side(30, thickness=5.5, nutwidth=in_to_mm(7/16), spin=-90)
        //             position(BOTTOM) cube([in_to_mm(0.25), 20, 5.1], anchor=TOP+BACK, spin=90);
        //     }
        // }
        tag("flat-side") {
            position(TOP)
            translate([0, 0, 0.5])
            cube([30,16,200], anchor=BACK, orient=BACK);
        }
        tag("screw-hole")
        position(FRONT)
        teardrop(d=4.75, l=20, anchor=FRONT, orient=DOWN, ang=90-40);
    }
}
