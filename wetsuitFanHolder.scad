$fn = 50;

fanPlatform = 120;
platformHeight = 4;
ScrewHolesDist = 105;
outerIntake = 111; //add one for a bit more space to get it on
height = 30;
screwHoles = 4.5;

screwPosition = (ScrewHolesDist)/2;


linear_extrude(platformHeight)
    difference() {
        roundedSquare(fanPlatform, 5);
        circle(d=outerIntake);
        
        for( x = [-1, 1])
        for( y = [-1, 1])
        translate([x*screwPosition,y*screwPosition,0])
            circle(d=screwHoles);
    };

module roundedSquare(size, diameter) {
    minkowski(){    
        square(size-diameter, center = true);
        circle(d=diameter);
    }
}

linear_extrude(height)
    difference() {
        circle(d=outerIntake+platformHeight*2);
        circle(d=outerIntake);
    };
