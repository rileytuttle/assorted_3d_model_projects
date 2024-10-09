include <BOSL2/std.scad>
include <rosetta-stone/std.scad>
include <BOSL2/threading.scad>

$fn=50;

module handle()
{
    difference() {
        union() {
            down(0.25 * INCH - 0.05)
            import("Transport-handle.stl");
            cube([100, 30, 1], anchor=BOTTOM);
        }
        xcopies(n=3, l=90)
        threaded_rod(d=20, l=2, pitch=1, internal=true, anchor=BOTTOM, starts=3);
    }
}

module plug()
{
    threaded_rod(d=20-0.1, l=3, pitch=1, internal=false, anchor=BOTTOM, starts=3)
        position(BOTTOM) cyl(d=21, l=2, anchor=TOP, chamfer2=1)
        position(BOTTOM) cuboid([15, 3, 5], anchor=TOP, rounding=2, edges=[LEFT+BOTTOM, RIGHT+BOTTOM]);
}

plug();
// handle();
