include <BOSL2/std.scad>
include <rosetta-stone/boards.scad>
include <BOSL2/screws.scad>

$fn=50;

width=468;
height=518;
xspread=width-2*144;
yoffset=87.5;
yspread=height-2*yoffset;
xspread2=width-2*79;
yoffset2=167.5;
echo(str("small x spread = ", xspread));
echo(str("wide x spread = ", xspread2));
echo(str("y spread = ", yspread));
new_y_hole_offset = 90;
// new_hole_y_spread = yspread - 90 - 35;
new_hole_y_spread = 220;
echo(str("new y hole spread", new_hole_y_spread));
post_size = [15, 30, 64+3];
strap_hole_offset=5;
horizontal_strap_len = xspread + (post_size[0]/2 - 2 - strap_hole_offset) * 2;
echo(str("horiz strap hole length = ", horizontal_strap_len));
post_mount_hole_offset = 7;
vertical_strap_offset = 12;
vertical_strap_len = new_hole_y_spread - (post_size[1] - vertical_strap_offset -post_mount_hole_offset+strap_hole_offset)*2;
echo(str("vertical_strap_len = ", vertical_strap_len)); 
module top_plate_sim()
{
    anchor_list = [
        named_anchor("top-left-hole", [-xspread/2, yspread/2, 0]),
    ];
    attachable(spin=0, orient=UP, anchor=CENTER, size=[width,height,1], anchors=anchor_list) {
        diff() {
            cube([width,height,1], anchor=CENTER) {
                tag("remove") {
                    ycopies(l=yspread, n=2)
                        xcopies(l=xspread, n=2)
                        cyl(d=3.5, l=1.1);
                    position(FRONT)
                    back(yoffset2)
                    xcopies(l=xspread2, n=2)
                        cyl(d=3.5, l=1.1);
                    position(BACK)
                    fwd(yoffset+new_hole_y_spread)
                        xcopies(l=xspread, n=2)
                        cyl(d=3.5, l=1.1);
                }
            }
        }
        children();
    }
}

module buffer_sim(anchor=CENTER, spin=0, orient=UP) {
    size = [155, 265, 64];
    attachable(anchor=anchor, spin=spin, orient=orient, size=size) {
        cube(size, anchor=CENTER)
            position(RIGHT)
            right(40)
            cube([150+87, 135, 64], anchor=RIGHT);
        children();
    }
}

module post(anchor=CENTER, spin=0) {
    size=post_size;
    mount_hole_offset=post_mount_hole_offset;
    strap_pocket_width = 11;
    anchor_list = [
        named_anchor("mount-hole", [0, post_size[1]/2-mount_hole_offset, 0]),
        named_anchor("strap-hole-vertical", [0, -size[1]/2 + vertical_strap_offset - strap_hole_offset, size[2]/2 - 3/2]),
        named_anchor("strap-hole-horizontal", [-size[0]/2 + 2 + strap_hole_offset, size[1]/2 - 2 -strap_pocket_width/2, size[2]/2 - 3/2]), 
    ];
    attachable(anchor=anchor, spin=spin, orient=UP, size=size, anchors=anchor_list) {
        diff() {
            cube(size, anchor=CENTER) {
                tube_d = 2.75;
                // mount hole
                tag("remove")
                position(BOTTOM+BACK)
                fwd(mount_hole_offset)
                down(0.1)
                cyl(d=tube_d, l=10, anchor=BOTTOM)
                    position(BOTTOM)
                    up(3)
                    tag("remove")
                    nut_trap_side(10, "M3", poke_len=10, spin=180, anchor=BOTTOM);
                tag("remove") {
                    // vertical strap slot
                    position(TOP+FRONT)
                    back(vertical_strap_offset)
                    up(0.1)
                    cube([strap_pocket_width, 100, 3], anchor=TOP+BACK) {
                        position(BACK+BOTTOM)
                        up(0.1)
                        fwd(strap_hole_offset)
                        cyl(d=tube_d, l=10, anchor=TOP)
                            position(TOP)
                            down(3)
                            nut_trap_side(10, "M3", poke_len=10, spin=180, anchor=TOP);
                    }
                    // horizontal strap slot
                    position(TOP+BACK+LEFT)
                    right(2)
                    up(0.1)
                    fwd(2)
                    cube([strap_pocket_width, 100, 3], anchor=TOP+BACK+RIGHT, spin=90) {
                        position(BACK+BOTTOM)
                        up(0.1)
                        fwd(strap_hole_offset)
                        cyl(d=tube_d, l=10, anchor=TOP)
                            position(TOP)
                            down(3)
                            nut_trap_side(10, "M3", poke_len=10, spin=90, anchor=TOP);
                    }
                }
            }
        }
        children();
    }
}

