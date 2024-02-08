include <gridfinity-rebuilt-openscad/gridfinity-rebuilt-utility.scad>
use <gridfinity-rebuilt-openscad/gridfinity-rebuilt-lite.scad>
include <BOSL2/std.scad>

/* [Setup Parameters] */
$fa = 8;
$fs = 0.25;

/* [General Settings] */
// number of bases along x-axis
gridx = 2;
// number of bases along y-axis
gridy = 1;
// bin height. See bin height information and "gridz_define" below.
gridz = 5;

/* [Compartments] */
// number of X Divisions
divx = 1;
// number of y Divisions
divy = 1;
// divisions list
cut_list = [];
// cut_list = [4/3, 4/3, 4/3];

/* [Toggles] */
// snap gridz height to nearest 7mm increment
enable_zsnap = false;
// how should the top lip act
style_lip = 0; //[0: Regular lip, 1:remove lip subtractively, 2: remove lip and retain height]

/* [Other] */
// determine what the variable "gridz" applies to based on your use case
gridz_define = 0; // [0:gridz is the height of bins in units of 7mm increments - Zack's method,1:gridz is the internal height in millimeters, 2:gridz is the overall external height of the bin in millimeters]
// the type of tabs
style_tab = 1; //[0:Full,1:Auto,2:Left,3:Center,4:Right,5:None]

/* [Base] */
style_hole = 0; // [0:no holes, 1:magnet holes only, 2: magnet and screw holes - no printable slit, 3: magnet and screw holes - printable slit]
// only cut magnet/screw holes at the corners of the bin to save uneccesary print time
only_corners = true;
// number of divisions per 1 unit of base along the X axis. (default 1, only use integers. 0 means automatically guess the right division)
div_base_x = 0;
// number of divisions per 1 unit of base along the Y axis. (default 1, only use integers. 0 means automatically guess the right division)
div_base_y = 0;
// thickness of bottom layer
bottom_layer = 1;

scoop_weight=0.75; // 1 for full scoop

gauge_cut_height = 30;
module cut_thread_gauge(spin = 0) {
    size2d = [12, 25];
    height = gauge_cut_height;
    size = [size2d[0], size2d[1], height];
    attachable(size=size, spin=spin) {
        cuboid([size2d[0], size2d[1], height/2], rounding=3, edges=BOTTOM, anchor=TOP)
            position(TOP)
            cuboid([size2d[0], size2d[1], height/2], rounding=-3, edges=TOP, anchor=BOTTOM);
        children();
    }
}

module cut_scissor_slot(spin=0) {
    size2d = [3, 13];
    height = gauge_cut_height;
    size = [size2d[0], size2d[1], height];
    attachable(size=size, spin=spin) {
        cuboid([size2d[0], size2d[1], height/2], rounding=1, edges=BOTTOM, anchor=TOP)
            position(TOP)
            cuboid([size2d[0], size2d[1], height/2], rounding=-1, edges=TOP, anchor=BOTTOM);
        children();
    }
}

module cut_flashlight_hole() {
    diam = 16.5;
    attachable(size = [diam, diam, gauge_cut_height]) {
        cyl(d=diam, l=gauge_cut_height, anchor=CENTER, rounding1=2, rounding2=-2);
        children();
    }
}

module cut_pencil_hole() {
    diam = 10;
    attachable(size = [diam, diam, gauge_cut_height]) {
        cyl(d=diam, l=gauge_cut_height, anchor=CENTER, rounding1=2, rounding2=-2);
        children();
    }
}

module cut_pen_hole() {
    diam = 12;
    attachable(size = [diam, diam, gauge_cut_height]) {
        cyl(d=diam, l=gauge_cut_height, anchor=CENTER, rounding1=2, rounding2=-2);
        children();
    }
}

gridfinityLite(gridx, gridy, gridz, gridz_define, style_lip, enable_zsnap, l_grid, div_base_x, div_base_y, style_hole, only_corners) {
    up(gridz * 7) {
        down(gauge_cut_height/2-0.1) {
            left(29)
            back(3)
            cut_thread_gauge(spin=0);
            fwd(15)
            left(29)
            cut_scissor_slot(spin=90);
            left(5)
            back(7)
            cut_flashlight_hole();
            right(23)
            xcopies(n=2, l=13) {
                yshift=6;
                back(yshift)
                cut_pencil_hole();
                fwd(yshift)
                cut_pen_hole();
            }
        }
    }
}
