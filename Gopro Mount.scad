$fn=150;
structureHeight=50;


pipegroup();


difference() {
    baseplate();
    pipegroup();
    mountingHole();
    holdingScrews();
}

module mountingHole() {
    cylinder(1000,d=6);
}

module baseplate() {
    centralStructure();
    pipeholders();
}

module centralStructure() {
    difference() {
        translate([0,0,100-structureHeight])
        linear_extrude(structureHeight, scale= .6)
        circle(d=80);

        translate([0,0,100-structureHeight-.1])
        linear_extrude(15 + .1, scale= .6)
        circle(d=65);
    }
}

module pipeholders() {
    intersection(){
        translate([0,0,100-structureHeight])
            cylinder(structureHeight, d=200);

        for (i = [1:3])
            rotate([0,-30,i*120])
            translate([60,0,-40])
            scale(1.3)
            pipe(100);
    }
}

module holdingScrews() {
    for (i = [1:3])
        rotate([0,-30,i*120])
        translate([60,0,-40+70])
        rotate([0,90,0])
        cylinder(1000,d=6);
}

module pipegroup() {
    for (i = [1:3])
        rotate([0,-30,i*120])
        translate([60,0,-40])
        pipe(100);
}

module pipe(len){
    cylinder(len,d=33.5+.5);
}