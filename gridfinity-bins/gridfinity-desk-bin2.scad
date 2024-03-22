include <gridfinity-rebuilt-openscad/gridfinity-rebuilt-utility.scad>
use <gridfinity-rebuilt-openscad/gridfinity-rebuilt-lite.scad>
include <BOSL2/std.scad>


gridx = 2;
gridy = 1;
gridz = 5;
enable_zsnap = false;
style_lip = 0; //[0: Regular lip, 1:remove lip subtractively, 2: remove lip and retain height]
gridz_define = 0; // [0:gridz is the height of bins in units of 7mm increments - Zack's method,1:gridz is the internal height in millimeters, 2:gridz is the overall external height of the bin in millimeters]
style_tab = 1; //[0:Full,1:Auto,2:Left,3:Center,4:Right,5:None]
style_hole = 0; // [0:no holes, 1:magnet holes only, 2: magnet and screw holes - no printable slit, 3: magnet and screw holes - printable slit]
only_corners = true;
div_base_x = 0;
div_base_y = 0;
bottom_layer = 1;
scoop_weight=0.75; // 1 for full scoop

gridfinityLite(gridx, gridy, gridz, gridz_define, style_lip, enable_zsnap, l_grid, div_base_x, div_base_y, style_hole, only_corners) {
    // up(gridz * 7) {
    // }
}
