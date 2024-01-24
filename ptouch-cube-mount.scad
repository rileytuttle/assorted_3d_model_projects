include <BOSL2/std.scad>

$fn=50;

ptouch_size = [128, 129, 69];
wall_width = 5;
mount_depth = 35;
tab_len = 20;

module screw_hole() {
    attachable() {
        cyl(d1=6.75, d2=3.5, h=2.5, anchor=BOTTOM) {
            position(BOTTOM)
            cyl(d=6.75, l=10, anchor=TOP)
                position(BOTTOM)
                teardrop(d=3.5, l=20, anchor=FRONT, orient=FRONT);
        }
        children();
    }
}

module mount() {
    diff() {
        cube([ptouch_size[0] + wall_width*2, mount_depth, ptouch_size[2]+wall_width], anchor=CENTER) {
            position(TOP)
            up(0.01)
            tag("remove")
            // cuboid([ptouch_size[0], mount_depth, ptouch_size[2]], anchor=TOP, chamfer=-1);
            cuboid([ptouch_size[0], ptouch_size[2], mount_depth], anchor=BACK, orient=FRONT, chamfer=-1, edges=BOTTOM);
            for (data = [[LEFT, RIGHT, 180], [RIGHT, LEFT, 270]]) {
                position(TOP+data[0])
                cube([tab_len, mount_depth , wall_width], anchor=TOP+data[1]) {
                    position(BOTTOM+data[1])
                    fillet(r=10, l=mount_depth, orient=FRONT, spin=data[2]);
                    position(BOTTOM)
                    tag("remove")
                    screw_hole();
                }
            }
        }
    }
}

// screw_hole();
mount();
