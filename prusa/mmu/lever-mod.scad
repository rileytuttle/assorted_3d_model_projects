include <BOSL2/std.scad>

$fn=50;

difference() {
    import("Hinge-lever.stl", convexity=3);
    back(72)
    fwd(0.15)
    right(45.6)
    up(12.5/2)
    teardrop(d=6.5, l=2.1, cap_h=3, ang=60, chamfer2=-0.5, anchor=BACK);
}

