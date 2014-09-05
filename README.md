CCAcceleroMeter
===============

Plugin for using Acceleromter in Cocos2d V.3.x

HOW TO USE
==========
1. Add CoreMotion Framework in your project from Build Phases.
2. Copy CCAccelerometer.h and CCAccelerometer.h files in your project.
3. Import CCAccelerometer.h file in the Prefix.pch.
4. Implement the <CCSharedAccelerometerDelegate> in the CCScene where you want to use the accelerometer.
5. Create shared instance in init method by simply calling [CCAcceleroMeter sharedAccelerometer];
6. Start accelerometer in -(void)onEnterTransitionDidFinish by calling [CCAcceleroMeter sharedAccelerometer]startUpdateForScene:self];
7. Define delegate method -(void)acceleroMeterDidAccelerate:(CMAccelerometerData*)accelerometerData in your scene.
8. Stop accelerometer in -(void)onExitTransitionDidStart by calling [CCAcceleroMeter sharedAccelerometer]stopUpdateForScene:self];

