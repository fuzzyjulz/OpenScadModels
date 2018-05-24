$fa=3;

nothing = 0.01;
m4_bolt_hole_radius = 2*1.3;
m8_bolt_hole_radius = 4*1.3;

wheel_outer_radus = 90;
wheel_inner_max_radius = 65;
wheel_width = 51.5;
dist_btw_mount_bolts = 29.5;
mount_block_diameter = 53;
hub_to_mount_bolt_hole = 83;
motor_mount_to_wheel_centre = 48.5;
wheel_gear_diameter = 108;
pinion_diameter = 30;
pinion_height = 18+2;
sheild_height = 22;
pinion_to_hub_centre = 121-108/2;
cover_inner_to_outer = 11-1;
bolt_length = 20;
mount_block_thickness = 6;

mudguard_thickness = 6;
mudguard_inner_radus = wheel_outer_radus + 15;
mudguard_outer_radus = mudguard_inner_radus + mudguard_thickness;

outer_bevel_height = motor_mount_to_wheel_centre;

difference() {
    rotate([0,0,63])
    union() {
        //%wheel();
        //%mounting_bracket();
        //#gearing();
        mudguard();
        cover();
        internal_guard();
    }
    
    outer_bevel();
}

module internal_guard() {
    inner_wheel_extra = -10;
    internal_guard_height = 30;
    difference() {
        union() {
            difference() {
                rotate([0,0,22.5])
                translate([0,0,0+nothing])
                intersection() {
                    cylinder(outer_bevel_height, r=mudguard_outer_radus, false);
                    rotate([90,0,0])
                    {
                        translate([40,-wheel_width/2+5,-110])
                        cube([mudguard_outer_radus*2,outer_bevel_height*2,mudguard_outer_radus*2],false);
                    }
                }
                cylinder(internal_guard_height, d=wheel_gear_diameter+8, false);
                translate([0,pinion_to_hub_centre,0])
                cylinder(internal_guard_height, d=mount_block_diameter, false);
                translate([0,0,-3.75])
                resize([mudguard_inner_radus*2+inner_wheel_extra, mudguard_inner_radus*2+inner_wheel_extra, wheel_width+nothing])
                wheel();
                translate([49,21,0])rotate([0,0,123])translate([0,-5,-nothing])cube([50,10,50],false);
            }
            difference() {
                rotate([0,0,10])
                translate([0,0,0+nothing])
                intersection() {
                    cylinder(outer_bevel_height, r=mudguard_outer_radus, false);
                    rotate([90,0,0])
                    {
                        translate([40,-wheel_width/2+5,0])
                        cube([mudguard_outer_radus*2,outer_bevel_height*2,mudguard_outer_radus],false);
                    }
                }
                cylinder(internal_guard_height, d=wheel_gear_diameter+8, false);
                translate([0,pinion_to_hub_centre,0])
                cylinder(internal_guard_height, d=mount_block_diameter, false);
                translate([0,0,-3.75])
                resize([mudguard_inner_radus*2+inner_wheel_extra, mudguard_inner_radus*2+inner_wheel_extra, wheel_width+nothing])
                wheel();
            }
            difference() {
                translate([65,-60,nothing])
                cylinder(outer_bevel_height-nothing*2,d=63);
                translate([55+21,-58+3,0])
                rotate([0,0,10])
                cube([50,50,100], true);
                translate([0,0,-nothing])
                cylinder(internal_guard_height, d=wheel_gear_diameter+8, false);
                translate([0,0,-3.75])
                resize([mudguard_inner_radus*2+inner_wheel_extra, mudguard_inner_radus*2+inner_wheel_extra, wheel_width+nothing])
                wheel();
            }
        }
        resize([mudguard_inner_radus*2, mudguard_inner_radus*2, wheel_width+nothing])
        wheel();
    }
}

module outer_bevel() {
    secondary_layer = 15;
    
    difference() {
            cylinder(h=outer_bevel_height, r=mudguard_outer_radus+51, centre=false);
            translate([0,0,secondary_layer])
            cylinder(h=outer_bevel_height-secondary_layer, r1=mudguard_inner_radus,r2=mudguard_outer_radus, centre=false);
            cylinder(h=secondary_layer, r1=mudguard_inner_radus-5,r2=mudguard_inner_radus, centre=false);
    }
}

module cover() {
    difference() {
        translate([0,pinion_to_hub_centre,0])
        {
            difference() {
                union() {
                    cylinder(sheild_height, d=mount_block_diameter, false);
                    translate([25,24,+nothing])
                    cylinder(sheild_height, d=mount_block_diameter, false);
                    translate([-3,12,0+nothing])
                    cylinder(sheild_height, d=55, false);
                }
                translate([0,0,-nothing])
                cylinder(pinion_height, d=mount_block_diameter-cover_inner_to_outer*2, false);
                translate([-17,-5,-nothing])
                cylinder(pinion_height, d=20, false);
                translate([17,-5,-nothing])
                cylinder(pinion_height, d=20, false);
                translate([-10,0,-nothing])
                cylinder(pinion_height, d=20, false);
                translate([10,0,-nothing])
                cylinder(pinion_height, d=20, false);
                translate([0,18,-nothing])
                cylinder(pinion_height, d=10, false);
                translate([0,14,-nothing])
                cylinder(pinion_height, d=12, false);
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
        translate([25,0,motor_mount_to_wheel_centre])
        intersection () {
            mudguard_intersecton = mudguard_outer_radus*2+20;
            rotate([90,0,0])
            {
                translate([0,0,-mudguard_outer_radus])
                cylinder(mudguard_intersecton, wheel_width/2, wheel_width/2);
                translate([0,-wheel_width/2,-mudguard_outer_radus])
                cube([mudguard_intersecton,wheel_width,mudguard_intersecton],false);
            }
            rotate([90,0,-20])
            union() {
                translate([0,0,-mudguard_outer_radus])
                cylinder(mudguard_intersecton, wheel_width/2, wheel_width/2);
                translate([0,-wheel_width/2,-mudguard_outer_radus])
                cube([mudguard_intersecton,wheel_width,mudguard_intersecton],false);
            }
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
        mounting_bolt_hole();
        translate([-dist_btw_mount_bolts/2,0,0])
        mounting_bolt_hole();
    }
}

module mounting_bolt_hole() {
    m4_bolt(50);
    translate([0,0,bolt_length-5])
    m8_bolt(50);
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
