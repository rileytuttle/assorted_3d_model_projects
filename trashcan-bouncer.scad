include <BOSL2/std.scad>


$fn=50;
diff() {
    cuboid([15, 150, 5], rounding=2, edges=[FRONT+LEFT, FRONT+RIGHT, BACK+LEFT, BACK+RIGHT])
    tag("remove") position(TOP) cuboid([7, 140, 0.25], anchor=TOP);
}
