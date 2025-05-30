include <BOSL2/std.scad>

// module award_shovel()
// {
//     projection(cut=true)
//     down(20)
//     surface(file="shovel.png", center=true, convexity=1);
//     // import(file="shovel.png");
// }

$fn=50;
spade_width = 20;
half_width = spade_width/2;
meat_depth = 7;
tip_depth = 5;
spade_height = 3;
handle_width = 3;
handle_height = 4;
handle_length = 50;
d_handle_width = 10;
d_handle_depth = 5;
d_handle_width_wall = 2;
square_mag = false;
round_mag = false;
module Dhandle(anchor=CENTER)
{
    size = [d_handle_width, d_handle_depth, handle_height];
    attachable(anchor=anchor, size=[size[0], size[1]+size[0]/2, size[2]]) {
        back(size[0]/2) {
            front_half()
            cyl(d=size[0], l=size[2]);
            cuboid(size, anchor=FRONT);
        }
        children();
    }
}
module award_shovel()
{
    // zrot(-45) wedge(size=[3,10,10], anchor="hypot", orient=LEFT);
    // front_half()
    // fwd(5)cuboid([10,10, 3], anchor=LEFT+FRONT+BOTTOM, spin=45);
    points = [
        [-half_width, meat_depth],
        [-half_width, 0],
        [0, -tip_depth],
        [half_width, 0],
        [half_width, meat_depth],
        [-half_width, meat_depth],
    ];
    difference() {
        union() {
            linear_extrude(height=spade_height)
            polygon(points = points);
            diff() {
                back(3) cuboid([handle_width, handle_length, handle_height], anchor=FRONT+BOTTOM, rounding=handle_width/2, edges=[FRONT+LEFT, FRONT+RIGHT]){
                    fwd(1) position(BACK) Dhandle()
                    tag("remove")
                    back(3)
                    scale(v=[0.6, 0.5, 2])
                    Dhandle();
                }
            }
        }
        if(square_mag) {
            back(meat_depth/2) cuboid([10,5,2], anchor=BOTTOM);
        }
        if(round_mag) {
            back(meat_depth/2) cyl(d=6, l=2, anchor=BOTTOM);
        }
    }
}

award_shovel();
