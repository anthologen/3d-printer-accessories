// Mount Lasso
// Holds the fan holder on the arm mount
// Teeth allow the position of fan's height and distance from printer to be adjusted

module mountLasso() {
    thickness = 3;
    rectHoleLength = 12;
    rectHoleHeight = 9;
    armLength = 21;
    armThickness = 3;
    teethLength = 1;
    teethHeight = 1;
    grooveLength = 2;
    componentWidth = 15;

    linear_extrude(height=componentWidth){
        // main rectangle hole
        square([rectHoleLength+(2*thickness),thickness]);
        translate([0,thickness]) square([thickness,rectHoleHeight]);
        translate([0,rectHoleHeight+thickness])
            square([rectHoleLength+(2*thickness),thickness]);
        translate([rectHoleLength+thickness,thickness])
            square([thickness,rectHoleHeight]);
        // add arm
        translate([(rectHoleLength/2)+(armThickness/2),-armLength])
            square([armThickness,armLength]);
        // add teeth to arm
        numArmTeeth = round(armLength/(grooveLength+teethLength));
        translate([(rectHoleLength/2)+(armThickness/2)-teethHeight,-armLength])
            for(idx=[0:numArmTeeth-1]) {
                translate([0,idx*(grooveLength+teethLength)]) {
                    square([(teethHeight*2)+armThickness, teethLength]);
                }
            }
    }
    // add teeth to the top of the rectangle hole
    numRectHoleTeeth = round(componentWidth/(grooveLength+teethLength));
    for(idx=[0:numRectHoleTeeth-1]) {
        translate([thickness,rectHoleHeight+thickness-teethHeight,idx*(grooveLength+teethLength)]) {
            cube([rectHoleLength, teethHeight, teethLength]);
        }
    }
}
mountLasso();