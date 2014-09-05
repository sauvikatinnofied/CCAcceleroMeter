//
//  CCAcceleroMeter.m
//  Cocos2d3.1
//
//  Created by Sauvik Dolui on 7/7/14.
//  Copyright 2014 Innofied Solution Pvt. Ltd. All rights reserved.
//

#import "CCAcceleroMeter.h"


@implementation CCAcceleroMeter

+(instancetype) sharedAccelerometer
{
    static CCAcceleroMeter *sharedMeter;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedMeter = [[CCAcceleroMeter alloc] init];
    });
    return  sharedMeter;
}
-(instancetype) init
{
    
    if (self = [super init]) {
        
        // Request for receiving accelerometer events
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(orientationChanged)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
        
        // finding out the current orientation
        [self orientationChanged];
        
        // allocating the MototionManager
        _motionManager = [[CMMotionManager alloc] init];
        
    }
    return self;
}

-(void)startInitialUpDate:(CCTime)dt
{
    if (_motionManager.isAccelerometerAvailable ) {
        if (_motionManager.isAccelerometerActive) {
            CMAccelerometerData *accelerometerData = _motionManager.accelerometerData;
            if ([self.delegate respondsToSelector:@selector(acceleroMeterDidAccelerate:)]) {           
                
                [self.delegate performSelector:@selector(acceleroMeterDidAccelerate:) withObject:accelerometerData];
            }
        }
        else
        {
            //NSLog(@"CCAcceleroMeter: AcceleroMeter is not active ");
        }
    }
    else
    {
         //NSLog(@"CCAcceleroMeter: AcceleroMeter is not available ");
    }
    

    
}
-(void) startUpdateForScene:(CCScene *)scene
{
    if (scene.userInteractionEnabled) {
        self.delegate = scene;
        [_motionManager startAccelerometerUpdates];
        [self schedule:@selector(startInitialUpDate:) interval:1.0/60.0];
    }
    else{
        // Delegate Scene is not userInteractionEnabled, so not going to start the acceleroMeter
        NSLog(@"CCAcceleroMeter: Delegate Scene is not userInteractionEnabled, so not going to start the acceleroMeter");
    }
    
}
-(void) stopUpdateForScene:(CCScene *)scene
{
    if (self.delegate) {
        [self unschedule:@selector(startInitialUpDate:)];
        [_motionManager stopAccelerometerUpdates];
        self.delegate = nil;
    }
    
}

-(void) setUpdateInterval:(float)interval
{
    if (_motionManager.isAccelerometerAvailable ) {        
        if (_motionManager.isAccelerometerActive)
        {
            _motionManager.accelerometerUpdateInterval = interval;
        }
    }
}

-(void)orientationChanged
{
    if([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait )
    {
        _orientation = DeviceOrientationPortraitNormal;
    }
    else if([UIDevice currentDevice].orientation == UIDeviceOrientationPortraitUpsideDown)
    {
        _orientation = DeviceOrientationPortraitUpSideDown;
    }
    else if([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft)
    {
        _orientation = DeviceOrientationLandscapeHomeButtonRight;
    }
    else if([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight){
        _orientation = DeviceOrientationLandscapeHomeButtonLeft;
    }
}
@end
