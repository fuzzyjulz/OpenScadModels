

stove_width=300;
stove_length=400;

intake_area=(stove_width/3)^2;
fullWidth_intake_gap=35;//intake_area/stove_width; = 33.33


topPlate();

color([.6,.6,.6])
innerBaffles();


color([.1,.8,.1])
translate([stove_width/2,+36,0])
fuelBasket();

color([.1,.1,.6])
flu();

color([.1,.1,.8],.3)
outerBox();

module fuelBasket() {
    fluHoleHeight = stove_width/3;

    //bottom plate
    translate([0,-11,+5])
    difference() {
        triangle_panel_3mm(fluHoleHeight+20);
        translate([0,6.7,-1])
        linear_extrude(5)
        triangle(fluHoleHeight+7.3);
    }
    
    //long side of triangle top section
    translate([-fluHoleHeight,fluHoleHeight+3,0])
    rotate([90,0,0])
    panel_3mm([fluHoleHeight*2, fullWidth_intake_gap]);

    //left and right sides of top section
    translate([-fluHoleHeight,fluHoleHeight,0])
    rotate([90,0,-45])
    panel_3mm([70.7*2, fullWidth_intake_gap]);

    rotate([90,0,45])
    panel_3mm([70.7*2, fullWidth_intake_gap]);


    //bottom plate
    translate([0,0,-fullWidth_intake_gap+3])
    triangle_panel_3mm(fluHoleHeight);


    //Mesh section
    //long side of triangle
    translate([-fluHoleHeight,fluHoleHeight+0.5,-fullWidth_intake_gap+3])
    rotate([90,0,0])
    panel_0_5mm_mesh([fluHoleHeight*2, fullWidth_intake_gap]);

    //left and right sides
    translate([-fluHoleHeight,fluHoleHeight,-fullWidth_intake_gap+3])
    rotate([90,0,-45])
    panel_0_5mm_mesh([70.7*2, fullWidth_intake_gap]);

    translate([0,0,-fullWidth_intake_gap+3])
    rotate([90,0,45])
    panel_0_5mm_mesh([70.7*2, fullWidth_intake_gap]);
}
module flu() {
    fluHoleHeight = (stove_width/3)-3.5;
    fluHeight = 700;

    translate([stove_width,0,-fullWidth_intake_gap])
    rotate([0,0,45])
    union() {
        translate([-fluHoleHeight,fluHoleHeight+0.5,0])
        rotate([90,0,0])
        panel_0_5mm([fluHoleHeight*2, fluHeight]);

        //left and right sides of top section
        translate([-fluHoleHeight,fluHoleHeight,0])
        rotate([90,0,-45])
        panel_0_5mm([(68.25*2), fluHeight]);

        translate([0,0,0])
        rotate([90,0,45])
        panel_0_5mm([68.25*2, fluHeight]);
    }
}


module intake_hole() {
    intakeHoleSize = stove_width/3;
    
    translate([stove_width/2,+30,-.5])
    linear_extrude(6)
    triangle(intakeHoleSize+10);
    
    
    echo(str("Intake: ",intakeHoleSize * intakeHoleSize,"mm^2"));
}


module topPlate(){
    difference(){
        panel_5mm([stove_width, stove_length]);

        fluCutout_far();
        intake_hole();
    }
}

module innerBaffles() {
translate([0,0,-fullWidth_intake_gap])
    difference(){

        panel_3mm([stove_width, stove_length-fullWidth_intake_gap]);
        fluCutout();
    }

    translate([0,0,-(fullWidth_intake_gap*2+3)])
    panel_3mm([stove_width, stove_length]);

    translate([0,stove_width/2-8.5,-fullWidth_intake_gap+3])
    rotate([90,0,-45])
    panel_3mm([2*stove_width/3, fullWidth_intake_gap-3]);

    translate([stove_width+3,stove_width/2-10.8,-fullWidth_intake_gap+3])
    rotate([90,0,45+180])
    panel_3mm([2*stove_width/3, fullWidth_intake_gap-3]);
    
    //small inner baffle for center
    translate([(stove_width/3*2)-50,stove_length-fullWidth_intake_gap,0])
    rotate([-90,0,0])
    panel_3mm([50, fullWidth_intake_gap-3]);
}

module outerBox(){
    //Ends
    translate([0,-3,0])
    rotate([-90,0,0])
    panel_3mm([stove_width, fullWidth_intake_gap*2+3]);
    
    translate([0,stove_length,0])
    rotate([-90,0,0])
    panel_3mm([stove_width, fullWidth_intake_gap*2]);

    //Sides
    rotate([-90,0,90])
    panel_3mm([stove_length, fullWidth_intake_gap*2]);

    translate([stove_width+3,0,0])
    rotate([-90,0,90])
    panel_3mm([stove_length, fullWidth_intake_gap*2]);
}


module fluCutout() {
    fluCutout_near();
    fluCutout_far();
}

module fluCutout_near() {
    rotate([0,0,45])
    translate([0,-stove_width/3,-.5])
    cube([stove_width/3,2*stove_width/3,6]);
}

module fluCutout_far() {
    fluHoleHeight = stove_width/3;
    
    translate([stove_width,0,-0.5])
    rotate([0,0,45])
    linear_extrude(6)
    triangle(fluHoleHeight);
    
    echo(str("Flu size ",(fluHoleHeight^2)));
}

module triangle(height) {
    longEdge = 2*height;

    polygon([[0,0],[-longEdge/2,height],[longEdge/2,height],[0,0]]);
}

module panel_5mm(dims) {
    cube([dims[0],dims[1], 5]);
    echo(str("Part 5mm sheet ", dims[0], "x", dims[1]));
}

module panel_3mm(dims) {
    cube([dims[0],dims[1], 3]);
    echo(str("Part 3mm sheet ", dims[0], "x", dims[1]));
}

module panel_0_5mm(dims) {
    cube([dims[0],dims[1], 0.5]);
    echo(str("Part 0.5mm sheet ", dims[0], "x", dims[1]));
}

module panel_0_5mm_mesh(dims) {
    wireThickness = 0.4;
    seperation = 5;
    
    for(x = [0 : seperation : dims[0]]) {
        translate([x,0,0])
        cube([wireThickness,dims[1], wireThickness]);
    }
    for(y = [0 : seperation : dims[1]]) {
        translate([0,y,0])
        cube([dims[0],wireThickness, wireThickness]);
    }
    echo(str("Part 0.5mm sheet ", dims[0], "x", dims[1]));
}

module triangle_panel_3mm(height) {
    linear_extrude(3)
    triangle(height);
    echo(str("triangle panel 3mm sheet height=", height));
}
