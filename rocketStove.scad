

stove_width=300;
stove_length=450;
oven_height=70;

intake_area=6500;//(stove_width/3)^2;
echo (str("Recomended intake area ",intake_area,"mm^2"));
fullWidth_intake_gap=25;//intake_area/stove_width; = 33.33
echo (str("ideal intake gap ",intake_area/stove_width,"mm"));
echo (str("actual intake gap ",fullWidth_intake_gap,"mm"));
echo (str("actual intake area through stove ",fullWidth_intake_gap*stove_width,"mm"));

outerside_height = fullWidth_intake_gap+oven_height;

color([.6,.6,.6])
difference () {
    innerBaffles();
    
    //Cutout for exhaust
    translate([stove_width/2-90/2,0,-fullWidth_intake_gap-5])
    cube([90,70,10]);
}
translate([stove_width,stove_length,0])
rotate([0,0,180])
topPlate();

//color([.1,.8,.1])
//translate([stove_width/2,+13.5,0])
//fuelBasket();

color([.1,.1,.6])
translate([stove_width,stove_length,0])
rotate([0,0,180])
flu();

translate([stove_width,stove_length,0])
rotate([0,0,180])
largePan();

//pizzaStone();
ovenTray();

newFirebox = true;
if (newFirebox) {
    translate([stove_width/2,36,0])
    rotate([0,-90,270])
    fireBox_v2();
} else {
    translate([stove_width/2,-44,-fullWidth_intake_gap])
    rotate([0,-90,270])
    fireBox();
}

color([.1,.1,.8],.3)
outerBox();

module ovenTray() {
    translate([10,75,-fullWidth_intake_gap-oven_height])
    cube([stove_width-20,375,10]);
}


module fireBox_v2() {
    fireboxHeight = 185;
    fireboxWidth = 90;
    fireboxDepth = 70;
    
    
    translate([-fireboxHeight-fullWidth_intake_gap-2,0,0])
    fireboxOuter_v2(fireboxHeight, fireboxWidth, fireboxDepth);

}


module fireBox() {
    fireboxHeight = 170;
    fireboxWidth = 80;
    
    
    translate([-fireboxHeight-fullWidth_intake_gap-2,0,0])
    fireboxOuter(fireboxHeight, fireboxWidth);

    for (i = [0:1:1])
    mirror([0,i,0]) {
        translate([-fullWidth_intake_gap-2,-fireboxWidth/2-2,fireboxWidth/2 +2])
        rotate([45+180,0,0])
        rotate([0,90,0])
        triangle_panel_2mm(fireboxWidth/2+18,"exhaustManifold");

        translate([0,-fireboxWidth/2-2,fireboxWidth/2 +2])
        rotate([45+180,0,0])
        rotate([0,90,0])
        triangle_panel_2mm(fireboxWidth/2+18,"exhaustManifold");
        
        translate([-fullWidth_intake_gap,-fireboxWidth/2-2,-fireboxWidth/2])
        rotate([45+90,0,0])
        panel_2mm([fullWidth_intake_gap,116], "Firebox fuel - exhaust manifold");
    }

    translate([0,-fireboxWidth/2-2,fireboxWidth/2+2])
    rotate([0,90,0])
    panel_2mm([fireboxWidth+2,fireboxWidth+4], "Firebox fuel - exhaust manifold top");

    translate([0,-fireboxWidth/2-2,-fireboxWidth/2])
    rotate([0,180,0])
    panel_2mm([fullWidth_intake_gap+2,fireboxWidth+4], "Firebox fuel - exhaust manifold back");
}

module fireboxOuter_v2(fireboxHeight, fireboxWidth,fireboxDepth) {
    feedLength = 100;
    fireboxFuelIntakeHeight = 50;
    
    echo (str("Firebox chimney area ",fireboxWidth*fireboxDepth,"mm^2"));
    echo (str("Firebox intake area ",fireboxFuelIntakeHeight*fireboxWidth,"mm^2"));

    rotate([i*90,0,0])
    translate([0,-fireboxWidth/2,fireboxDepth/2])
    panel_2mm([fireboxHeight, fireboxWidth], "Firebox side - Outer");

    for (i = [1,3,3]) {
        rotate([i*90,0,0])
        translate([0,-fireboxDepth/2,fireboxWidth/2])
        panel_2mm([fireboxHeight, fireboxDepth], "Firebox side - Outer");
    }

    #translate([70,0,-20])
    rotate([0,60,0]) {
        
        for (i = [1:2:4]) {
            rotate([i*90,0,0])
            translate([0,-fireboxFuelIntakeHeight/2,fireboxWidth/2])
            panel_2mm([feedLength, fireboxFuelIntakeHeight], "Firebox fuel - Feed Outer left/right");
        }

        translate([0,-fireboxWidth/2,-fireboxFuelIntakeHeight/2-2])
        panel_2mm([feedLength, fireboxWidth], "Firebox fuel - Feed Outer bottom");

        translate([33,-fireboxWidth/2,fireboxFuelIntakeHeight/2])
        panel_2mm([feedLength-33, fireboxWidth], "Firebox fuel - Feed Outer top");
    }
    
