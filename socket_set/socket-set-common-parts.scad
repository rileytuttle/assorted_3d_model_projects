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
