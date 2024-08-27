include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn=50;

bearing_d = 22;
leg_width = 12;
thickness = 8;
shaft_d = 24;
collar_thickness = 3;
angle_between = 90;

diff() {
    collar_diam = shaft_d + collar_thickness*2;
    cyl(d=collar_diam, l=thickness) {
        // cube([bearing_d + shaft_d, leg_width, thickness], anchor=CENTER);
        zrot_copies(rots=[-angle_between/2+90, angle_between/2+90], d=bearing_d + shaft_d + 1) {
            cyl(d=leg_width, l=thickness, spin=-90)
                cube([leg_width, (bearing_d+shaft_d)/2, thickness], anchor=BACK);
            tag("remove") screw_hole("M8x1.25", thread=true, l=thickness);
        }
        // xcopies(n=2, bearing_d + shaft_d + 1) {
        //     cyl(d=leg_width, l=thickness);
        //     tag("remove") screw_hole("M8x1.25", thread=true, l=thickness);
        //     // symbolic of the bearing
        //     // cyl(d=bearing_d, l=10);
        // }
        tag("remove") cyl(d=shaft_d, l=thickness+0.1);
        fwd(collar_diam / 2)
        tag("remove") screw_hole("M4x0.7", thread=true, orient=FRONT, l=10, teardrop=true);
    }
            
        // left(bearing_d) {
        //     cyl(d=leg_width, l=thickness);
        //     cube([bearing_d/2, leg_width, thickness], anchor=LEFT);
        // }
        // right(bearing_d) {
        //     cyl(d=leg_width, l=thickness);
        //     cube([bearing_d/2, leg_width, thickness], anchor=RIGHT);
        // }
}
