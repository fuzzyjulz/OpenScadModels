$fn = 200;

height = 20;

blendDim = 2;

pump_d = 98;
hose_d = 29;
hose_buffer = 1;
part_width = 3;
pushEntryDegrees = 120;


linear_extrude(height)
minkowski() {
pumpProfile();
circle(blendDim);
}

module pumpProfile() {
    rotate([0,0,90])
    pump_sleeve();
    translate([pump_d/2 + hose_d/2 + part_width + blendDim*2+ hose_buffer*2,0,0])
    hose_sleeve();

    translate([-(pump_d/2 + hose_d/2 + part_width + blendDim*2+ hose_buffer*2),0,0])
    rotate([0,180])
    hose_sleeve();
}

#translate([pump_d/2 + hose_d/2 + part_width + blendDim*2+ hose_buffer*2,0,0])
hose();
#pump();



module pump_sleeve() {
    arc(pump_d/2+blendDim, [pushEntryDegrees/2, 360-pushEntryDegrees/2], part_width, $fn);
}

module hose_sleeve() {
    arc(hose_d/2+blendDim + hose_buffer, [pushEntryDegrees/2, 360-pushEntryDegrees/2], part_width, $fn);
}

module pump() {
    circle (d=pump_d);
}

module hose() {
    circle (d=hose_d);
}




module sector(radius, angles, fn = 24) {
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius, $fn = fn);
        polygon(points);
    }
}

module arc(radius, angles, width = 1, fn = 24) {
    difference() {
        sector(radius + width, angles, fn);
        circle(radius);
        //sector(radius, angles, fn);
    }
} 