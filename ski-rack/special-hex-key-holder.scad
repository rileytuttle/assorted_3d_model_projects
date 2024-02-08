include <BOSL2/std.scad>
include <rosetta-stone/std.scad>

$fn=50;

diff() {
    cube([6, 8, 20], anchor=BOTTOM) {
        tag("remove")
        hexagon3d(minor_width=4.1, height=21, spin=15);
        position(FRONT+BOTTOM)
        cuboid([6, 6, 6], anchor=BOTTOM+BACK, rounding=1, edges=[FRONT+BOTTOM, FRONT+TOP], teardrop=true) {
            position(BACK+TOP)
            fillet(l=6, r=3, orient=RIGHT, spin=180);
            tag("remove")
            fwd(8) cyl(d=25, l=2.5, orient=RIGHT);
            tag("remove")
            teardrop(ang=60, d=2.7, l=7, spin=90);
            // cyl(d=2.7, l=7, orient=RIGHT);
        }
    }
}