module hole_alignment_template(anchor=CENTER) {
    anchor_list = [
        named_anchor("top-left-hole", [-xspread/2, new_hole_y_spread/2, 0]),
    ];
    attachable(spin=0, orient=UP, anchor=anchor, anchors=anchor_list) {
        path=[
            [-xspread/2, new_hole_y_spread/2],
            [xspread/2, new_hole_y_spread/2],
            [-xspread/2, -new_hole_y_spread/2],
            [-xspread/2, new_hole_y_spread/2],
        ];
        // diff() {
        //     cube([xspread+5, new_hole_y_spread+5, 1], anchor=CENTER) {
        //         tag("remove")
        //         cube([xspread-5, new_hole_y_spread-5, 1.1], anchor=CENTER);
        //         tag("remove")
        //         mount_holes4([xspread, new_hole_y_spread], l=1.1, d=4);
        //     }
        // }
        difference() {
            linear_extrude(1) stroke(path, width=10);
                for (i=[0:2])
                {
                    translate(path[i])
                    cyl(d=3.5, l=10);
                }
        }
        children();
    }
}

module strap(len, thickness, anchor=CENTER, spin=0) {
    anchor_list = [
        named_anchor("mount-hole1", [0, len/2, 0]),
        named_anchor("mount-hole2", [0, -(len/2), 0]),
    ];
    attachable(spin=spin, orient=UP, anchor=anchor, size = [10, len, thickness], anchors=anchor_list) {
        diff() {
            cube([10, len+strap_hole_offset*2, thickness], anchor=CENTER) {
                tag("remove") {
                    ycopies(l=len, n=2)
                    cyl(d=3.5, l=thickness+1);
                }
            }
        }
        children();
    }
}

module assem() {
    top_plate_sim() {
        position("top-left-hole")
        up(post_size[2]/2)
        up(2)
        color_this("red")
        for (data = [
             // disp, mirror flip, spin, straps
             [[0, 0], false, 0, true],
             [[xspread, 0], true, 180, false],
             [[0, -new_hole_y_spread], true, 0, false],
             [[xspread, -new_hole_y_spread], false, 180, true],
             ]) {
            translate(data[0])
            mirror([0, data[1] ? 1 : 0, 0])
            post(anchor="mount-hole", spin=data[2]) {
                if(data[3]) {
                    color_this("blue")
                    up(2) {
                
                        position("strap-hole-horizontal")
                        strap(len=horizontal_strap_len, thickness=3, anchor="mount-hole1", spin=90);
                        position("strap-hole-vertical")
                        strap(len=vertical_strap_len, thickness=3, anchor="mount-hole1", spin=0); 
                    }
                }
            }
        }
        position(TOP)
        up(2)
        back(47)
        color("brown")
        buffer_sim(anchor=BOTTOM);
    }
}

strap(len=horizontal_strap_len, thickness=3);
// strap(len=vertical_strap_len, thickness=5); 
    
// up(2)
// color("blue") hole_alignment_template(anchor="top-left-hole");

// mirror([1, 0, 0])
// post();

// assem();

