include <openscad-library-manager/BOSL2/std.scad>
include <openscad-library-manager/BOSL2/screws.scad>
// include <openscad-library-manager/rosetta-stone/std.scad>

$fn=50;

case_d=37;
case_height=10;
case_thickness=2;
case_top_id = case_d+0.3;
case_top_od = case_top_id+case_thickness*2;
top_bottom_chamfer = 3;
mag_size=[5, 10, 2];
mag_offset=(case_d/2+20/2)/2 -0.5;

module case_bottom()
{
    tube_height = 6;
    echo(str("tube height: ", tube_height));
    diff() {
        cyl(d=case_d, l=case_height, anchor=TOP, chamfer1=1) {
            position(TOP) tag("remove") tube(id=15, od=20, l=6, anchor=TOP) {
                #position(FRONT+BOTTOM)
                down(9/2)
                up(2.5/2) back(2) cuboid([9, 9, 12], rounding=2, edges=[BOTTOM+LEFT, BOTTOM+RIGHT], anchor=BACK+BOTTOM) {
                fwd(1.5) position(TOP+BACK+RIGHT) cuboid([8, 1.5, 8.75], spin=55, anchor=TOP);
                fwd(1.5) position(TOP+BACK+LEFT) cuboid([8, 1.5, 8.75], spin=-55, anchor=TOP);
                }
            }
            position(TOP) screw_hole("M12", l=case_height-case_thickness, thread=true, anchor=TOP, $slop=0.25, spin=180);
            position(BOTTOM) tag("remove")cyl(d=8, l=case_thickness, anchor=BOTTOM, chamfer1=-1.25);
            position(BOTTOM) cyl(d=case_top_od-2, l=case_thickness, anchor=BOTTOM, chamfer1=2)
            position(BOTTOM) xcopies(n=2, l=23) up(1) tag("remove") sphere(d=15, anchor=TOP);
            right(mag_offset) position(TOP) tag("remove") cuboid(mag_size, anchor=TOP);
            // tag("remove") back(17.5/2) cuboid([15, 20, 30], anchor=FRONT, rounding=3, edges=[FRONT+LEFT, FRONT+RIGHT]);
            fwd(10.8) #tag("remove") position(BACK+TOP) cuboid([12.5, 20, 7], anchor=FRONT+TOP, rounding=4, edges=[BOTTOM+LEFT, BOTTOM+RIGHT]);
        }
    }
}

module case_top()
{
    diff() {
        tube(id=case_top_id, od=case_top_od, l=case_height-case_thickness-0.1, anchor=TOP, ochamfer1=1-0.1) {
            position(TOP) cyl(d=case_top_od, l=case_thickness+1, anchor=BOTTOM, chamfer2=3) {
                position(BOTTOM) screw("M12", l=case_height-case_thickness, anchor=TOP, head="none", bevel2=false)
                position(TOP) tag("remove") up(case_thickness+1) cyl(d=8, l=case_height+1, anchor=TOP, chamfer2=-1.25);
                position(BOTTOM) tag("remove") right(mag_offset) cuboid(mag_size, anchor=BOTTOM);
                down(1) tag("remove") position(TOP) xcopies(n=2, l=23) sphere(d=15, anchor=BOTTOM);
            }
        }
    }
}

// case_bottom();
case_top();
