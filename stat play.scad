//$fa=5;
$fn=200;

difference(){
cylinder(40,d2=0,d1=12);

linear_extrude(40, twist=600)
union(){
translate([1,1])
square([3,3]);

translate([-4,-4])
square([3,3]);

translate([1,-4])
square([3,3]);

translate([-4,1])
square([3,3]);

//star();
}
}


module star() {
    translate([0,1.5,0])
    polygon(points=[[4,0],[-4,0],[3,-6],[0,3],[-3,-6]]);
}

