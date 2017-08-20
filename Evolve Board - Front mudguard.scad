include <Bolts.scad>
include <ComplexShapes.scad>
$fa=3;

wheel_outer_radus = 90;
wheel_inner_max_radius = 65;
wheel_width = 51.5;

motor_mount_to_wheel_centre = 48.5;

axle_angle = 15;
axle_at_wheel = [19, 17.5];
axle_at_60 = [21.5,21.5];

mudguard_thickness = 6;
mudguard_inner_radus = wheel_outer_radus + 15;
mudguard_outer_radus = mudguard_inner_radus + mudguard_thickness;

outer_bevel_height = motor_mount_to_wheel_centre;

attachment_piece_length = 74;
attachment_piece_width = 30;
attachment_piece_gap = 1;

//%wheel();
//%axle();
//outer_guard_piece();
//axle_attachment_piece_1();
axle_attachment_piece_2();
//#axle_attach_bolts_and_holes();

module axle_attach_bolts_and_holes() {
    bolt_height = 8.5;
    distance = 24;
    
    rotate([90,0,-15])
    translate([distance,bolt_height,-5])
    bolt_holes();

    rotate([90,0,-15-90])
    translate([-distance,bolt_height,-2])
    bolt_holes();
}

module bolt_holes() {
    m4_bolt(20);
    translate([0,0,20-nothing])
    m8_bolt(10);
    rotate([0,0,90])
    m4_nut(5);
    translate([0,0,-5+nothing])
    rotate([0,0,90])
    cube([100,10,10], true);
}

module axle_attachment_piece_1() {
    difference() {
        intersection() {
            axle_attachment();
            union() {
                translate([-40,-29,-10])
                rotate([0,0,-15])
                cube([attachment_piece_length,attachment_piece_width,50]);

                translate([-17,-29,-10])
                rotate([0,0,-15+90])
                cube([attachment_piece_length,attachment_piece_width,50]);
            }
        }
        axle_attach_bolts_and_holes();
    }
}

module axle_attachment_piece_2() {
    difference() {
        axle_attachment();
        union() {
            translate([-40+attachment_piece_gap,-29,-10])
            rotate([0,0,-15])
            cube([attachment_piece_length,attachment_piece_width+attachment_piece_gap,50]);

            translate([-17+attachment_piece_gap+attachment_piece_gap/2,-29+attachment_piece_gap,-10])
            rotate([0,0,-15+90])
            cube([attachment_piece_length,attachment_piece_width+attachment_piece_gap,50]);
        }
        axle_attach_bolts_and_holes();
    }
}

module axle_attachment() {
    intersection() {
        difference() {
            union() {
                translate([0,0,-1])
                cylinder(h=10, r=70);
                cylinder(h=18, r=49.7, centre=false);
            }
            mounting_bolts();
            axle();
        }
        union() {
            hull() {
            translate([0,0,-26])
            cylinder(h=52, r=25, centre=false);

            translate([25,-5,-26])
            cylinder(h=52, r=25, centre=false);

            translate([5,25,-26])
            cylinder(h=52, r=25, centre=false);
            }

            translate([0,5,0])
            intersection() {
                mudguard_intersecton = mudguard_outer_radus*2+40;
                
                rotate([90,0,50])
                translate([0,-wheel_width/2,-mudguard_intersecton/2])
                cube([mudguard_intersecton,wheel_width,mudguard_intersecton],false);

                rotate([90,0,10])
                translate([0,-wheel_width/2,-mudguard_intersecton/2])
                cube([mudguard_intersecton,wheel_width,mudguard_intersecton],false);
            }
        }
    }
}

module outer_guard_piece() {
    mudguard();
    difference() {
        inner_guard();
        mounting_bolts();
    }
}

module mounting_bolts() {
    for(r = [0:-40:-100]) {
        rotate([0,0,r])
        translate([18,58,-6])
        union(){
            m4_bolt(20);
            translate([0,0,20-nothing])
            m8_bolt(4+nothing*2);
            translate([0,0,3-nothing])
            m4_nut(5);
        }
    }
}

module inner_guard() {
    intersection() {
        difference() {
            translate([0,0,nothing])
            cylinder(h=outer_bevel_height-nothing*3, r=mudguard_outer_radus+50, centre=false);
            outer_bevel();
            mudguard_inner();
            translate([0,0,18])
            cylinder(h=outer_bevel_height, r=mudguard_inner_radus-15, centre=false);
            cylinder(h=outer_bevel_height, r=50, centre=false);
        }
        translate([15,15,motor_mount_to_wheel_centre])
        resize([0,0,80])
        mudguard_cutout();
    }
}

module axle()
{
    translate([0,0,motor_mount_to_wheel_centre-wheel_width/2-60/2])
    rotate([-90,0,-axle_angle])
    cubeoid(axle_at_wheel,axle_at_60,60);
}



module mudguard() {
    intersection() {
        difference() {
            resize([mudguard_outer_radus*2, mudguard_outer_radus*2, wheel_width])
            wheel();

            mudguard_inner();
            cylinder(100,mudguard_inner_radus+12,true);
        }
        translate([15,15,motor_mount_to_wheel_centre])
        mudguard_cutout();
    }
}

module mudguard_inner() {
    resize([mudguard_inner_radus*2, mudguard_inner_radus*2, wheel_width+nothing])
    wheel();
}

module mudguard_cutout() {
        intersection () {
        mudguard_intersecton = mudguard_outer_radus*2+40;
        rotate([90,0,50])
        {
            translate([0,0,-mudguard_intersecton/2])
            cylinder(mudguard_intersecton, wheel_width/2, wheel_width/2);
            translate([0,-wheel_width/2,-mudguard_intersecton/2])
            cube([mudguard_intersecton,wheel_width,mudguard_intersecton],false);
        }
        rotate([90,0,10])
        union() {
            translate([0,0,-mudguard_intersecton/2])
            cylinder(mudguard_intersecton, wheel_width/2, wheel_width/2);
            translate([0,-wheel_width/2,-mudguard_intersecton/2])
            cube([mudguard_intersecton,wheel_width,mudguard_intersecton],false);
        }
    }
}

module outer_bevel() {
    secondary_layer = 30;
    secondary_layer_radius = mudguard_inner_radus+4;
    
    difference() {
            cylinder(h=outer_bevel_height, r=mudguard_outer_radus+51, centre=false);
            translate([0,0,secondary_layer])
            cylinder(h=outer_bevel_height-secondary_layer, r1=secondary_layer_radius,r2=mudguard_outer_radus+.3, centre=false);
            cylinder(h=secondary_layer, r1=mudguard_inner_radus-7,r2=secondary_layer_radius, centre=false);
    }
}


module wheel() {
    translate([0,0,motor_mount_to_wheel_centre])
    intersection() {
        resize([wheel_outer_radus*2,wheel_outer_radus*2,100])sphere(wheel_outer_radus);
        cylinder(wheel_width, wheel_outer_radus, wheel_outer_radus, true);
    }
}
