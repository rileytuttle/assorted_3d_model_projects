include <BOSL2/std.scad>

$fn=10;

diff("bean-grinder-side kcup-slot") {
    cyl(l=35, d=55) {
    tag("bean-grinder-side")
    position(TOP)
    translate([0,0,0.01])
    cyl(l=20, d=49, anchor=TOP, rounding1=4)
        position(BOTTOM)
        translate([0,0,0.01])
        cyl(l=16, d=38, anchor=TOP, rounding2=-4);
        
    tag("kcup-slot") {
        position(BOTTOM)
        translate([0, 0, 2])
        cyl(l=1.25, d=51) {
        position(TOP)
        translate([0,10,0])
        cube([56, 51, 10], anchor=BACK+TOP);
        position(TOP)
        cyl(l=10, d=45, anchor=TOP);
        }
    }}
}
