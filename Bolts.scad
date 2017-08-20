nothing = 0.01;
m4_bolt_hole_radius = 2*1.3;
m8_bolt_hole_radius = 4*1.3;

module m4_bolt(length) {
    cylinder(h=length, r=m4_bolt_hole_radius);
}

module m8_bolt(length) {
    cylinder(h=length, r=m8_bolt_hole_radius);
}

module m4_nut(length) {
    cylinder(h=length, r=4.5, $fn=6);
}
