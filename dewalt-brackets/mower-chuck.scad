include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn = 50;

// key is 4.5, 2.5-2.7

diff() {
    xcopies(n=2, l=50) cyl(d=35, l=8);
    cube([50, 35, 8], anchor=CENTER) {
        position(BOTTOM)
        down(0.1)
        screw_hole("M8", thread=false, l=15+0.1, anchor=BOTTOM);
        position(TOP)
        cyl(d=35, l=30.2-8, anchor=BOTTOM) {
            tag("remove")
            position(TOP)
            up(0.1)
            cyl(d=22.5, l=20.1, anchor=TOP)
                position(BACK)
                tag("keep") cube([4.5, 2.5, 20], anchor=BACK);
        }
        position(BOTTOM)
        xcopies(n=2, l=70.8-7.2) cyl(d=7.2, l=3, anchor=BOTTOM, orient=DOWN);
    }
}
