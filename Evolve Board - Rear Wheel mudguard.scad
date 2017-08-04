wheel_outer_radus = 90;
wheel_inner_max_radius = 65;
wheel_width = 52;
dist_btw_mount_bolts = 29;
mount_block_diameter = 53;
hub_to_mount_bolt_hole = 83;
m4_bolt_hole_radius = 2;
motor_mount_to_wheel_centre = 48;

mudguard_thickness = 4;
mudguard_inner_radus = wheel_outer_radus + 15;
mudguard_outer_radus = mudguard_inner_radus + mudguard_thickness;

//unknowns
motor_mount_angle=20;


translate([0,0,motor_mount_to_wheel_centre])
%wheel2();
mounting_holes();
mounting_bracket();
mudguard();

module mudguard() {
    rotate([0,0,20])
    intersection() {
        difference() {
            translate([0,0,motor_mount_to_wheel_centre])
            resize([mudguard_outer_radus*2, mudguard_outer_radus*2, 50])
            wheel2();

            translate([0,0,motor_mount_to_wheel_centre])
            resize([mudguard_inner_radus*2, mudguard_inner_radus*2, 50])
            wheel2();
        }
        translate([25,mudguard_outer_radus,motor_mount_to_wheel_centre])
        rotate([90,0,0])
        {
            cylinder(mudguard_outer_radus*2, wheel_width/2, wheel_width/2);
            translate([0,-wheel_width/2,0])
            cube([mudguard_outer_radus*2,wheel_width,mudguard_outer_radus*2],false);
        }
    }
}

module mounting_bracket() {
    translate([0,70,-5])
    cylinder(5, mount_block_diameter/2, mount_block_diameter/2);
}

module mounting_holes() {
    translate([0,hub_to_mount_bolt_hole,0])
    {
        translate([dist_btw_mount_bolts/2,0,0])
        m4_bolt(20);
        translate([-dist_btw_mount_bolts/2,0,0])
        m4_bolt(20);
    }
}

module m4_bolt(length) {
    cylinder(length, m4_bolt_hole_radius, m4_bolt_hole_radius);
}

module wheel2() {
    intersection() {
        resize([wheel_outer_radus*2,wheel_outer_radus*2,100])sphere(wheel_outer_radus);
        cylinder(wheel_width, wheel_outer_radus, wheel_outer_radus, true);
    }
}

module wheel() {
    wheel_half();
    rotate([180,0,0])wheel_half();
    
}

module wheel_half() {
    cylinder(wheel_width/2, wheel_outer_radus, 77, false);
}