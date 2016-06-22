// Fan Nozzle
// Shapes the air flow from the fan to a blow across the entire width of the print bed

module fanNozzle() {
    cylinderRadius = 44;
    cylinderHeight = 10;
    transitionExitOverlap = 5; // must be greater than 0
    transitionHeight = 40;
    // define the area that the air flows through (added thickness wraps around it)
    exitLength = 145;
    exitWidth = 20;
    exitHeight = 15;
    nozzleThickness = 1;
    // base dimensions
    baseSquareSize = 91;
    baseSquareThickness = 2;
    screwHoleRadius = 2;
    screwHoleDistanceFromCorner = 2; // measured from the edge of the screw hole
    $fn=64;
    
    // make main nozzle
    module nozzle(offsetting=0) {
        hull(){
            // bottom cylinder
            linear_extrude(height=cylinderHeight)
                offset(r=offsetting)
                circle(d=cylinderRadius*2, center=true);
            // top rectangle
            translate([0,0,cylinderHeight+transitionHeight+1])
                linear_extrude(height=transitionExitOverlap)
                offset(r=offsetting)
                square([exitLength,exitWidth], center=true);
        }
        // rectangle extension
        translate([0,0,cylinderHeight+transitionHeight+transitionExitOverlap])
            linear_extrude(height=exitHeight)
            offset(r=offsetting)
            square([exitLength,exitWidth], center=true); 
    }

    // make nozzle hollow
    difference() {
        nozzle(offsetting=nozzleThickness);
        nozzle();
        // clean top hole
        translate([0,0,cylinderHeight+transitionHeight+transitionExitOverlap+exitHeight])
            cube([exitLength,exitWidth,1], center=true);
        // clean bottom hole
        cylinder(r=cylinderRadius,h=1,center=true);
    }

    // make base square
    module hole() {
        translate([0,0,baseSquareThickness/2]) // move it up to the base square
            cylinder(r=screwHoleRadius,h=baseSquareThickness+1,center=true);
    }
    
    squareHalf = baseSquareSize/2;
    cornerDistance = screwHoleRadius + screwHoleDistanceFromCorner;
    difference(){
        linear_extrude(height=baseSquareThickness) 
            square(size=baseSquareSize, center=true);
        // cut main fan hole in the square base
        translate([0,0,baseSquareThickness/2])
            cylinder(r=cylinderRadius,h=baseSquareThickness+1,center=true);
        // cut out the corner screw holes
        translate([squareHalf-cornerDistance,squareHalf-cornerDistance,0]) hole();
        translate([-squareHalf+cornerDistance,squareHalf-cornerDistance,0]) hole();
        translate([-squareHalf+cornerDistance,-squareHalf+cornerDistance,0]) hole();
        translate([squareHalf-cornerDistance,-squareHalf+cornerDistance,0]) hole();
    }
}
fanNozzle();