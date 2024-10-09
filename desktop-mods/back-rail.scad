include <BOSL2/std.scad>
include <rosetta-stone/std.scad>
include <BOSL2/screws.scad>

$fn=50;

// will round length up
// module back_rail(l, screw_gap=30, depth=30, height=1*INCH, rail_h=30, thickness=5, rail_ang=45, screw_profile="M3", all_holes=false)
// {
//     assert(l > 0);
//     length = ceil(l/(screw_gap))*screw_gap;
//     echo(str("making rail of length ", length, " with ", all_holes ? "all holes" : "two holes"));
//     top_plate_default_screw_locs = [screw_gap/2, length-screw_gap/2];
//     bounds = [ for (i=[0:(length/screw_gap)-1]) i];
//     echo(str("bounds: ", bounds));
//     top_plate_all_holes = [ for (i=bounds) screw_gap/2+i*screw_gap ];
//     echo(str("all screw locs: ", top_plate_all_holes));
//     top_plate_holes = [
//         all_holes ? top_plate_all_holes :
//         top_plate_all_holes[0], top_plate_all_holes[len(top_plate_all_holes)-1]
//     ];
//     echo(str("holes for this rail are at locs ", top_plate_holes));
//     diff(){
//         cube([length, depth, thickness], anchor=CENTER) {
//             position(BACK+TOP) cube([length, thickness, height], anchor=BACK+TOP+FRONT)
//             position(BACK+TOP) xrot(rail_ang) cube([length, thickness, rail_h], anchor=BACK+TOP);
//             for (loc=top_plate_holes) {
//                 tag("remove") right(loc) position(TOP+LEFT) screw_hole(screw_profile, l=thickness, head="flat", anchor=TOP);
//             }
//         }
//     }
// }

// will round length up
module back_rail(
    l,
    screw_gap=30,
    depth=50,
    hole_depth=40,
    height=1*INCH,
    rail_h=30,
    thickness=5,
    rail_ang=45,
    screw_profile="10-24",
    all_holes=false,
    desk_thickness=15.5,
    wedge_h,
    fillet_fudge=0,
    support_fillet_allowed,
    nut_trap_thickness)
{
    assert(l > 0);
    wedge_height = wedge_h == undef ? (desk_thickness + thickness) : wedge_h;
    wedge_depth = wedge_height * tan(rail_ang);
    length = ceil(l/(screw_gap))*screw_gap;
    echo(str("making rail of length ", length, " with ", all_holes ? "all holes" : "two holes"));
    top_plate_default_screw_locs = [screw_gap/2, length-screw_gap/2];
    bounds = [ for (i=[0:(length/screw_gap)-1]) i];
    echo(str("bounds: ", bounds));
    top_plate_all_holes = [ for (i=bounds) screw_gap/2+i*screw_gap ];
    echo(str("all screw locs: ", top_plate_all_holes));
    top_plate_holes = [
        all_holes ? top_plate_all_holes :
        top_plate_all_holes[0], top_plate_all_holes[len(top_plate_all_holes)-1]
    ];
    echo(str("holes for this rail are at locs ", top_plate_holes));
    support_fillet = support_fillet_allowed == undef ? (wedge_height > desk_thickness+thickness+5) : support_fillet_allowed;
    echo(str(support_fillet ? "has " : "does not have ", "a support fillet"));
    anchor_list = [
        named_anchor("top-mounting-platform", [0, depth/2, desk_thickness+thickness/2], orient=[0, cos(rail_ang), sin(rail_ang)]),
    ];
    nut_trap_h = nut_trap_thickness == undef ? 3 : nut_trap_thickness;
    attachable(anchor=CENTER, orient=UP, spin=0, anchors=anchor_list) {
        diff("screw-holes"){
            cube([length, depth, thickness], anchor=CENTER) {
                up(desk_thickness)
                position(BACK+TOP)
                wedge([length, wedge_depth, wedge_height], anchor=FRONT+TOP);
                if (support_fillet) {
                    position(BACK+BOTTOM) fillet(l=length, r=wedge_height - desk_thickness-thickness, orient=LEFT, spin=180);
                }
                for (loc=top_plate_holes) {
                    tag("screw-holes") fwd(hole_depth) right(loc) position(TOP+LEFT+BACK) screw_hole(screw_profile, l=thickness+fillet_fudge, anchor=TOP, teardrop=true, spin=90)
                    position(BOTTOM) nut_trap_inline(nut_trap_h, screw_profile, anchor=BOTTOM, spin=30);
                }
            }
        }
        children();
    }
}

