include <BOSL2/std.scad>

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

module modded_spool_holder() {
    difference() {
        union() {
            linear_extrude(10)
            projection(cut=false) {
                centered_full_thing();
            }
            little_nubs();
            up(10)
            cyl(d=23.5, l=70, anchor=BOTTOM)
                position(TOP)
                cyl(d=35, l=3, anchor=BOTTOM);
        }
        back(10.9)
        cube([500, 500, 500], anchor=BOTTOM+FRONT);
    }
}

// linear_extrude(12)
// projection(cut=false) {
// }
// centered_full_thing();
// #cyl(d=10, l=100);
// #little_nubs();
modded_spool_holder();

