include <../BOSL2/std.scad>
include <../BOSL2/threading.scad>

$fn=50;

bearing_od=37.1;
bearing_l=7;
chamfer_amount = 2;
overall_thickness = bearing_l+chamfer_amount*2;
wall_thickness = 3;
pitch=4;
thread_d = 70;
thread_starts=4;
internal_threaded=true;

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

module redirector_v2(internal_thread=false)
{
    diff() {
        cyl(d=outer_diam, l=wall_thickness) {
            thread_l = overall_thickness-wall_thickness;
            if (internal_thread)
            {
                position(BOTTOM) cyl(d=100, l=thread_l, anchor=BOTTOM)
                tag("remove") threaded_rod(starts=thread_starts, d=thread_d, l=thread_l, pitch=pitch, internal=true, $slop=0.2);
                position(BOTTOM) tag("remove") cyl(d=bearing_od, l=overall_thickness, chamfer=-chamfer_amount, anchor=BOTTOM);
            }
            else
            {
                position(TOP) threaded_rod(starts=thread_starts, d=thread_d, l=thread_l, pitch=pitch, internal=false, anchor=BOTTOM);
                position(BOTTOM) tag("remove") cyl(d=bearing_od, l=overall_thickness, chamfer=-chamfer_amount, anchor=BOTTOM);
            }
            // #position(BOTTOM) up(2) cyl(d=10, l=7, anchor=BOTTOM);
            // cyl(d=outer_diam, l=bearing_l+chamfer_amount) {
        // tag("remove") cyl(d=bearing_od, l=bearing_l+chamfer_amount, chamfer=-chamfer_amount);
        // position(BOTTOM) up(3) threaded_rod(d=70, l=6, pitch=1.1, internal=false, anchor=BOTTOM);
        // position(BOTTOM) up(3) tag("remove") tube(id=80, od=200, l=10, anchor=BOTTOM);
        }
    }
}
// redirecter();
// up(30)
redirector_v2(internal_threaded);
// up(20) 
// xrot(180)
// redirector_v2(false);
