include <BOSL2/std.scad>
include <BOSL2/screws.scad>


$fn=50;
side_wall = 3;
width = 19.75;
dist_to_screw = 35;
retainer_bump_diam = 3;
retainer_bump_dist = 20;
height = 20;
bottom_wall = 5;
back_wall = 4;
inner_length = dist_to_screw + 10;
full_length = inner_length + back_wall;
magnet_size = [5, 10, 2];
layer_height = 0.45;
magnets = true;

module bracket()
{
    diff()
    cuboid([width+side_wall+side_wall, height+bottom_wall+side_wall, full_length], anchor=BOTTOM, chamfer=2, except=[TOP,BOTTOM]) {
        tag("remove") position(BOTTOM+BACK) up(back_wall) fwd(bottom_wall) cuboid([width, height, inner_length], anchor=BACK+BOTTOM) {
            position(BACK+BOTTOM) up(dist_to_screw) screw_hole("1/4-20", l=100, thread="none", head="flat", anchor="head_top", orient=FRONT, teardrop=true, counterbore=50);
            tag("keep") position(BOTTOM+FRONT) up(retainer_bump_dist) teardrop(d=retainer_bump_diam, l=width, orient=UP, spin=90);
            if (magnets) {
                position(BOTTOM+BACK) fwd(7) xcopies(n=3, l=20-5) down(layer_height) cuboid(magnet_size, anchor=TOP);
                // position(TOP) cuboid([1.5, 10, 10], anchor=TOP);
            }
        }
    }
}

bracket();
