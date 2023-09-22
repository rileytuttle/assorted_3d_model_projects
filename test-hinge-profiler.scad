include <BOSL2/std.scad>
include <rosetta-stone/std.scad>

$fn=20;

difference() {
    translate([0, 0, 3/2])
    cube([100,10,3], center=true);
    rotate([90,0,0])
    translate([0, 3, -10/2])
        hinge_profile(5, 180, 20, 3, 10, 8);
}


// span = 10;
// num_fins = 4;
// gap = (span - num_fins*2) / (num_fins-1);

// for (i=[0:num_fins-1]) {
//     translate([i*(gap+2) - span/2, 0, 0])
//     trapezoid(h=3, w1=0, w2=2, anchor=BACK+LEFT)
//         position(BACK)
//         square([0.5, 3], anchor=BACK);
// }

