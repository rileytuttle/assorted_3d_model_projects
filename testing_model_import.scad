include <BOSL2/std.scad>

//#cube([65,115, 15], anchor=CENTER+BOTTOM);


module bring_in_bottom() {
    attachable(spin=0, anchor=CENTER, orient=UP, size=[65,115,15])
    {
        translate([0, 0, -15 / 2])
        import("Sander\ 115x140\ Bottom.stl", convexity=3);
        children();
    }
}

module bring_in_top() {
//    translate([0, 0, 15])
//    #cube([65,115, 37], anchor=CENTER+BOTTOM);

    attachable(spin=0, anchor=CENTER, orient=UP, size=[65,115,37]) {
//        translate([0, 0, -22.5])
        translate([0,0,-33.5])
        import("Sander\ 115x140\ Top.stl", convexity=3);
        children();
    }
}

module top_with_nubs(spin=0, anchor=BOTTOM, orient=UP) {
    attachable(spin=spin, anchor=anchor, orient=orient, size=[65,115,37]) {
        diff("nub_holes")
        bring_in_top()
        tag("nub_holes") {
            for (i=[-1,1])
            {
                position(BOTTOM+CENTER)
                translate([0, i*40, 0])
                cyl(d=7.5, h=5, anchor=BOTTOM, rounding2=1, chamfer1=-1, teardrop=true);
            }
        }
        children();
    }

}

module bottom_with_nubs(spin=0, anchor=BOTTOM, orient=UP) {
    attachable(spin=spin, anchor=anchor, orient=orient, size=[65,115, 15]) {
    bring_in_bottom()
        for (i=[-1, 1]) {
            position(TOP+CENTER)
            translate([0, i*40, 0])
            cyl(d=7, h=5, anchor=BOTTOM, rounding2=1, rounding1=-1);
        }
        children();
    }
}

//bottom_with_nubs();
top_with_nubs(anchor=BOTTOM);

//bring_in_top() show_anchors();
//top_with_nubs() show_anchors();