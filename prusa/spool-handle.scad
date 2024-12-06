include <BOSL2/std.scad>

$fn=50;
shift = 3.7;
length = 80; // [80, 91.5]

module spool_handle(l=91.5, anchor=BOTTOM, spin=0, orient=UP)
{
    ang=360 /6 - 4.5;
    main_d = 24.25;
    bottom_disk_d = 35;
    bottom_disk_h = 2.6;
    step1_d = 20;
    step1_h = 11.6;
    step2_d = 15.7;
    step2_h = 6.95;
    full_height = l+bottom_disk_h+step1_h+step2_h;
    attachable(size=[bottom_disk_d, bottom_disk_d, full_height], anchor=anchor, spin=spin, orient=orient) {
        down(full_height/2)
        cyl(d=bottom_disk_d, l=bottom_disk_h, anchor=BOTTOM)
        position(TOP) cyl(d=main_d, l=l, anchor=BOTTOM, rounding2=1)
        position(TOP) cyl(d=step1_d, l=step1_h, anchor=BOTTOM, rounding2=1)
        // position(TOP) cyl(d=step2_d, l=step2_h, anchor=BOTTOM, rounding1=-1, rounding2=0.5);
        
        for (loc = [[1, 0],[-1, 180]])
        {
            right(loc[0])
            zrot(loc[1])
            zrot(-ang/2)
            position(TOP) pie_slice(ang=ang, l=step2_h, r=(step2_d/2)-1, anchor=BOTTOM)
            position(TOP) pie_slice(ang=ang, l=2, r=9.8-1, anchor=TOP);
        }
        children();
    }
}

module turn_tab(shift=4.4)
{
    thickness = 5;
    attachable(size=[35, 5, 10], anchor=TOP) {
        intersect()
        {
            cyl(d=35, l=10)
            fwd(shift)
            tag("intersect") cuboid([35, 10, thickness], anchor=BOTTOM, orient=BACK, teardrop=true, rounding=2, except=[FRONT, BOTTOM+LEFT, BOTTOM+RIGHT]);
        }
        children();
    }
}

top_half(300)
up(shift)
{
    spool_handle(l=length, orient=RIGHT, spin=90) {
        position(BOTTOM)
        turn_tab(shift);
    }
}
