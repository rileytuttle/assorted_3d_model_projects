include <../openscad-library-manager/BOSL2/std.scad>
include <../openscad-library-manager/BOSL2/screws.scad>

$fn = 50;

oneu_height = 44.45;
oneu_width = 254;
max_width=245;
oneu_hole_to_hole_width = 236.525;
oneu_hole_to_hole_height = 15.875;
height = 43;
bracket_front_thickness = 5;
bracket_bottom_thickness = 4.5;

elitedesk_face_width = 179;
elitedesk_face_height = 35;
elitedesk_depth = 175;
elitedesk_hole_spacing = [100, 100];
elitedesk_mount_hole_type = "M4";
elitedesk_mount_hole_depth = 9;
elitedesk_bump_out = [135,135,5];
elitedesk_bump_out_offset_from_face = 27;
elitedesk_face_radius = 5;
bracket_face_radius = 5;
mount_hole_offset_from_face = 45;
inner_width = 220;

module pattern() {
  intersect() {
    grid_copies(n=[15,7], spacing=30, stagger=true)
      regular_prism(6, r=15, h=bracket_bottom_thickness+1, spin=30);
    tag("intersect") {
      difference() {
        cuboid([inner_width-10, elitedesk_depth-10, 10]);
        back(mount_hole_offset_from_face+elitedesk_hole_spacing[0]/2) fwd(elitedesk_depth/2) grid_copies(n=[2,2], spacing=elitedesk_hole_spacing) cyl(d=15, l=bracket_bottom_thickness+1);
      }
    }
  }
}

module mount() {
  
  diff() {
    cuboid([inner_width, elitedesk_depth, bracket_bottom_thickness]) {
      position(FRONT+TOP) up(17.75) cuboid([max_width, bracket_front_thickness, oneu_height], anchor=FRONT, rounding=bracket_face_radius, except=[FRONT, BACK])
        #xcopies(n=2, spacing=oneu_hole_to_hole_width) zcopies(n=3, spacing=oneu_hole_to_hole_height) screw_hole("M6", l=bracket_front_thickness+1, orient=BACK, teardrop=true, spin=180);
      tag("remove") pattern();
      #tag("remove") position(FRONT+TOP) up(elitedesk_bump_out[2]) cuboid([elitedesk_face_width, bracket_front_thickness, elitedesk_face_height], anchor=TOP+FRONT, rounding=elitedesk_face_radius, except=[FRONT,BACK], teardrop=true, orient=DOWN);
      #position(TOP+FRONT) back(mount_hole_offset_from_face+elitedesk_hole_spacing[0]/2) grid_copies(n=[2,2], spacing=elitedesk_hole_spacing)
        down(3) screw_hole(elitedesk_mount_hole_type, l=12, head="socket", anchor="shaft_top", orient=DOWN, counterbore=bracket_bottom_thickness+1+3);
      left(inner_width/2) position(FRONT+BOTTOM)
        wedge([5, elitedesk_depth, oneu_height], anchor=FRONT+LEFT+BOTTOM);
      right(inner_width/2) position(FRONT+BOTTOM)
        wedge([5, elitedesk_depth, oneu_height], anchor=FRONT+RIGHT+BOTTOM);
    }
  }

}

mount();
// pattern();
