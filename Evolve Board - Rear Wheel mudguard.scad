$fa=3;

nothing = 0.01;
m4_bolt_hole_radius = 2*1.3;
m8_bolt_hole_radius = 4*1.3;

wheel_outer_radus = 90;
wheel_inner_max_radius = 65;
wheel_width = 51.5;
dist_btw_mount_bolts = 29.5;
mount_block_diameter = 53;
hub_to_mount_bolt_hole = 80;
motor_mount_to_wheel_centre = 48.5;
wheel_gear_diameter = 108;
pinion_diameter = 30;
pinion_height = 18+2;
sheild_height = 22;
pinion_to_hub_centre = 118-108/2;
cover_inner_to_outer = 11-1;
bolt_length = 20;
mount_block_thickness = 6;

mudguard_thickness = 4;
mudguard_inner_radus = wheel_outer_radus + 15;
mudguard_outer_radus = mudguard_inner_radus + mudguard_thickness;

//unknowns
motor_mount_angle=20;

rotate([0,0,63])
{
mudguard();
//%wheel();
//%mounting_bracket();
//#gearing();
cover();
internal_guard();
}

module internal_guard() {
    inner_wheel_extra = -0.8;
    
    difference() {
        rotate([0,0,37])
        translate([0,0,0+nothing])
        intersection() {
            cylinder(sheild_height+12, r=mudguard_inner_radus-5, false);
            rotate([90,0,0])
            {
                translate([40,-wheel_width/2+5,-100])
                cube([mudguard_outer_radus*2,wheel_width,mudguard_outer_radus*2],false);
            }
        }
        cylinder(50, d=wheel_gear_diameter+8, false);
        translate([0,pinion_to_hub_centre,0])
        cylinder(50, d=mount_block_diameter, false);
        translate([0,0,-0.75])
        resize([mudguard_inner_radus*2+inner_wheel_extra, mudguard_inner_radus*2+inner_wheel_extra, wheel_width+nothing])
        wheel();
        translate([32,47,0])rotate([0,0,-57])cube([37,10,50],true);
    }
    difference() {
        rotate([0,0,10])
        translate([0,0,0+nothing])
        intersection() {
            cylinder(sheild_height+12, r=mudguard_inner_radus-5, false);
            rotate([90,0,0])
            {
                translate([40,-wheel_width/2+5,0])
                cube([mudguard_outer_radus*2,wheel_width,mudguard_outer_radus],false);
            }
        }
        cylinder(50, d=wheel_gear_diameter+8, false);
        translate([0,pinion_to_hub_centre,0])
        cylinder(50, d=mount_block_diameter, false);
        translate([0,0,-0.75])
        resize([mudguard_inner_radus*2+inner_wheel_extra, mudguard_inner_radus*2+inner_wheel_extra, wheel_width+nothing])
        wheel();
    }
    difference() {
        translate([55,-58,0])
        cylinder(50,d=50);
        translate([55+21,-58+3,0])
        rotate([0,0,10])
        cube([50,50,100], true);
        translate([0,0,-nothing])
        cylinder(100, d=wheel_gear_diameter+8, false);
        translate([0,0,-0.75])
        resize([mudguard_inner_radus*2+inner_wheel_extra, mudguard_inner_radus*2+inner_wheel_extra, wheel_width+nothing])
        wheel();
    }
}

module cover() {
    difference() {
        translate([0,pinion_to_hub_centre,0])
        {
            difference() {
                intersection() {
                    translate([0,-pinion_to_hub_centre,0])
                    cylinder(sheild_height+12, r=mudguard_inner_radus-5, false);

                    union() {
                        cylinder(sheild_height, d=mount_block_diameter, false);
                        translate([-4,14,0])
                        cylinder(sheild_height, d=mount_block_diameter, false);
                    }
                }
                translate([0,0,-nothing])
                cylinder(pinion_height, d=mount_block_diameter-cover_inner_to_outer*2, false);
                translate([-11,-5,-nothing])
                cylinder(pinion_height, d=mount_block_diameter-cover_inner_to_outer*2, false);
                translate([11,-5,-nothing])
                cylinder(pinion_height, d=mount_block_diameter-cover_inner_to_outer*2, false);
                translate([0,15,-nothing])
                cylinder(pinion_height, d=15, false);
            }
        }
        mounting_holes();
        cube([100,130,sheild_height*2+1], true);
    }
}

module gearing() {
    cylinder(pinion_height, d=wheel_gear_diameter, false);
    translate([0,pinion_to_hub_centre,0])
    cylinder(pinion_height, d=pinion_diameter, false);
}

module mudguard() {
    rotate([0,0,20])
    intersection() {
        difference() {
            resize([mudguard_outer_radus*2, mudguard_outer_radus*2, wheel_width])
            wheel();

            resize([mudguard_inner_radus*2, mudguard_inner_radus*2, wheel_width+nothing])
            wheel();
            cylinder(100,mudguard_inner_radus+12,true);
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
    translate([0,pinion_to_hub_centre,-mount_block_thickness])
    cylinder(mount_block_thickness, mount_block_diameter/2, mount_block_diameter/2);
}

module mounting_holes() {
    translate([0,hub_to_mount_bolt_hole,-nothing])
    {
        translate([dist_btw_mount_bolts/2,0,0])
        m4_bolt(50);
        translate([-dist_btw_mount_bolts/2,0,0])
        m4_bolt(50);
        translate([dist_btw_mount_bolts/2,0,bolt_length-8])
        m8_bolt(50);
        translate([-dist_btw_mount_bolts/2,0,bolt_length-8])
        m8_bolt(50);
    }
}

module m4_bolt(length) {
    cylinder(length, m4_bolt_hole_radius);
}

module m8_bolt(length) {
    cylinder(length, m8_bolt_hole_radius);
}

module wheel() {
    translate([0,0,motor_mount_to_wheel_centre])
    intersection() {
        resize([wheel_outer_radus*2,wheel_outer_radus*2,100])sphere(wheel_outer_radus);
        cylinder(wheel_width, wheel_outer_radus, wheel_outer_radus, true);
    }
}
