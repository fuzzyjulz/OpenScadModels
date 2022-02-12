include <Bolts.scad>
$fa=3; //fragment angle (default=12)
$fs=1; //Fragment size (default=2)

plate_d=8;
pinion_left_centre = 69.5;
pinion_hole_d = 25;
pinion_hole_r = pinion_hole_d/2;
pinion_slide_l = 5;
motor_slide_l = 7;
motor_hole_d = 38;
motor_hole_r = motor_hole_d/2;

intersection() {
    difference() {
        plate();
        top_holes();
        bottom_holes();
    };
    cutout();
};

module plate() {
    translate([-107,-27,0]) //center of axle hole
    cube([200,100,plate_d]);
}

module top_holes() {
    //axle hole
    cylinder(h=plate_d, d=22);
    
    //axle mount holes
    for(r = [0:120:240]) {
        rotate([0,0,r])
        translate([16.8,0,0])
        union () {
            //bolt hole
            cylinder(h=plate_d, d=5);
            
            bolt_hole_d=4;
            //bolt head hole
            translate([0,0,plate_d-bolt_hole_d]) //center of axle hole
            cylinder(h=bolt_hole_d, d=10);
        }
    }

    mudguard_mount_holes();

    translate([-pinion_left_centre,0,0])
    motor_mount_top_holes();
    
    //belt cover holes
    for(r = [90:180:270]) {
        translate([-85,0,0])
        rotate([0,0,r])
        translate([14.5,0,0])
        cylinder(h=plate_d, d=3);
    }
}

module motor_mount_top_holes() {
    //motor slide hole left
    translate([(motor_slide_l-pinion_slide_l)/2,0,0])
    roundedslot(pinion_slide_l, plate_d, 25);
    
    for(r = [0:90:270]) {
        rotate([0,0,r])
        translate([motor_hole_r,0,0])
        rotate([0,0,-r])
        {
            motor_mount_hole_d = 4;
            
            //motor slide hole left
            roundedslot(motor_slide_l, plate_d, 4);

            rebate_dp = 2.5;
            translate([0,0,plate_d-rebate_dp]) {
                roundedslot(motor_slide_l, rebate_dp, 8);
            }
        }
    }
}

module roundedslot(l, h, d) {
    //motor slide rebate left
    cylinder(h=h, d=d);

    //motor slide rebate right
    translate([l,0,0])
    cylinder(h=h, d=d);
    
    //Cube between the rebates
    translate([0,-(d/2),0])
    cube([l,d,h]);
}

module mudguard_mount_holes() {
    //Mudguard mount holes
    for(r = [-50:50:50]) {
        rotate([0,0,-r])
        translate([0,70,0])

        //bolt hole
        cylinder(h=plate_d, d=4);
    }

    //More mudguard mount holes
    for(r = [-20:20:20]) {
        rotate([0,0,-r])
        translate([0,70,0])

        //bolt hole
        cylinder(h=plate_d, d=4);
    }
}

module bottom_holes() {
    //Axle inner
    cylinder(h=2, d=26);
    
    translate([-pinion_left_centre,0,0])
    translate([(motor_slide_l-pinion_slide_l)/2,0,0])
    roundedslot(pinion_slide_l, 2.5, 24.4*2);

}

module cutout() {
    //Axle section
    intersection() {
        cylinder(h=plate_d, r=70+5);
        translate([-30,65,0])
            cylinder(h=plate_d, r=70+5+18);
    };

    //Motor mount section
    translate([-pinion_left_centre,0,0])
    cylinder(h=plate_d, r=27);

    //Motor mount to axle join
    intersection() {
        translate([-pinion_left_centre+22,3,0])
        cylinder(h=plate_d, r=27+20);
        
        translate([-107,-27+20,0]) //center of axle hole
        cube([200,100,plate_d]);
    }

    translate([-107+40,-27,0]) //center of axle hole
    cube([40,10,plate_d]);
}