    //translate([fireboxHeight,-fireboxWidth/2,-fireboxWidth/2])
    //rotate([0,180,0])
    //panel_2mm([fireboxHeight-108,fireboxWidth], "Firebox fuel - Top back");
    
    translate([0,-fireboxWidth/2,-fireboxDepth/2])
    rotate([0,-90,0])
    panel_2mm([fireboxDepth, fireboxWidth], "Firebox side - bottom");

}

module fireboxOuter(fireboxHeight, fireboxWidth) {
    feedLength = 100;
    fireboxFuelIntakeHeight = 50;
    
    echo (str("Firebox chimney area ",fireboxWidth*fireboxWidth,"mm^2"));
    echo (str("Firebox intake area ",fireboxFuelIntakeHeight*fireboxWidth,"mm^2"));

    for (i = [0,1,3]) {
        rotate([i*90,0,0])
        translate([0,-fireboxWidth/2,fireboxWidth/2])
        panel_2mm([fireboxHeight, fireboxWidth], "Firebox side - Outer");
    }

    translate([70,0,-27])
    rotate([0,60,0]) {
        
        for (i = [1:2:4]) {
            rotate([i*90,0,0])
            translate([0,-fireboxFuelIntakeHeight/2,fireboxWidth/2])
            panel_2mm([feedLength, fireboxFuelIntakeHeight], "Firebox fuel - Feed Outer left/right");
        }

        translate([0,-fireboxWidth/2,-fireboxFuelIntakeHeight/2-2])
        panel_2mm([feedLength, fireboxWidth], "Firebox fuel - Feed Outer bottom");

        translate([33,-fireboxWidth/2,fireboxFuelIntakeHeight/2])
        panel_2mm([feedLength-33, fireboxWidth], "Firebox fuel - Feed Outer top");
    }
    
    translate([fireboxHeight,-fireboxWidth/2,-fireboxWidth/2])
    rotate([0,180,0])
    panel_2mm([fireboxHeight-108,fireboxWidth], "Firebox fuel - Top back");
    
    translate([0,-fireboxWidth/2,-fireboxWidth/2])
    rotate([0,-90,0])
    panel_2mm([fireboxWidth, fireboxWidth], "Firebox side - bottom");

}

module largePan() {
    panSize = 270;
    color([.9,.9,.8])
    translate([stove_width/2,stove_length - panSize/2])
    linear_extrude(8)
    circle(d=panSize);
}

module pizzaStone() {
    pizzaStone = 320;
    color([.9,.88,.8])
    translate([stove_width/2,stove_length/2,-(outerside_height)])
    difference() {
        linear_extrude(15)
        circle(d=pizzaStone);
        
        translate([290/2,-pizzaStone/2,-1])
        cube([40,pizzaStone,17]);

        rotate([0,0,180])
        translate([290/2,-pizzaStone/2,-1])
        cube([40,pizzaStone,17]);
    }
}

module fuelBasket() {
    fluHoleHeight = (stove_width/3)-10.5 -5.5;
    basket_sideLength = 119;
    panelWidth = 2;

    echo(str("Fuel Basket Intake: ",fluHoleHeight^2,"mm^2"));

    //bottom plate
    translate([0,-9.6,+5])
    difference() {
        triangle_panel_2mm(fluHoleHeight+16, "FuelBasket - Top retainer");
        translate([0,6.7,-1])
        linear_extrude(5)
        triangle(fluHoleHeight+4.9);
    }
    
    //long side of triangle top section
    translate([-fluHoleHeight,fluHoleHeight+panelWidth,0])
    rotate([90,0,0])
    panel_2mm([fluHoleHeight*2, fullWidth_intake_gap], "FuelBasket - Top, long side");

    //left and right sides of top section
    translate([-fluHoleHeight,fluHoleHeight,0])
    rotate([90,0,-45])
    panel_2mm([basket_sideLength, fullWidth_intake_gap], "FuelBasket - Top, short side");

    rotate([90,0,45])
    panel_2mm([basket_sideLength, fullWidth_intake_gap], "FuelBasket - Top, short side");


    //bottom plate
    translate([0,0,-fullWidth_intake_gap+panelWidth])
    triangle_panel_2mm(fluHoleHeight, "FuelBasket - Bottom Plate");


    //Mesh section
    //long side of triangle
    translate([-fluHoleHeight,fluHoleHeight+0.5,-fullWidth_intake_gap+panelWidth])
    rotate([90,0,0])
    panel_0_5mm_mesh([fluHoleHeight*2, fullWidth_intake_gap], "FuelBasket - Mesh, long side");

