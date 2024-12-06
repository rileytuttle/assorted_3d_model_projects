include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn=50;

x_inches = 6.75 * INCH;
y_inches = 7.25 * INCH;
z_mm = 60;

echo(str("x,y = ", x_inches, ",", y_inches));
x_mm = 170;
y_mm = 185;

soap_d = 62;
flashlight_d = 27;

handle_mount_spacing = 110;
drop_down_amount = 7;

top = false;
middle = false;
bottom = false;

module center_console_caddy()
{
    diff() {
        cuboid([x_mm, y_mm, z_mm], anchor=TOP, chamfer=3, edges=BOTTOM) {
            // soap and vaseline
            right(40) fwd(10) ycopies(n=2, spacing = soap_d+10)
            position(TOP) tag("remove") cyl(d=soap_d, l=55, anchor=TOP, chamfer2=-3)
                cyl(d=soap_d-20, l=100);
            // flashlight
            left(20) tag("remove") position(TOP) cyl(d=flashlight_d, l=100, anchor=TOP, chamfer2=-3)
                position(TOP) cuboid([10, 7+flashlight_d/2, 100], anchor=TOP+FRONT, chamfer=-2, edges=TOP+BACK);
            // knife
            left(20) fwd(45) tag("remove") position(TOP) cuboid([16, 39, 100], anchor=TOP, chamfer=-2, edges=TOP)
                position(TOP+RIGHT) cuboid([16, 6, 100], anchor=TOP+BACK, spin=90);
            // vaseline chapstick
            left(20) back(40) tag("remove") position(TOP) cyl(d=20, l=50, chamfer2=-2, anchor=TOP)
                cyl(d=15, l=100);
            // kazoo
            left(20) back(70) tag("remove") position(TOP) cuboid([18, 22, 100], anchor=TOP, chamfer=-2, edges=TOP);
            // cord cutout
            left(15) tag("remove") position(BACK+RIGHT) cuboid([35, 10, z_mm], chamfer=-2, edges=[TOP, BOTTOM], anchor=BACK+RIGHT);
            // pens
            left(55) back(5) tag("remove") position(TOP) cuboid([30, 145, 15], anchor=TOP, chamfer=-2, edges=TOP)
                position(BOTTOM) cyl(d=30, l=145, orient=FRONT);
            // cards
            left(40) fwd(80) tag("remove") position(TOP) cuboid([65, 10, z_mm-2], anchor=TOP, chamfer=-2, edges=[TOP+FRONT, TOP+BACK]);
            // anker 12 v adapter
            back(10) down(13) position(LEFT) tag("remove")
                teardrop(anchor=FRONT, d=30, 18, chamfer1=-2, chamfer2=2.25, spin=-90, cap_h=18)
                position(BACK) teardrop(d=21, l=25, chamfer2=4, chamfer1=-2.25, anchor=FRONT, cap_h=12);
            // rail lip fillets
            for (loc = [[3, LEFT, -90],[-3, RIGHT, 180]])
            {
                translate([loc[0], 0])
                position(TOP+loc[1])
                fillet(r=6, l=y_mm, orient=BACK, spin=loc[2]);
            }
            // mounting
            tag("remove")
            for (pos = [[LEFT+TOP, RIGHT, LEFT, -90], [RIGHT+TOP, LEFT, RIGHT, 90]])
            position(pos[0]) cube([3, y_mm, 10], anchor=pos[0])
                position(pos[1]) ycopies(n=3, l=y_mm-10) screw_hole("M3", thread=false, l=11, anchor=TOP, orient=pos[2], teardrop=true, spin=pos[3])
                    down(5) position(TOP) nut_trap_side(10, "M3", anchor=TOP, spin=90);
            // handle mounting
            for (loc=[
                    [handle_mount_spacing/2, 20, 25],
                    [-handle_mount_spacing/2, 20, -30]
                    ])
            {
                fwd(10) position(TOP) fwd(loc[0]) screw_hole("M4", thread=false, l=15, anchor=TOP)
                    down(5) position(TOP) nut_trap_side(loc[1], "M4", spin=loc[2], anchor=TOP);
            }
            
            // multitool
            // #left(70) down(10)
            // #position(LEFT) tag("remove") cuboid([15, 22, 70], anchor=TOP, chamfer=-2, edges=TOP, orient=LEFT);

            // 18650 extra battery
            left(70) down(10) position(BACK) tag("remove") teardrop(d=19, l=66, anchor=BACK, spin=0, chamfer2=-2, cap_h=12);
            // extra through hole
            position(TOP) back(70) right(12) tag("remove") cyl(d=25, l=z_mm, anchor=TOP, chamfer=-2);
            
            for (loc=[
                 [[-55,(y_mm/2)-5], 10, 90],
                 [[-34, -55], 10, 180],
                 [[-77, -55], 10, 0],
                 [[5, -15], 20, 220],
                 [[65, 70], 20, 90],
                 [[70, -75], 15, 45],
                 ])
            {
                debug = false;
                top_meat = 5;
                translate(loc[0])
                up(debug ? top_meat : 0) down(top_meat) position(TOP) screw_hole("M3", l=40 + (debug ? top_meat : 0) , head="socket", counterbore=20, anchor=BOTTOM, orient=DOWN)
                    position(BOTTOM) up(3+(debug ? top_meat : 0)) nut_trap_side(loc[1], "M3", spin=loc[2], anchor=BOTTOM);
            }
        }
    }
}

