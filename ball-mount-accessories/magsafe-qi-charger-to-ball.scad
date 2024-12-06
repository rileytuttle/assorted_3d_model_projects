// this is for this particular qi magsafe charger https://www.amazon.com/dp/B0D97Z9QRW?ref=ppx_yo2ov_dt_b_fed_asin_title&th=1

include <BOSL2/std.scad>
include <rosetta-stone/ball-mount-bits.scad>
include <BOSL2/screws.scad>
include <rosetta-stone/std.scad>

$fn=50;

charger_d = 62;
charger_l = 9.5;
ball_d = 1 * INCH;
side_screw_r = 25;

module magsafe_charger_mock(anchor=CENTER, orient=UP, spin=0)
{
    attachable(size=[charger_d, charger_d, charger_l], anchor=anchor, orient=orient, spin=spin)
    {
        cyl(d=charger_d, l=charger_l, rounding=4)
            position(FRONT) back(2)
            cyl(d=4, l=30, anchor=TOP, orient=BACK);
        children();
    }
}

module magsafe_to_ball_mount(ball_d=1 * INCH, anchor=BOTTOM, orient=UP, spin=0)
{
    attachable(anchor=anchor, orient=orient, spin=spin)
    {
        diff() {
            cyl(d=charger_d+10, l=15) {
                tag("remove") position(BOTTOM)
                magsafe_charger_mock(anchor=BOTTOM);
                position(TOP)
                ball_with_circular_base(ball_d, [charger_d+10, 5], [15, 15], flare_neck_bottom=-10, anchor=BOTTOM)
                    tag("remove") {
                        left(8)
                        position("ball-center") screw_hole("M3", l=18, anchor="head_bot", orient=LEFT, thread=true, head="socket", counterbore=5, thread_len=10);
                        position(BOTTOM) ycopies(n=2, l=side_screw_r*2)
                        left(10)
                        screw_hole("M3", l=25, anchor="head_bot", orient=LEFT, thread=true, head="socket", counterbore=20, thread_len=14);
                    }
            }
        }
        children();
    }
}

module zrot_partial_tubes(arc_ang, ir, or, l, angs, n, anchor=CENTER, spin=0)
{
    attachable(anchor=anchor, orient=UP, spin=spin, size=[0, 0, l]) {
        intersect() {
            tube(ir=ir, or=or, l=l);
            tag("intersect")
            position(BOTTOM) zrot_copies(rots=angs, n=n)
            {
                pie_slice(ang=arc_ang, l=l, r=or+1);
            }
        }
        children();
    }
}

module amps_adapter_plate(with_see_through_holes=false, anchor=CENTER, orient=UP, anchor=CENTER, spin=0)
{
    top_meat = 10;
    pie_slice_ang = 12;
    base_angs = [
        25, 70
    ];
    see_through_hole_angs = [
        0,
        base_angs[0],
        base_angs[1],
        180-base_angs[1],
        180-base_angs[0],
        180,
        180+base_angs[0],
        180+base_angs[1],
        -base_angs[1],
        -base_angs[0],
    ];
    attachable(anchor=anchor, orient=orient, spin=spin)
    {
        diff() {
            cyl(d=charger_d+6, l=charger_l+top_meat) {
                tag("remove") position(BOTTOM)
                magsafe_charger_mock(anchor=BOTTOM);
                tag("remove") position(TOP) grid_copies(n=2, spacing=amps_spacing) {
                    up(0.01) screw_hole("M4", l=top_meat+1, anchor=TOP, thread=false, teardrop=true, spin=$pos[0]>0 ? -90 : 90)
                        position(TOP) down(4) nut_trap_side(20, "M4", spin=90, anchor=TOP);
                }
                tag("remove") cube([0.5, 100, 20], anchor=CENTER);
                if (with_see_through_holes) {
                    tag("remove") position(TOP) zrot_partial_tubes(pie_slice_ang, 53/2, 57/2, top_meat+2, angs=see_through_hole_angs, anchor=TOP, spin=-pie_slice_ang/2);
                }
            }
        }
        children();
    }
}

// back_half()
// fwd(side_screw_r)
// magsafe_to_ball_mount(ball_d);
// left_half()
right_half()
amps_adapter_plate(with_see_through_holes=true);

// zrot_partial_tubes(10, 53, 57, 10, 10);
