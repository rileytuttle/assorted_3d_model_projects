include <BOSL2/std.scad>
include <BOSL2/screws.scad>

module centered_full_thing() {
    difference() {
        right(0.2)
        back(0.2)
        zrot(-22.6)
        right(200)
        left(70)
        fwd(100)
        back(14)
        right(2)
        right(0.25)
        rotate([0, -90, 0])
        import("Spool-holder-L.stl", convexity=3);
        up(30)
        cube([100, 100, 200], anchor=BOTTOM);
    }
}

module little_nubs() {
    difference() {
        down(1.49)
        centered_full_thing();
        cube([500, 500, 30], anchor=BOTTOM);
    }
}

module spool_holder_base(threaded=false) {
    attachable() {
        difference() {
            union() {
                linear_extrude(10)
                projection(cut=false) {
                    centered_full_thing();
                }
                little_nubs();
                // up(10)
                // cyl(d=23.5, l=70, anchor=BOTTOM)
                //     position(TOP)
                //     cyl(d=35, l=3, anchor=BOTTOM);
            }
            back(10.9)
            cube([500, 500, 500], anchor=BOTTOM+FRONT);
            fwd(5)
            screw_hole("M20x2.5", l=10, thread=true, anchor=BOTTOM);
        }
        children();
    }
}

module modded_spool_holder() {
    spool_holder_base()
        up(10)
        cyl(d=23.5, l=70, anchor=BOTTOM)
            position(TOP)
            cyl(d=35, l=3, anchor=BOTTOM);
}

module threaded_shaft_with_bearing()
{
    zrot(90)
    teardrop(d=14, l=70, cap_h=7)
    position(BACK)
    screw("M20x2.5", l=10, anchor=TOP, orient=FRONT);
}

// linear_extrude(12)
// projection(cut=false) {
// }
// centered_full_thing();
// #cyl(d=10, l=100);
// #little_nubs();
// modded_spool_holder();
spool_holder_base();

top_half()
up(7)
xrot(180)
// fwd(5)
right(70)
threaded_shaft_with_bearing();