    //left and right sides
    translate([-fluHoleHeight,fluHoleHeight,-fullWidth_intake_gap+panelWidth])
    rotate([90,0,-45])
    panel_0_5mm_mesh([basket_sideLength, fullWidth_intake_gap], "FuelBasket - Mesh, short side");

    translate([0,0,-fullWidth_intake_gap+panelWidth])
    rotate([90,0,45])
    panel_0_5mm_mesh([basket_sideLength, fullWidth_intake_gap], "FuelBasket - Mesh, short side");
}

module flu() {
    fluHoleHeight = (stove_width/3)-10;
    flueSideWidth = 127.3;
    fluHeight = 700;

    translate([stove_width/2,10,-fullWidth_intake_gap])
    union() {
        translate([-fluHoleHeight,fluHoleHeight+0.5,fullWidth_intake_gap])
        rotate([90,0,0])
        panel_0_5mm([fluHoleHeight*2, fluHeight-fullWidth_intake_gap], "Flu Pipe - longside");

        //left and right sides of top section
        translate([-fluHoleHeight,fluHoleHeight,0])
        rotate([90,0,-45])
        panel_0_5mm([flueSideWidth, fluHeight], "Flu Pipe");

        translate([0,0,0])
        rotate([90,0,45])
        panel_0_5mm([flueSideWidth, fluHeight], "Flu Pipe");
    }
    
    echo(str("Flue outer area: ",fluHoleHeight^2,"mm^2"));
}


module intake_hole() {
    intakeHoleSize = (stove_width/3) -10;
    
    translate([stove_width/2,+10,-.5])
    linear_extrude(6)
    triangle(intakeHoleSize);
    
    
    echo(str("Intake: ",intakeHoleSize^2,"mm^2"));
}


module topPlate(){
    difference(){
        panel_5mm([stove_width, stove_length], "Top plate");

        intake_hole();
    }
}

module innerBaffles() {
    baffle_thickness = 2;
    
    translate([0,0,-(fullWidth_intake_gap+baffle_thickness)])
    panel_2mm([stove_width, stove_length], "Inner Baffle, lower Plate");

}

module outerBox(){
    //Ends
    translate([0,-3,0])
    rotate([-90,0,0])
    panel_3mm([stove_width, outerside_height], "Outer Box End");
    
    translate([0,stove_length,0])
    rotate([-90,0,0])
    panel_3mm([stove_width, fullWidth_intake_gap*2], "Outer Box End");

    //Sides
    rotate([-90,0,90])
    panel_3mm([stove_length, outerside_height], "Outer Box Side");

    translate([stove_width+3,0,0])
    rotate([-90,0,90])
    panel_3mm([stove_length, outerside_height], "Outer Box Side");

    //bottom
    translate([0,0,-(outerside_height+3)])
    panel_3mm([stove_width, stove_length], "Outer Box Bottom");
}


module fluCutout() {
    fluCutout_near();
    fluCutout_far();
}

module fluCutout_near() {
    fluHoleHeight = (stove_width/3)-10+2.5;

    translate([0,0,-0.5])
    rotate([0,0,-45])
    linear_extrude(6)
    triangle(fluHoleHeight);
}

module fluCutout_far() {
    fluHoleHeight = (stove_width/3)-10+2.5;
    
    translate([stove_width,0,-0.5])
    rotate([0,0,45])
    linear_extrude(6)
    triangle(fluHoleHeight);
    
    echo(str("Flu cutout size ",(fluHoleHeight^2)));
}

module triangle(height) {
    longEdge = 2*height;

    polygon([[0,0],[-longEdge/2,height],[longEdge/2,height],[0,0]]);
}

module panel_5mm(dims, name="") {
    cube([dims[0],dims[1], 5]);
    echo(str("Part 5mm sheet ", dims[0], "x", dims[1]," - ",name));
}

module panel_2mm(dims, name="") {
    cube([dims[0],dims[1], 2]);
    echo(str("Part 2mm sheet ", dims[0], "x", dims[1]," - ",name));
}

module panel_3mm(dims, name="") {
    cube([dims[0],dims[1], 3]);
    echo(str("Part 3mm sheet ", dims[0], "x", dims[1]," - ",name));
}

module panel_0_5mm(dims, name="") {
    cube([dims[0],dims[1], 0.5]);
    echo(str("Part 0.5mm sheet ", dims[0], "x", dims[1]," - ",name));
}

module panel_0_5mm_mesh(dims, name="") {
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
    echo(str("Part 0.5mm sheet ", dims[0], "x", dims[1]," - ",name));
}

module triangle_panel_3mm(height, name="") {
    linear_extrude(3)
    triangle(height);
    echo(str("triangle panel 3mm sheet height=", height," - ",name));
}

module triangle_panel_2mm(height, name="") {
    linear_extrude(2)
    triangle(height);
    echo(str("triangle panel 2mm sheet height=", height," - ",name));
}
