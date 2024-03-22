include <gridfinity-rebuilt-openscad/gridfinity-rebuilt-utility.scad>
include <BOSL2/std.scad>

// ===== INFORMATION ===== //
/*
 IMPORTANT: rendering will be better for analyzing the model if fast-csg is enabled. As of writing, this feature is only available in the development builds and not the official release of OpenSCAD, but it makes rendering only take a couple seconds, even for comically large bins. Enable it in Edit > Preferences > Features > fast-csg

https://github.com/kennetek/gridfinity-rebuilt-openscad

*/

// ===== PARAMETERS ===== //

/* [Setup Parameters] */
$fa = 8;
$fs = 0.25;

/* [General Settings] */
// number of bases along x-axis
gridx = 1;
// number of bases along y-axis
gridy = 1;
// bin height. See bin height information and "gridz_define" below.
gridz = 4;

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
style_tab = 5; //[0:Full,1:Auto,2:Left,3:Center,4:Right,5:None]

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


// ===== IMPLEMENTATION ===== //

// Input all the cutter types in here
// color("tomato")
// gridfinityLite(gridx, gridy, gridz, gridz_define, style_lip, enable_zsnap, l_grid, div_base_x, div_base_y, style_hole, only_corners) {
//     cutEqual(n_divx = divx, n_divy = divy, style_tab = style_tab, scoop_weight = scoop_weight);
// }

// ===== CONSTRUCTION ===== //

function cumsum_array(array) = [ for (a=0, b=array[0]; a < len(array); a=a+1, b=b+(array[a]==undef?0:array[a])) b];

module gridfinityLiteDivList(gridx, gridy, gridz, gridz_define, style_lip, enable_zsnap, length, div_base_x, div_base_y, style_hole, only_corners, cut_list = []) {
    gridfinityLite(gridx, gridy, gridz, gridz_define, style_lip, enable_zsnap, l_grid, div_base_x, div_base_y, style_hole, only_corners) {
        if (len(cut_list) == 0) {
            cutEqual(n_divx = divx, n_divy = divy, style_tab = style_tab, scoop_weight = scoop_weight);
        }
        else {
            cumsum = cumsum_array(cut_list);
            for (i = [0 : len(cut_list)-1]) {
                x_disp = i==0 ? 0 : cumsum[i-1];
                cut(x=x_disp, w=cut_list[i]);
            }
        }
    }
}

module gridfinityLite(gridx, gridy, gridz, gridz_define, style_lip, enable_zsnap, length, div_base_x, div_base_y, style_hole, only_corners) {
    union() {
        difference() {
            union() {
                gridfinityInit(gridx, gridy, height(gridz, gridz_define, style_lip, enable_zsnap), 0, length)
                children();
                gridfinityBase(gridx, gridy, length, div_base_x, div_base_y, style_hole, only_corners=only_corners);
            }

            difference() {
                union() {
                    intersection() {
                        difference() {
                            gridfinityBase(gridx, gridy, length, div_base_x, div_base_y, style_hole, -d_wall*2, false, only_corners=only_corners);
                            translate([-gridx*length/2,-gridy*length/2,2*h_base])
                            cube([gridx*length,gridy*length,1000]);
                        }
                        translate([0,0,-1])
                        rounded_rectangle(gridx*length-0.5005-d_wall*2, gridy*length-0.5005-d_wall*2, 1000, r_f2);
                        translate([0,0,bottom_layer])
                        rounded_rectangle(gridx*1000, gridy*1000, 1000, r_f2);
                    }
                    translate([0,0,h_base+d_clear])
                    rounded_rectangle(gridx*length-0.5005-d_wall*2, gridy*length-0.5005-d_wall*2, h_base, r_f2);
                }

                translate([0,0,-4*h_base])
                gridfinityInit(gridx, gridy, height(20,0), 0, length)
                children();
            }

        }
        difference() {
            translate([0,0,-1.6])
                difference() {
                    difference() {
                        union() {

                            gridfinityInit(gridx, gridy, height(gridz, gridz_define, style_lip, enable_zsnap), 0, length)
                            children();
                        }

                        difference() {

                                intersection() {
                                    difference() {
                                        gridfinityBase(gridx, gridy, length, div_base_x, div_base_y, style_hole, -d_wall*2, false, only_corners=only_corners);
                                        translate([-gridx*length/2,-gridy*length/2,2*h_base])
                                        cube([gridx*length,gridy*length,1000]);
                                    }
                                    translate([0,0,-1])
                                    rounded_rectangle(gridx*length-0.5005-d_wall*2, gridy*length-0.5005-d_wall*2, 1000, r_f2);
                                    translate([0,0,bottom_layer])
                                    rounded_rectangle(gridx*1000, gridy*1000, 1000, r_f2);
                                }


                            translate([0,0,-4*h_base])
                            gridfinityInit(gridx, gridy, height(20,0), 0, length)
                            children();
                        }

                    }
                    translate([0,0,9])
                    rounded_rectangle(gridx*1000, gridy*1000, gridz*1000, gridz);
                }
                    translate([0,0,0])
                    rounded_rectangle(gridx*1000, gridy*1000, 5, r_f2);
            }

    }
}


color("tomato")
gridfinityLite(2, 2, 11, gridz_define, style_lip, enable_zsnap, l_grid, div_base_x, div_base_y, style_hole, only_corners) {
    up(1*7) {
        cyl(d=51, l=70, anchor=BOTTOM, rounding2=-2);
        back(28)
        cyl(d=20, l=70, anchor=BOTTOM, rounding2=-1);
    }
    up(11*7) {
        zrot(45)
        zrot_copies(n=4, r=40) {
            cyl(d=5, l=25, anchor=TOP, rounding2=-1);
        }
    }
    
}

