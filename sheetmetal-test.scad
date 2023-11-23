include <BOSL2/std.scad>
include <rosetta-stone/sheetmetal.scad>

$fn=30;
sheetmetal_thickness = 3;
bend = true;
bend_radius = 5;
bend_angle = 120;

function second_piece_orient_angle(bend) =
    // if (bend) {
        let (xz = polar_to_cart(1, bend_angle+180))
            [xz[0], 0, xz[1]];
    // }
    // else { LEFT }
// function get_bend_piece_orient_angle(bend) =
//     if (bend) { RIGHT }
//     else { UP }

flatten() {
sheetmetal_bend(sheetmetal_thickness, bend_radius, bend_angle, 100, false, anchor=CENTER) {
    zflip()
    attach(from="attach2", to="attach1")
    sheetmetal_bend(sheetmetal_thickness, bend_radius, bend_angle, 100, bend)
    {
        attach(from="attach2", to="attach1")
            sheetmetal_bend(sheetmetal_thickness, bend_radius, bend_angle, 100, false);
    }
    zflip()
    yrot(90)
    attach(from=FRONT, to="attach1")
    sheetmetal_bend(sheetmetal_thickness, bend_radius+15, bend_angle, 10, bend)
    attach(from="attach2", to="attach1")
    sheetmetal_bend(sheetmetal_thickness, bend_radius+5, bend_angle, 10, bend);
}
}
