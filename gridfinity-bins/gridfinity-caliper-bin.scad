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


caliper_cut_height = 30;

module cut_caliper_slot(spin=0, anchor=CENTER) {
    attachable(size=[0, 0, caliper_cut_height], spin=spin, anchor=anchor) {
        cuboid([8, 80, caliper_cut_height], rounding=-2, edges=TOP)
            fwd(13)
            position(LEFT+BACK)
            cuboid([13, 35, caliper_cut_height], anchor=RIGHT+BACK, rounding=-2, edges=TOP);
        children();
    }
}

gridfinityLite(gridx, gridy, gridz, gridz_define, style_lip, enable_zsnap, l_grid, div_base_x, div_base_y, style_hole, only_corners) {
    up(gridz * 7) {
        back(1)
        cut_caliper_slot(anchor=TOP, spin=70);
    }
}
