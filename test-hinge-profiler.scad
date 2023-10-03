include <BOSL2/std.scad>
include <rosetta-stone/hinges.scad>

$fn=20;

diff("remove") {
    cube([100,10,3], anchor=BOTTOM)
    tag("remove")
    position(BOTTOM)
    hinge_profile(5, 180, 20, 3, 10.01, 8, anchor=BOTTOM);
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
