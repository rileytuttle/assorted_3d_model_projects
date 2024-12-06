include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <rosetta-stone/std.scad>

$fn=50;

module slat_mount_clip()
{
    diff() {
        cyl(d=35, l=30) {
            left(4) position(RIGHT) cuboid([20, 20, 30], anchor=LEFT) {
                tag("remove") cuboid([30, 5, 31]);
                position(FRONT) zcopies(n=2, l=15) screw_hole("M4", thread=false, l=28, anchor=TOP, orient=FRONT, teardrop=true)
                position(BOTTOM) nut_trap_inline(12, anchor=BOTTOM, spin=30);
            }
            position(BACK) cuboid([60, 15, 30], anchor=BACK+LEFT)
                left(10) position(RIGHT+FRONT) screw_hole("1/4", thread=false, l=20, anchor=BOTTOM, orient=BACK, teardrop=true, spin=180)
                position(BOTTOM) nut_trap_inline(5, anchor=BOTTOM, spin=30);
            tag("remove") cyl(d=INCH, l=31);
        }
    }
}

module slat_mount_riser_clip()
{
    width = 20;
    diff() {
        cyl(d=35, l=width) {
            back(4) position(FRONT) cuboid([20, 20, width], anchor=BACK) {
                tag("remove") cuboid([5, width+10, width+1]);
                position(LEFT) screw_hole("M4", thread=false, l=width, anchor=TOP, orient=LEFT, teardrop=true, spin=-90)
                position(BOTTOM) nut_trap_inline(3, anchor=BOTTOM, spin=30);
            }
            cuboid([35, 50, width], anchor=FRONT)
                position(BACK) screw_hole("1/4-20", thread=false, l=35, anchor=TOP, orient=BACK, teardrop=true, spin=180)
                down(10) position(TOP) nut_trap_side(20, anchor=TOP, spin=90);
            tag("remove") cyl(d=INCH, l=width+1);
        }
    }
}

module new_spacers()
{
    diff() {
        cyl(d=17, l=30)
        tag("remove") cyl(d=12.5, l=30);
    }
}

module fender_base()
{
    ang = 100;
    radius = 6*INCH;
    diff() {
        pie_slice(l=20, r=radius, ang=ang, anchor=CENTER) {
            zrot(ang/2) right(20) tag("remove") cyl(d=12.5, l=21);
            screws_ang_dist = 10; // 10 degrees between screws
            buffer_ang = 10;
            arc_copies(n=(ang-buffer_ang)/screws_ang_dist, sa=buffer_ang/2, ea=ang-buffer_ang/2, r=radius) screw_hole("M4", thread=false, l=30, anchor=TOP, orient=RIGHT, teardrop=true, spin=90)
            position(BOTTOM) up(20) nut_trap_side(15, spin=90);
        }
    }
}

// slat_mount_clip();
// new_spacers();
// fender_base();
slat_mount_riser_clip();
