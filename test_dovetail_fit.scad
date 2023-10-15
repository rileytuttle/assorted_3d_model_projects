include <BOSL2/joiners.scad>
include <BOSL2/std.scad>

thickness = 4;
length = 100;
dist_between = length/2;

cube([100, 5, thickness], anchor = CENTER)
position(FRONT)
xcopies(n=2, spacing=dist_between)
dovetail("male", slide=thickness, width=10, height=8, chamfer=1, anchor=BOTTOM, orient=FRONT, spin=0);
