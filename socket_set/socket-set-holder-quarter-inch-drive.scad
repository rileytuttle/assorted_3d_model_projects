include <BOSL2/std.scad>

$fn=50;

module clip(clip_path, size, anchor=CENTER, spin=0, orient=UP)
{
    // cutout_d = 8;
    // cutout_r = cutout_d/2;
    // clip_d = 6;
    // clip_r = clip_d/2;
    // clip_offset = 1.5;
    // clip_yoffset = sqrt((cutout_r+clip_r)^2 - ((cutout_d-clip_offset)/2 + clip_d/2)^2);
    
    attachable(size=size, anchor=anchor, spin=spin, orient=orient)
    {
        up(size[2])
        difference() {
            cuboid(size, rounding=-2, edges=BOTTOM, anchor=TOP);
            back((size[1]+1)/2)
            xrot(90)
            linear_extrude(size[1]+1) region(clip_path);
        }
        children();
    }
}

clip_path = turtle([
    "xmove", 6.12702,
    "setdir", 180,
    "arcleft", 5.75403/2, 117.008,
    "arcright", 4, 117.008 * 2,
    "arcleft", 5.75403/2, 117.008,
    "jump", [0, 0],
]);

extension_clip_path = turtle([
    "xmove", 6.12702,
    "setdir", 180,
    "arcleft", 4.75403/2, 117.008,
    "arcright", 9/2, 117.008 * 2,
    "arcleft", 4.75403/2, 117.008,
    "jump", [0, 0],
]);

module socket_set_holder()
{
    diff() {
        cuboid([56, 150+4, 8]) {
            tag("remove") {
                locs = [
                    [TOP+LEFT, 2.5, TOP+LEFT],
                    [BOTTOM+LEFT, 2.5, BOTTOM+LEFT],
                    [TOP+RIGHT, -2.5, TOP+RIGHT],
                    [BOTTOM+RIGHT, -2.5, BOTTOM+RIGHT]];
                for(loc = locs)
                {
                    position(loc[0]+FRONT) translate([loc[1], 0, 0]) fwd(0.1) cube([3, 150+0.1, 3.1], anchor=FRONT+loc[2]);
                }
                for(loc = [[LEFT, 1], [RIGHT, -1]])
                {
                    position(loc[0]+FRONT)
                    back(3)
                    translate([(2.5+3/2) * loc[1], 0, 0])
                    teardrop(d=2.5, l=8+1, orient=BACK);
                }
                // position(LEFT+FRONT)
                // back(3)
                // right(2.5+3/2)
                // cyl(d=2.5, l=8+1);
                // position(RIGHT+FRONT)
                // back(3)
                // left(2.5+3/2)
                // cyl(d=2.5, l=8+1);
            }
            tag("remove")
            fwd(8 + 4)
            position(BACK) teardrop(d=6.6 * sqrt(2), l=8+1, orient=BACK)
                tag("keep") fwd(4) down(33.5) clip(clip_path, [16, 8, 12], orient=FRONT);
            position(FRONT)
            xcopies(n=2, l=20) {
            back(25)
            up(4)
            clip(extension_clip_path, [16, 8, 12]);
            position(TOP)
            cuboid([12, 3, 10], anchor=FRONT+BOTTOM, rounding=3, edges=[TOP+LEFT, TOP+RIGHT]) {
                position(LEFT+BOTTOM)
                fillet(l=3, r=3, orient=FRONT, spin=90);
                position(RIGHT+BOTTOM)
                fillet(l=3, r=3, orient=FRONT, spin=0);
            }
            }
        }
    }
}

// clip(clip_path, [16, 8, 12]);

socket_set_holder();
