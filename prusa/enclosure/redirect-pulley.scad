include <BOSL2/std.scad>

$fn=50;

outer_diam = 150;
hole_diam = 25;
// thickness = 15;
thickness = 6;
pie_ang = 50;
pie_start_r = (hole_diam/2) + 5;
pie_r = 40;
slope = 0.70;

// path=[
//     circle(d=outer_diam),
//     circle(d=outer_diam),
//     circle(d=outer_diam-40),
//     circle(d=outer_diam-40),
//     circle(d=outer_diam),
//     circle(d=outer_diam)
// ];

// zs=[
//     -thickness/2,
//     (-thickness/2)+2,
//     -1,
//     1,
//     (thickness/2)-2,
//     thickness/2
// ];

path=[
    circle(d=outer_diam),
    circle(d=outer_diam),
    circle(d=outer_diam-40),
    circle(d=outer_diam-40),
    circle(d=outer_diam),
    circle(d=outer_diam)
];

zs=[
    -thickness/2,
    (-thickness/2)+2,
    -1,
    1,
    (thickness/2)-2,
    thickness/2
];

// inner_d = outer_diam-(thickness-6)/slope;

// path=[
//     circle(d=outer_diam),
//     circle(d=outer_diam),
//     circle(d=inner_d),
//     circle(d=inner_d),
//     circle(d=outer_diam),
//     circle(d=outer_diam)
// ];

// zs = [
//     -thickness/2,
//     (-thickness/2)+2,
//     (-thickness/2)+2,
//     (-thickness/2)+2+2,
//     (thickness/2)-2,
//     thickness/2
// ];
    
module redirecter()
{
    diff() {
        skin(path, z=zs, slices=0) {
            tag("remove") cyl(d=hole_diam, l=thickness);
            tag("remove") 
            diff("spokes-remove") {
                zrot_copies(n=6) right(pie_start_r/2) pie_slice(ang=pie_ang, l=thickness, r=pie_r, anchor=CENTER, spin=-pie_ang/2);
                tag("spokes-remove") cyl(r=pie_start_r, l=thickness);
            }
        }
    }
}
redirecter();
