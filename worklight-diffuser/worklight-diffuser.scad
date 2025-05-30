include <BOSL2/std.scad>
include <rosetta-stone/std.scad>

$fn=50;

vertical_spacing = 135;
horizontal_spacing_long = 160;
horizontal_spacing_short = 50;
mag_diam = 6.1;
mag_thickness = 2.1;
full_thickness = 3;

module magnet_jig()
{
    diff()
    cube([10, 150, 1.5], anchor=CENTER) {
        position(TOP) up(0.01) ycopies(n=2, l=vertical_spacing) tag("remove") cyl(d=mag_diam, l=1, anchor=TOP);
        cube([175, 10, 1.5], anchor=CENTER)
            position(TOP) up(0.01) xcopies(n=2, l=horizontal_spacing_long) tag("remove") cyl(d=mag_diam, l=1, anchor=TOP);
        fwd(vertical_spacing/2)
        cube([110, 10, 1.5], anchor=CENTER)
            position(TOP) tag("remove") xcopies(n=2, l=horizontal_spacing_short * 2) up(0.01) cyl(d=mag_diam, l=1, anchor=TOP);
    }
}

module worklight_diffuser()
{
    diff()
    cuboid([180, 150, full_thickness], anchor=CENTER, rounding=10, except=[TOP,BOTTOM]) {
        position(TOP)
        force_tag("remove") {
            ycopies(n=2, l=vertical_spacing) magnet_cutout_cyl(mag_diam, mag_thickness, l=full_thickness, anchor=BOTTOM, orient=DOWN);
            xcopies(n=2, l=horizontal_spacing_long) magnet_cutout_cyl(mag_diam, mag_thickness, l=full_thickness, anchor=BOTTOM, orient=DOWN);
            fwd(vertical_spacing/2) xcopies(n=2, l=horizontal_spacing_short*2) magnet_cutout_cyl(mag_diam, mag_thickness, l=full_thickness, anchor=BOTTOM, orient=DOWN);
        }
        #tag("remove") position(BOTTOM) text3d("BOTTOM", h=1, size=10, anchor=TOP, orient=DOWN);
    }
}

module worklight_diffuser_quick()
{
    cuboid([175, 135, 0.6], chamfer=10, except=[TOP, BOTTOM]);
}

module worklight_diffuser_rim_mount()
{
    diff()
    cuboid([174, 134, 0.5], chamfer=10, except=[TOP, BOTTOM]) {
        tag("remove") cuboid([110, 75, 1], rounding=5, except=[TOP, BOTTOM]);
        position(BOTTOM)
        // xcopies(n=2, l=110 + 15) ycopies(n=2, l=75+10) cyl(d=10, l=3)
        xcopies(n=2, l=110 + 12) ycopies(n=2, l=75+6) cyl(d=10, l=3, anchor=BOTTOM)
            position(TOP)
            force_tag("remove") magnet_cutout_cyl(mag_diam, mag_thickness, l=3, anchor=TOP);
    }
    // #cuboid([140, 100, 1], rounding=7, except=[TOP, BOTTOM]);
}

module worklight_diffuser_quick_mag()
{
    diff()
    cuboid([140, 100, 0.6], rounding=7, except=[TOP, BOTTOM]) {
        position(BOTTOM)
        xcopies(n=2, l=110 + 12) ycopies(n=2, l=75+6) cyl(d=15, l=3+3-0.6, anchor=BOTTOM) {
            position(TOP)
            force_tag("remove") magnet_cutout_cyl(mag_diam, mag_thickness, l=3, anchor=BOTTOM, orient=DOWN);
            down(0.01)
            position(BOTTOM) tag("remove") cyl(d=12, l=3-0.5, anchor=BOTTOM);
        }
        tag("remove") position(BOTTOM) text3d("BOTTOM", h=0.2, size=10, anchor=TOP, orient=DOWN);
    }
}

module slide_mask()
{
    full_thickness = 4;
    diff() {
        cuboid([140, 100, full_thickness], rounding=7, except=[TOP, BOTTOM])
        {
           slide_depth = 1.5;
           tag("remove") xcopies(n=2, l=110 + 12) ycopies(n=2, l=75+6) cyl(d=16, l=10);
           tag("remove") position(TOP) down(slide_depth) cuboid([50, 50, 5], rounding=2, except=[TOP, BOTTOM], anchor=BOTTOM) 
           position(BOTTOM+BACK+RIGHT) slot(d=20, h=slide_depth, spread=20, anchor=BOTTOM, spin=45);
           tag("remove") cuboid([40, 40, 5]);
           tag("remove") position(BOTTOM) xcopies(n=(140 / 4)-10, spacing=4) cuboid([2, 100, 0.5], anchor=BOTTOM);
        }
    }
    
}

// magnet_jig();

// bottom_half(200)
// right_half(200)
// worklight_diffuser();

// magnet_cutout_cyl(mag_diam, mag_thickness, l=full_thickness, anchor=TOP);

// worklight_diffuser_rim_mount();
// up(0.7)
// worklight_diffuser_quick_mag();
// #up(10)
slide_mask();