// dell_dock_spacing=63;
// dell_dock_diagonal_spacing=sqrt(dell_dock_spacing*dell_dock_spacing*2);
dell_dock_diagonal_spacing = 3.5 *INCH;
echo(str("diagonal spacing = ", dell_dock_diagonal_spacing));
dell_dock_thickness = 3;

module dell_dock_mount_hole_test()
{
    diff() {
        cube([dell_dock_diagonal_spacing+10, 10, dell_dock_thickness], anchor=CENTER)
            position(TOP) tag("remove") xcopies(n=2, l=dell_dock_diagonal_spacing) screw_hole("M2.5", l=dell_dock_thickness+0.1, anchor=TOP);
    }
}

module rail_spacing_test()
{
    diff() {
        cube([180, 50, 3], anchor=CENTER) {
            position(TOP+BACK) fwd(40) tag("remove") xcopies(n=4, l=165) screw_hole("10-24", l=5, anchor=TOP);
            position(TOP+BACK) cube([180, 5, 20], anchor=FRONT+TOP);
        }
    }
}

module power_strip_to_leg_mount()
{
    diff() {
    }
}

module dell_dock_rail() {
    intersection() {
        diff() {
            back_rail(l=90, screw_gap=55, rail_ang=45, all_holes=false, wedge_h=70, fillet_fudge=0, support_fillet_allowed=false, hole_depth=43, depth=55, nut_trap_thickness=2) {
                tag("remove")
                attach("top-mounting-platform")
                back(45)
                zrot(45)
                xcopies(n=2, l=3.5 * INCH)
                up(0.001)
                screw_hole("M2.5", l=3+0.001, anchor=BOTTOM, orient=DOWN, counterbore=100, head="socket", teardrop=true, spin=-45, head_oversize=5);
            }
        }
        cube([80, 200, 100], anchor=CENTER);
    }
}

module anker_usb_rail_mount()
{
    back_rail(l=110, screw_gap=55, rail_ang=45, all_holes=false, wedge_h=31, support_fillet_allowed=false, hole_depth=43, depth=55, nut_trap_thickness=2)
        attach("top-mounting-platform") cube([110, 5, 12.5], anchor=FRONT+BOTTOM)
        back(23.5) position(BACK+BOTTOM) cube([110, 5, 46], anchor=BOTTOM+FRONT) {
            position(BACK+BOTTOM) fillet(r=10, l=110, orient=LEFT);
            position(BACK+TOP) cube([110, 23.5, 5], anchor=BACK+BOTTOM);
        }
}

module mic_preamp_mount()
{
    intersection() {
        back_rail(l=110, screw_gap=55, rail_ang=45, all_holes=false, wedge_h=55, support_fillet_allowed=false, hole_depth=43, depth=55, nut_trap_thickness=2)
            attach("top-mounting-platform") cube([110, 5, 20], anchor=FRONT+BOTTOM)
            back(45) position(BACK+BOTTOM) cube([110, 5, 90], anchor=BOTTOM+FRONT)
            position(BACK+BOTTOM)
            // wedge([110, 15, 15], anchor=BOTTOM+FRONT);
            fillet(r=20, l=110, orient=LEFT);
        cube([65, 300, 100], anchor=CENTER);
    }
}

module startech_kvm_switch()
{
    intersection() {
        diff() {
            back_rail(l=110, screw_gap=55, rail_ang=45, all_holes=false, wedge_h=30, support_fillet_allowed=false, hole_depth=43, depth=55, nut_trap_thickness=2)
                attach("top-mounting-platform") cube([110, 5, 141], anchor=FRONT+BOTTOM) {
                position(FRONT+BOTTOM) tag("remove") up(15) yrot(-90) teardrop(d=25, l=5, anchor=FRONT, cap_h=15, chamfer=-2);
                position(BACK+BOTTOM) back(17) cube([110, 5, 141], anchor=FRONT+BOTTOM)
                    position(BACK+BOTTOM) fillet(r=15, l=110, orient=LEFT);
                position(TOP+FRONT) cube([110, 17+5*2, 5], anchor=BOTTOM+FRONT);
            }
        }
        cube([72, 500, 500], anchor=CENTER);
    }
}

anker_usb_rail_mount();

// mic_preamp_mount();

// dell_dock_rail();

// startech_kvm_switch();
