include <BOSL2/std.scad>
include <socket-set-common-parts.scad>

$fn=50;

quarter_inch_clip_path = turtle([
    "xmove", 6.12702,
    "setdir", 180,
    "arcleft", 5.75403/2, 117.008,
    "arcright", 4, 117.008 * 2,
    "arcleft", 5.75403/2, 117.008,
    "jump", [0, 0],
]);

quarter_inch_extension_clip_path = turtle([
    "xmove", 6.12702,
    "setdir", 180,
    "arcleft", 4.75403/2, 117.008,
    "arcright", 9/2, 117.008 * 2,
    "arcleft", 4.75403/2, 117.008,
    "jump", [0, 0],
]);

three_8ths_clip_path = turtle([
    "xmove", 6.12702,
    "setdir", 180,
    "arcleft", 5.75403/2, 117.008,
    "arcright", 4, 117.008 * 2,
    "arcleft", 5.75403/2, 117.008,
    "jump", [0, 0],
]);

three_8ths_extension_clip_path = turtle([
    "xmove", 6.12702,
    "setdir", 180,
    "arcleft", 4.75403/2, 117.008,
    "arcright", 9/2, 117.008 * 2,
    "arcleft", 4.75403/2, 117.008,
    "jump", [0, 0],
]);

back_wall_thickness = 4;
holder_base_size = [56, 150, 8];
bit_width = 6.6;
head_diam = 20;
clip_dist = 33.5;
quarter_inch_clip_info = [quarter_inch_clip_path, [16, 8, 12], clip_dist];

// extension clip location. first element is distance between the extensions. next element is how far from the front the clips are
extension_clip_loc = [20, 25];
quarter_inch_extension_clip_info = [quarter_inch_extension_clip_path, [16, 8, 12], extension_clip_loc, [12, 3, 10], 3];


three_8ths_clip_info = [
    three_8ths_clip_path,
    [16, 8, 12],
    50
];

three_8ths_extension_clip_info = [
    three_8ths_extension_clip_path,
    [16, 8, 12],
    [35, 40],
    [12, 3, 10],
    3
];

module socket_set_holder(
    back_wall_thickness,
    holder_base_size,
    bit_width,
    head_diam,
    clip_info,
    extension_clip_info,
    clip_dist,
    extension_clip_loc,
    visualize=false)
{
    holder_size = [holder_base_size[0], holder_base_size[1]+back_wall_thickness, holder_base_size[2]];
    diff() {
        cuboid(holder_size) {
            tag("remove") {
                locs = [
                    [TOP+LEFT, 2.5, TOP+LEFT],
                    [BOTTOM+LEFT, 2.5, BOTTOM+LEFT],
                    [TOP+RIGHT, -2.5, TOP+RIGHT],
                    [BOTTOM+RIGHT, -2.5, BOTTOM+RIGHT]];
                for(loc = locs)
                {
                    position(loc[0]+FRONT) translate([loc[1], 0, 0]) fwd(0.1) cube([3, holder_base_size[1]+0.1, 3.1], anchor=FRONT+loc[2]);
                }
                for(loc = [[LEFT, 1], [RIGHT, -1]])
                {
                    position(loc[0]+FRONT)
                    back(3)
                    translate([(2.5+3/2) * loc[1], 0, 0])
                    teardrop(d=2.5, l=holder_base_size[2]+1, orient=BACK);
                }
            }
            tag("remove")
            fwd(head_diam/2)
            position(BACK) teardrop(d=bit_width * sqrt(2), l=holder_base_size[2]+1, orient=BACK) {
                // #tag("keep") fwd(back_wall_thickness) down(33.5) clip(clip_path, [16, 8, 12], orient=FRONT);
                tag("keep")
                fwd(holder_base_size[2]/2)
                down(clip_info[2])
                clip(clip_info[0], clip_info[1], orient=FRONT);
                if (visualize) fwd(20) tag("keep") #cyl(d=head_diam, l=10, orient=BACK);
            }
            position(FRONT) {
            xcopies(n=2, l=extension_clip_info[2][0]) {
                back(extension_clip_info[2][1])
                up(holder_base_size[2]/2)
                clip(extension_clip_info[0], extension_clip_info[1]) {
                    if (visualize)
                    #up(6) cyl(d=13, l=200, orient=BACK);
                }
                position(TOP)
                cuboid(extension_clip_info[3], anchor=FRONT+BOTTOM, rounding=extension_clip_info[4], edges=[TOP+LEFT, TOP+RIGHT]) {
                    position(LEFT+BOTTOM)
                    fillet(l=extension_clip_info[4], r=extension_clip_info[4], orient=FRONT, spin=90);
                    position(RIGHT+BOTTOM)
                    fillet(l=extension_clip_info[4], r=extension_clip_info[4], orient=FRONT, spin=0);
                }
            }
                if (visualize)
                up(12) #cyl(d=16, l=200, orient=BACK, anchor=BOTTOM);
            }
        }
    }
}

// clip(clip_path, [16, 8, 12]);

socket_set_holder(back_wall_thickness, holder_base_size, bit_width, head_diam, quarter_inch_clip_info, quarter_inch_extension_clip_info);
right(100)
socket_set_holder(back_wall_thickness, [70, 200, 12], 10, 30, three_8ths_clip_info, three_8ths_extension_clip_info, visualize=true);
