$fs = .03;
$fa = 1;

scale([7,7,7])
union() {
    linear_extrude(.7)
    difference() {
        treasureBanner();
        treasure();
    }


    color("black")
    linear_extrude(.3)
    treasure();

    /*color("black")
    linear_extrude(.3)
    xMarks();
    */

    linear_extrude(.5)
    difference() {
        outerRing();
        treasure();
        //xMarks();
        ringHoles();
        mirror([1,0,0])
        ringHoles();
        bannerHoles();
    };

    linear_extrude(.7)
    difference() {
        xMarksBanner();
        //xMarks();
        bannerHoles();
    }

    linear_extrude(1)
    bigX();

    linear_extrude(.5)
    difference() {
        ringHolder();
        ringHolderHoles();
    }
}
module ringHolder() {
    difference() {
        translate([0,6.3,0])
        circle(1.5);
        
        translate([-2,3.6])
        square([4,2]);

        translate([0,6.3,0])
        circle(1);
    }
}


module outerRing() {
    //outer ring
    difference(){
    circle(d=10);
    circle(d=8);
    };
}


module ringHoles() {
    for (i = [-1:1])
    rotate([0,0,(i*18)-5])
    translate([-4.5,0,0])
    circle(.2);
}

module bannerHoles() {
    for (i = [-1:2:1])
    rotate([0,0,(i*42)])
    translate([0,-4.3,0])
    circle(.1);
}

module ringHolderHoles() {
    translate([0,6.3])
    rotate([0,0,80])
    for (i = [0:1:4])
    rotate([0,0,(i*50)])
    translate([0,-1.25,0])
    circle(.1);
}

module treasureBanner() {
    //Treasure banner
    minkowski() {
        rotate([0,0,30])
        difference(){
            circle(d=11.5-.5);
            circle(d=7.4+.5);

            translate([-6,-6,0])
            square([12,12/2]);

            rotate([0,0,120])
            translate([0,0,0])
            square([12/2,12/2]);
        }
        circle(d=.5);
    }
}

module treasure() {
    treasure = "TREASURE";
    treasureHeight = 1.3;
    rotate([0,0,50])
    translate([0,2.7,0])
    for (letter = [0:len(treasure)]) {
        rotate([0,0,letter*-8.3])
        translate([(treasureHeight-.5)*letter,2,0])
        rotate([0,0,letter*-6.6])
        text(treasure[letter],treasureHeight,"Impact:style=Regular",halign="center",valign="center");
    }
}

module xMarksBanner() {
    //X marks the spot 
    minkowski() {
        rotate([0,0,135])
        difference(){
            circle(d=10-.4);
            circle(d=7+.5);

            translate([-6,-6,0])
            square([12,12/2]);
                
            translate([0,0,0])
            square([12/2,12/2]);
        }
        circle(d=.2);
    }
}

module xMarks() {
    treasure = "X MARKS THE SPOT";
    textHeight = .5;
    rotate([0,0,143.5])
//    translate([0,2.7,0])
    for (letter = [0:len(treasure)]) {
//        translate([(textHeight-.1)*letter])
        rotate([0,0,letter*4.9])
        translate([0,4.3,0])
        rotate([0,0,180])
//        rotate([0,0,letter*-6.6])
        scale([.8,1.4])
        text(treasure[letter],textHeight,"Impact:style=Regular",halign="center",valign="center");
    }
}

module bigX() {
    //X
    X_side();
    mirror([1,0,0])
    X_side();
}

module X_side() {
    polygon( points=[[-3,2.7],[-1.2,2.7],
        [4.1,-2.3],[1.5,-2.3]]
    );
}