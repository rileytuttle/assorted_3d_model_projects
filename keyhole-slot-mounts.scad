include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fn=50;
screw_type="10-24"; // ["10-24", "M5"]

module hole_template(spacing_between, thickness=1)
{
    diff() {
        cube([spacing_between+10, 12, thickness], anchor=CENTER) {
        tag("remove") xcopies(n=2, l=spacing_between) screw_hole("10-24", l=thickness+1, thread=false);
        }
    }
}

module dewalt_charger_2x_mount()
{
    spacing_between = 143;
    hole_template(spacing_between);
}

module dewalt_charger_1x_mount()
{
    spacing_between = 4 * INCH;
    hole_template(spacing_between);
}

dewalt_charger_1x_mount();
fwd(20) dewalt_charger_2x_mount();
