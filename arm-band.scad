include <BOSL2/joiners.scad>
include <BOSL2/rounding.scad>
include <BOSL2/std.scad>
include <rosetta-stone/hinges.scad>

$fn=30;
thickness = 4;
wrist_circ = 160;
arm_circ = 210;
outer_wrist_circ = wrist_circ+2*PI*thickness;
outer_arm_circ = arm_circ+2*PI*thickness;
length = 100;
inner_diam = outer_wrist_circ/PI;
outer_diam = outer_arm_circ/PI;
x = (outer_diam - inner_diam)/2;
ang1 = asin(x/length);
small_circle_radius = ((outer_diam/2) - (length*sin(ang1))) / sin(ang1);
big_circle_radius = small_circle_radius + length;
ang2 = (outer_wrist_circ * 360) / (2 * PI * small_circle_radius);

echo(str("arc ang = ", ang2));
echo(str("radius = ", big_circle_radius));

angle_per_fin=8;
number_of_fins=50;
echo(str("degrees of rotation", number_of_fins * angle_per_fin));
height_of_cut = thickness-0.4;
minimum_gap = 0.5;
top_length_of_fin = 2*tan(angle_per_fin/2) * height_of_cut + minimum_gap;

outer_bend_diam = outer_diam + thickness*2;
echo(str("outer bend diam = ", outer_bend_diam));

additional_flat_width = 10;
additional_arc_angle = (additional_flat_width * 360) / (2 * PI * small_circle_radius);

dovetail_width = 10;
dovetail_height = 8;
n_dovetails_per_side = 2;

module screen() {
    h=0.2;
    offset_sweep(round_corners(trapezoid(w1=45, w2=40, h=75), r=5), height=h, anchor=TOP);
}

module buttons() {
    x = 13;
    for(i=[-1, 1]) {
        rotate([0, 0, i*x])
        translate([0, -51, 0])
        cyl(l=3, r=5, rounding2=1.5, anchor=BOTTOM);
    }
}

module add_female_dove_tails() {
    rotate([0, 0, ang2/2+additional_arc_angle])
    translate([0, -(big_circle_radius+small_circle_radius)/2 - length/(n_dovetails_per_side*2*2), 1.5])
    ycopies(spacing = length/n_dovetails_per_side, n=n_dovetails_per_side)
    dovetail("female", slide=2.5, width=dovetail_width, height=dovetail_height, chamfer=1, spin=90, anchor=BACK+BOTTOM, orient=LEFT);

    rotate([0, 0, -ang2/2-additional_arc_angle])
    translate([0, -(big_circle_radius+small_circle_radius)/2+length/(n_dovetails_per_side*2*2), 1.5])
    ycopies(spacing=length/n_dovetails_per_side, n=n_dovetails_per_side)
    dovetail("female", slide=2.5, width=dovetail_width, height=dovetail_height, chamfer=1, spin=-90, anchor=BACK+BOTTOM, orient=RIGHT);
}

module add_male_dove_tails() {
    rotate([0, 0, -ang2/2-additional_arc_angle])
    translate([0, -(big_circle_radius+small_circle_radius)/2- length/(n_dovetails_per_side*2*2), 1.5])
    ycopies(spacing=length/n_dovetails_per_side, n=n_dovetails_per_side)
    dovetail("male", slide=2.5, width=dovetail_width, height=dovetail_height, chamfer=1, anchor=BACK+BOTTOM, orient=LEFT, spin=90);

    rotate([0, 0, ang2/2+additional_arc_angle])
    translate([0, -(big_circle_radius+small_circle_radius)/2 + length/(n_dovetails_per_side*2*2), 1.5])
    ycopies(spacing = length/n_dovetails_per_side, n=n_dovetails_per_side)
    dovetail("male", slide=2.5, width=dovetail_width, height=dovetail_height, chamfer=1, anchor=BACK+BOTTOM, orient=RIGHT, spin=-90);
}

module wrist_band_plain() {
    rotate([0, 180, 0])
    diff() {
        linear_extrude(height=thickness) {
            arc(r=big_circle_radius, angle=ang2+additional_arc_angle*2, wedge=true, n=100, start=-90, spin=-ang2/2-additional_arc_angle);
            // arc(r=big_circle_radius, angle=additional_arc_angle, wedge=true, n=100, start=-90+ang2, spin=-ang2/2);
            tag("remove") circle(r=small_circle_radius, $fn=100);
        }
        tag("remove") {
            translate([0, 0, thickness+0.001])
            arc_copies(n=number_of_fins, r=(small_circle_radius+big_circle_radius)/2, sa=-90-ang2/2+0.75, ea=-90+ang2/2-0.75)
            rotate([0, 0, 90])
            hinge_fin(
                angle_per_fin = angle_per_fin,
                cut_depth = length+1,
                height_of_cut = height_of_cut,
                top_length_of_fin = top_length_of_fin,
                minimum_gap=minimum_gap,
                anchor=TOP);
            add_female_dove_tails();
        }
        add_male_dove_tails();
    }
}

difference() {
    union() {
        wrist_band_plain();
        translate([0, -(big_circle_radius+small_circle_radius)/2+10, 0])
        buttons();
    }
    translate([0, -(big_circle_radius+small_circle_radius)/2+8, 0])
    rotate([0, 0, 0])
    screen();
}
