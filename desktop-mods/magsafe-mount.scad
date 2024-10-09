include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn=50;

charger_d = 61;
charger_l = 9.5;

module magsafe_charger_mock(anchor=CENTER, orient=UP, spin=0)
{
    attachable(size=[charger_d, charger_d, charger_l], anchor=anchor, orient=orient, spin=spin)
    {
        cyl(d=charger_d, l=charger_l, rounding=4)
            position(FRONT) back(2)
            cyl(d=5, l=30, anchor=TOP, orient=BACK);
        children();
    }
}

// amount to round the corners. this has to be bigger than the bear guide on the bit
corner_rounding = 10;
block_size = [65, 65];
desk_thickness = 15.5;
screw_spacing_fudge = 8;
screw_spacing = [block_size[0]-corner_rounding/2+screw_spacing_fudge, block_size[1]-corner_rounding/2+screw_spacing_fudge];
corner_expand_factor = 1.75;
top_size = [screw_spacing[0]+corner_rounding*corner_expand_factor, screw_spacing[1]+corner_rounding*corner_expand_factor, charger_l/2];
bottom_size = [block_size[0], block_size[1], desk_thickness-top_size[2]];
echo(str("top dims: width=", top_size[0], ", height=", top_size[1]));
echo(str("screw spacing: [", screw_spacing[0], ",", screw_spacing[1], "]"));

module router_template()
{
}

module magsafe_block_mount_top()
{
    diff() {
        cuboid(top_size, rounding=corner_rounding, except=[TOP,BOTTOM]) {
            tag("remove") position(TOP) magsafe_charger_mock(anchor=TOP);
            tag("remove") position(TOP) grid_copies(n=2, spacing=screw_spacing) screw_hole("M4", thread=false, l=100, anchor=TOP, head="flat");
        }
    }
}

module magsafe_block_mount_bottom()
{
    diff() {
        cuboid(bottom_size, rounding=corner_rounding, except=[TOP,BOTTOM]) {
            position(BOTTOM) cuboid([top_size[0], top_size[1], 5], anchor=TOP, rounding=corner_rounding, except=[TOP,BOTTOM]) {
                tag("remove") position(TOP) grid_copies(n=2, spacing=screw_spacing) {
                    #screw_hole("M4", thread=false, l=5, anchor=TOP)
                        position(BOTTOM) nut_trap_inline(3, "M4", anchor=BOTTOM);
                }
            }
            tag("remove") position(TOP) magsafe_charger_mock();
        }
    }
}

// magsafe_block_mount_top();
// down(10)
magsafe_block_mount_bottom();
