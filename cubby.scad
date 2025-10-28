
groundX = 2000;
groundY = 1000;
postW = 100;

#groundShape();


structure();

module structure() {
post(1500);
translate([groundX-postW, 0])
post(1500);
translate([0, groundY-postW])
post(1500);
translate([groundX-postW, groundY-postW])
post(1500);

}

module post(length) {
cube([100,100,length]);
}


module groundShape() {
    square([groundX,groundY]);
}