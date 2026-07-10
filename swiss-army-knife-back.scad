include <openscad-library-manager/BOSL2/std.scad>

$fn=50;
hole_spacing=[46, 7];
hole_diam = 3.1;
toothpick_length = 45;
toothpick_width = 3.1;
toothpick_thickness = 1.5;
back_size = [58.5, 14, 2.5];

module back()
{
  diff() {
    cuboid([back_size[0]-back_size[1], back_size[1], back_size[2]], rounding=back_size[2]/2, teardrop=true, edges=BOTTOM) {
      xcopies(n=2, l=back_size[0]-back_size[1]) cyl(d=back_size[1], l=back_size[2], teardrop=true, rounding1=back_size[2]/2);
      tag("remove") grid_copies(n=[2,2], spacing=hole_spacing) {
        // position(TOP) down(1.15) cuboid([hole_diam+0.2, hole_diam+0.2, 0.5], anchor=BOTTOM)
        //   position(TOP) cyl(d=hole_diam-0.2, l=10, anchor=BOTTOM);
        // first cyl is the resting spot.
        position(TOP) down(1.25) cyl(d=hole_diam, l=0.6, anchor=BOTTOM)
          // this is the cube for the toothpick channel
          cuboid([5, hole_diam, 0.6], anchor=RIGHT) {
            // this is the insertion hole
            position(LEFT+BOTTOM) cyl(d=hole_diam, l=10, anchor=BOTTOM);
            // this is the channel for the skinnier part
            position(TOP) cuboid([5, 2.5, 10], anchor=BOTTOM);
            // this is the rest of the resting cyl
            position(RIGHT+BOTTOM) cyl(d=2.5, l=10, anchor=BOTTOM);
          }
      }
      tag("remove") left(back_size[1]/2) position(TOP+LEFT) cuboid([toothpick_length, toothpick_width, toothpick_thickness], anchor=TOP+LEFT) {
        position(LEFT+TOP) cuboid([3.5, toothpick_width, 10], anchor=TOP+LEFT);
        position(LEFT+BOTTOM+FRONT) right(14.5) cyl(d=1, l=10, anchor=BOTTOM);
       }
      tag("keep") position(TOP+LEFT) left(back_size[1]/2) right(14.5) down(toothpick_thickness) cyl(d=0.75, l=5, orient=FRONT);
    }
  }
}

back();
