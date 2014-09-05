//
//  CCAcceleroMeter.h
//  Cocos2d3.1
//
//  Created by Sauvik Dolui on 7/7/14.
//  Copyright 2014 Innofied Solution Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <CoreMotion/CoreMotion.h>

typedef NS_ENUM(NSInteger, DeviceOrientation) {
    DeviceOrientationPortraitNormal,
    DeviceOrientationPortraitUpSideDown,
    DeviceOrientationLandscapeHomeButtonRight,
    DeviceOrientationLandscapeHomeButtonLeft,
    
};

@protocol CCSharedAccelerometerDelegate

@required
-(void)acceleroMeterDidAccelerate:(CMAccelerometerData*)accelerometerData;
@end


@interface CCAcceleroMeter : CCNode {
    
    CMMotionManager *_motionManager;
    
}
@property(weak) id delegate;
@property DeviceOrientation orientation;


+(instancetype) sharedAccelerometer;
-(instancetype) init;

-(void) startUpdateForScene:(CCScene*)scene;
-(void) stopUpdateForScene:(CCScene*)scene;
-(void) setUpdateInterval:(float)interval;

@end
