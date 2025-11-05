include <../openscad-library-manager/BOSL2/std.scad>
include <../openscad-library-manager/BOSL2/screws.scad>

$fn=50;

stem_screw_type = "M6";
flanged_nut_diam = 18;
cam_angle = 12;
mount_width = 30;
nut_grab_thickness = 7;
mount_socket_cap_type = "M4";

module reference()
{
    right(15)
    right(15)
    back(52.5)
    up(20)
    yrot(180)
    xrot(-90)
    import("truck_camera_bracket.stl");
}

module screw_side_pocket()
{
    cord_channel=4;
    nut_oversize = 14;
    fwd(22.5)
    xrot(-cam_angle)
    up(nut_grab_thickness)
    fwd(13.5)
    screw_hole(stem_screw_type, l=20, anchor=TOP, teardrop=true, spin=-90) {
    position(BOTTOM) zrot(90) left(cord_channel/2) cuboid([50, cord_channel, 20+20], rounding=cord_channel/2, edges=[LEFT+FRONT, LEFT+BACK], anchor=LEFT+BOTTOM);
    position(TOP) teardrop(d=14, l=20, anchor=BACK, orient=BACK);
    }
}

module bracket()
{
    diff() {
        cuboid([mount_width, 20, 60], anchor=BOTTOM+BACK) {
            tag("remove") position(BACK+TOP) back(1) up(1) cuboid([mount_width+1, 10+1, 25+1], anchor=TOP+BACK);
            position(BOTTOM+BACK) up(45) fwd(10) 
            screw_hole(mount_socket_cap_type, head="socket", orient=BACK, l=20, anchor=TOP, teardrop=true, spin=-90);
            tag("remove") position(BACK+BOTTOM) up(45+10) fwd(10) back(0.5) cyl(d=5, l=11, anchor=TOP, orient=BACK);
            #tag("remove") position(BACK+BOTTOM) up(45+10) fwd(10) back(0.5) yrot(90) teardrop(d=5, l=11, anchor=BACK, cap_h=3);
            tag("remove") position(BOTTOM+FRONT) up(20) fwd(1) cuboid([mount_width+1, 10+1, 5], anchor=BOTTOM+FRONT);
            position(BOTTOM+BACK) cuboid([mount_width, 60, 20], anchor=BOTTOM+BACK, chamfer=4, edges=FRONT+TOP);
            position(BOTTOM+BACK) tag("remove") screw_side_pocket();
            tag("remove") position(BACK+BOTTOM)
            fwd(22.5) 
            xrot(-cam_angle)
            cuboid([mount_width+1, 100, 20], anchor=BACK+TOP);
            up(20) position(BACK+BOTTOM+RIGHT) tag("remove") cuboid([10, 41, 6], anchor=RIGHT+TOP+BACK);
            tag("remove")
            position(BACK+BOTTOM)
            up(10)
            fwd(59)
            xrot(-(90+cam_angle)/2)
            cuboid([mount_width, 10, 10], anchor=TOP);
        }
    }
}

// one off socket you need to install the camera because there is a cord that comes out through the mounting screw
module installation_socket()
{
    diff()
    {
        cyl(d=14, l=30) {
            up(10) tag("remove") position(LEFT+BOTTOM) right(1.5) cuboid([10, 30, 30], anchor=RIGHT+BOTTOM, chamfer=2, edges=RIGHT+BOTTOM);
            up(10) tag("remove") position(RIGHT+BOTTOM) left(1.5) cuboid([10, 30, 30], anchor=LEFT+BOTTOM, chamfer=2, edges=LEFT+BOTTOM);
            down(0.1) position(BOTTOM) tag("remove") nut_trap_inline(10, stem_screw_type, anchor=BOTTOM);
            channel_d = 3.5;
            left(channel_d/2) tag("remove") cuboid([20, channel_d, 31], anchor=LEFT, rounding=channel_d/2, edges=[LEFT+FRONT, LEFT+BACK]);
        }
    }
}



// reference();
bracket();
// installation_socket();
// screw_side_pocket();
