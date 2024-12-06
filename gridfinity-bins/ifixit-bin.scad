include <gridfinity-rebuilt-openscad/gridfinity-rebuilt-utility.scad>
use <gridfinity-rebuilt-openscad/gridfinity-rebuilt-lite.scad>
include <BOSL2/std.scad>

hole_options = bundle_hole_options();
cut_dist = 30;

difference() {
    gridfinityLite(gridx=4,
                   gridy=1,
                   gridz=6,
                   gridz_define=0,
                   style_lip=0,
                   enable_zsnap=false,
                   length=l_grid,
                   div_base_x=0,
                   div_base_y=0,
                   style_hole=hole_options,
                   only_corners=false) {}
    up(6 * 7) back(4) cuboid([151, 28, cut_dist], anchor=TOP, chamfer=-2, edges=[TOP+LEFT, TOP+RIGHT])
        position(FRONT) prismoid([151, cut_dist], [80, cut_dist], h=10, anchor=BOTTOM, orient=FRONT);
}

    // #up(6 * 7) back(3.5) cuboid([151, 28, 30], anchor=TOP)
    //     position(FRONT) prismoid([151, 30], [80, 30], h=10, anchor=BOTTOM, orient=FRONT);
