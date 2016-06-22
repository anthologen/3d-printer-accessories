// Mount Arm
// An arm that can be slid on to the top of the FlashForge Creator Pro
// Though designed for the printer with side walls removed, you can easily adjust the holderLength 
// The arm's teeth allow the lasso piece to adjust its location on the arm without slipping

module armMount() {
    thickness = 5;
    holderLength = 64;
    holderArmSideDown = 25;
    holderHookSideDown = 9;
    holderHookLength = 12;
    armLength = 80;
    armSupportDown = 25;
    armSupportOut = 25;
    teethLength = 1;
    teethHeight = 1;
    grooveLength = 2;
    componentWidth = 10;

    linear_extrude(height=componentWidth) {
        // make holder that grips the printer
        square([holderLength+(thickness*2),thickness]); // top side
        translate([holderLength+thickness,-holderArmSideDown])
            square([thickness,holderArmSideDown]); // arm side
        translate([0,-holderHookSideDown])
            square([thickness,holderHookSideDown]); // hook side
        // add hook to holder
        translate([0,-holderHookSideDown-thickness])
            square([holderHookLength+thickness,thickness]);
        // add arm
        translate([holderLength+(thickness*2),0])
            square([armLength,thickness]);
        // add arm support
        hull() {
            translate([holderLength+(thickness*2)+armSupportOut,0])
                square([thickness,thickness]);
            translate([holderLength+thickness,-armSupportDown])
                square([thickness,thickness]);
        }
        // add teeth on top of the arm
        numTeeth = round((armLength-armSupportOut)/(grooveLength+teethLength));
        translate([holderLength+armSupportOut+(thickness*2),thickness])
            for(idx=[0:numTeeth-1]) {
                translate([idx*(grooveLength+teethLength),0]) {
                    square([teethLength, teethHeight]);
                }
            }
    }
}
armMount();