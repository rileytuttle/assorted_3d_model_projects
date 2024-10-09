include <BOSL2/std.scad>
include <ball-mount/ball-mount-bits.scad>
include <rosetta-stone/std.scad>

$fn = 50;


ball_d = 25.5;
// center to center length
length = 75;
screw_profile = "1/4-20"; // ["1/4-20", "M4"]
nut_trap = false;
offset_spring = true;
// amount of meat around the ball at the center of the socket
thickness = 1; 

show_single_piece = true;
show_wingnut = false;
show_full_assem = false;

module just_arm()
{
    double_socket(ball_d, length, screw_profile=screw_profile, nut_trap=nut_trap, offset_spring=offset_spring);
}

module assem()
{
    down(2)
    double_socket(ball_d, length, thickness, screw_profile=screw_profile, nut_trap=true, offset_spring=offset_spring)
    up(4)
    zflip()
    double_socket(ball_d, length, thickness, screw_profile=screw_profile, nut_trap=false, offset_spring=offset_spring)
    position(BOTTOM)
    wingnut(screw_profile=screw_profile, anchor=BOTTOM, orient=DOWN);
}

if (show_single_piece) double_socket(ball_d, length, thickness, screw_profile=screw_profile, nut_trap=nut_trap, offset_spring=offset_spring);
else if (show_wingnut) wingnut(screw_profile=screw_profile);
else if (show_full_assem) assem();

