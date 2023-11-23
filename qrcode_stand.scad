include <BOSL2/std.scad>
include <rosetta-stone/std.scad>

// trapezoid3d(bottomwidth=35, topwidth=20, height=82);

length=82;
height=20;
bottom_width=35;
top_width=25;
block_size = [20, 62, 82];

diff() {
    prismoid(size2=[top_width, length], size1=[bottom_width, length], height=height, anchor=BOTTOM) {
        tag("remove") {
            position(TOP)
            cube([block_size[0], block_size[2], 15], anchor=TOP)
                tag("keep")
                position(TOP+RIGHT)
                cube([3, block_size[2], 7], anchor=TOP+RIGHT);
        }
    }
}
