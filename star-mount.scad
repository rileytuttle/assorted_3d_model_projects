include <BOSL2/std.scad>

$fn=30;

tube(id=90, od=100, h=3) {
    cube([90, 9.5+2*2, 3], anchor=CENTER);
    position(BOTTOM)
    tube(id=9.5, wall=2, h=25, anchor=BOTTOM);
}
