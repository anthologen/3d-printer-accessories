// Fan Holder
// Designed to hold a power supply fan / PC chasis fan and attach to the mount lasso

module fanHolder() {
    thickness = 2;
    rectLength = 92;
    rectHeight = 92;
    triangleTopLength = 10;
    triangleHeight = 20;
    armLength = 45;
    armSideThickness = 2;
    teethLength = 1;
    teethHeight = 1;
    grooveLength = 2;
    componentWidth = 15;

    linear_extrude(height=componentWidth){
        // main rectangle
        square([rectLength+(2*thickness),thickness]);
        translate([0,-rectHeight-thickness]) square([rectLength+(2*thickness),thickness]);
        translate([0,-rectHeight]) square([thickness,rectHeight]);
        translate([rectLength+thickness,-rectHeight]) square([thickness,rectHeight]);
        // triangle piece
        translate([(rectLength/2)-(triangleTopLength/2),thickness+triangleHeight])
            square([triangleTopLength, thickness]);
        hull() {
            square([thickness,thickness]);
            translate([(rectLength/2)-(triangleTopLength/2),thickness+triangleHeight])
                square([thickness,thickness]);
        }
        hull() {
            translate([rectLength+thickness,0]) square([thickness,thickness]);
            translate([(rectLength/2)+(triangleTopLength/2)-thickness,thickness+triangleHeight])
                square([thickness,thickness]);
        }
        // teethed arm
        translate([(rectLength/2)-(triangleTopLength/2),(2*thickness)+triangleHeight])
        difference() {
            square([triangleTopLength,armLength]);
            // cut out middle of arm
            translate([armSideThickness+teethHeight,0])
                square([triangleTopLength-(armSideThickness*2)-(teethHeight*2),armLength]);
            // cut out teeth
            numGrooves = round(armLength/(grooveLength+teethLength));
            for(idx=[0:numGrooves-1]) {
                translate([armSideThickness,idx*(grooveLength+teethLength)]) {
                    square([triangleTopLength-(armSideThickness*2), grooveLength]);
                }
            }
        }
    }
}
fanHolder();