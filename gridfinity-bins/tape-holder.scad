include <BOSL2/std.scad>
use <gridfinity-rebuilt-openscad/gridfinity-rebuilt-utility.scad>

$fn=50;
grid_length = 42;
gridx = 2;
gridy = 1;
hole_options = [false, false, false, false, false, false];
style_lip = 0;
height_internal = 0;
enable_zsnap=false;
gridz_define = 0;
gridz=5;
l_gridx=42;
l_gridy=42;
divx=1;
divy=1;
enable_thumbscrew = false;
only_corners=false;
place_tab = 0;
scoop=0;
style_tab=5;

module tape_dispenser_bin()
{
    difference() {
    union() {
        gridfinityInit(gridx, gridy, height(gridz, gridz_define, style_lip, enable_zsnap), height_internal, sl=style_lip, l=[l_gridx, l_gridy]);
        gridfinityBase([gridx, gridy], hole_options=hole_options, only_corners=only_corners, thumbscrew=enable_thumbscrew, grid_dimensions=[l_gridx, l_gridy]);
    }
        up(35) cyl(d=58, l=39, orient=BACK);
    }
}

tape_dispenser_bin();