module handle(anchor=CENTER, orient=UP, spin=0)
{
    dist_up = 20;
    flat_dist = 60;
    up_dist = (handle_mount_spacing-flat_dist)/2;
    handle_thickness = 12;
    path = [
        [-handle_mount_spacing/2, 0],
        [-handle_mount_spacing/2, 5],
        [-handle_mount_spacing/2+up_dist, dist_up],
        [handle_mount_spacing/2-up_dist, dist_up],
        [handle_mount_spacing/2, 5],
        [handle_mount_spacing/2, 0]
    ];
    attachable(anchor=anchor, orient=orient, spin=spin) {
        xrot(90)
        diff() {
            intersect() {
                path_sweep2d(rect([handle_thickness, handle_thickness], chamfer=[1, 4, 4, 1]), path) {
                    path_sweep2d(apply(left(30), rect([50, 4], chamfer=[0, 0, 0, 0])), path);
                    tag("intersect") cube([200, 100, 20], anchor=FRONT);
                    xcopies(n=2, l=handle_mount_spacing)
                    tag("remove") screw_hole("M4", thread=false, head="socket", l=8, anchor=BOTTOM, orient=BACK, counterbore=20);
                }
            }
        }
        children();
    }
}

module rail()
{
    top_thickness = 3;
    thickness = 3;
    diff() {
        cube([thickness, y_mm, 10+drop_down_amount], anchor=BOTTOM+LEFT) {
            position(LEFT+TOP) cube([15, y_mm, top_thickness], anchor=RIGHT+TOP)            
                position(BOTTOM+RIGHT) fillet(r=5, l=y_mm, orient=BACK, spin=90);
            position(LEFT+BOTTOM) up(10/2) ycopies(n=3, l=y_mm-10) screw_hole("M3", head="flat", l=thickness+1, anchor=TOP, orient=LEFT, teardrop=true, spin=90)
                position(TOP) teardrop(d=6.75, l=20, anchor=FRONT, orient=BACK, spin=180, cap_h=3.5);
        }
    }
}

module center_console_caddy_top()
{
    intersection() {
        center_console_caddy();
        down(20) cube([200, 200, 100], anchor=BOTTOM);
    }
}

module center_console_caddy_middle()
{
    intersection() {
        center_console_caddy();
        down(20) cube([200, 200, 20], anchor=TOP);
    }
}

module center_console_caddy_bottom()
{
    intersection() {
        center_console_caddy();
        down(40) cube([200, 200, 100], anchor=TOP);
    }
}

// top_half(300)
// up(11)
// fwd(10)
handle(spin=90);

// left(x_mm/2)
// down(10)
// rail();

if (top) center_console_caddy_top();
if (middle) center_console_caddy_middle();
if (bottom) center_console_caddy_bottom();
