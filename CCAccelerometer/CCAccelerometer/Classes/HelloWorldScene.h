//
//  HelloWorldScene.h
//  CCAccelerometer
//
//  Created by Sauvik Dolui on 9/4/14.
//  Copyright Innofied Solution Pvt. Ltd. 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using Cocos2D v3
#import "cocos2d.h"
#import "cocos2d-ui.h"

#import "CCAcceleroMeter.h"

// -----------------------------------------------------------------------

/**
 *  The main scene
 */
@interface HelloWorldScene : CCScene<CCSharedAccelerometerDelegate>
{
    // -------------------------------------------
    //      SHARED ACCELEROMETER INSTANCE
    // --------------------------------------------
    CCAcceleroMeter *accelerometer;
    // -----------------------------------------------------------------------
}

// -----------------------------------------------------------------------

+ (HelloWorldScene *)scene;
- (id)init;

// -----------------------------------------------------------------------
@end