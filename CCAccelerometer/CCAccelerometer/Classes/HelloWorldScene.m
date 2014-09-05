//
//  HelloWorldScene.m
//  CCAccelerometer
//
//  Created by Sauvik Dolui on 9/4/14.
//  Copyright Innofied Solution Pvt. Ltd. 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "HelloWorldScene.h"
#import "IntroScene.h"

// -----------------------------------------------------------------------
#pragma mark - HelloWorldScene
// -----------------------------------------------------------------------

@implementation HelloWorldScene
{
    CCSprite *_sprite;
    CGPoint _spriteVelocity;
}

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (HelloWorldScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    // Add a sprite
    _sprite = [CCSprite spriteWithImageNamed:@"Icon-72.png"];
    _sprite.position  = ccp(self.contentSize.width/2,self.contentSize.height/2);
    [self addChild:_sprite];
    
    // Animate sprite with action
    CCActionRotateBy* actionSpin = [CCActionRotateBy actionWithDuration:1.5f angle:360];
    [_sprite runAction:[CCActionRepeatForever actionWithAction:actionSpin]];
    
    // Create a back button
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
    
    
    // ----------------------------------------------
    //     INSTANTIATION OF SHARED ACCELEROMETER
    // ----------------------------------------------
    accelerometer = [CCAcceleroMeter sharedAccelerometer];
    
    


    // done
	return self;
}

// -----------------------------------------------------------------------

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInteractionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    
}

-(void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    
    // ---------------------------------------------------------------------------------------------
    //      Activiting the Accelerometer after the enter trasition has finished.
    // ---------------------------------------------------------------------------------------------
    accelerometer = [CCAcceleroMeter sharedAccelerometer];
    [accelerometer startUpdateForScene:self];
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

-(void)onExitTransitionDidStart
{
    // ---------------------------------------------------------------------------------------------
    //      Deactiviting the Accelerometer on the exit trasition started.
    // ---------------------------------------------------------------------------------------------
    [accelerometer stopUpdateForScene:self];
    [super onExitTransitionDidStart];
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {

}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}




// ----------------------------------------------------------------
//     POSITION CONTROL OF SPRITE ACCORDING TO THE ACCELERATION
// ----------------------------------------------------------------

-(void)update:(CCTime)delta
{
    // Keep adding up the sprite's velocity to the sprite's position
    CGPoint pos =_sprite.position;
    
    pos.x += _spriteVelocity.x;
    // The Player should also be stopped from going outside the screen
    
    CGSize screenSize=[CCDirector sharedDirector].viewSize;
    float imageWidthHalved =_sprite.contentSize.width * 0.5f;
    float leftBorderLimit = imageWidthHalved;
    float rightBorderLimit = screenSize.width - imageWidthHalved;
    // preventing the player sprite from moving outside the screen
    
    if (pos.x<leftBorderLimit)
    {
        pos.x = leftBorderLimit;
        _spriteVelocity = CGPointZero;
    }
    else if (pos.x>rightBorderLimit)
    {
        pos.x = rightBorderLimit;
        _spriteVelocity = CGPointZero;
    }
    // assigning the modified position back
    _sprite.position = pos;
}

// ----------------------------------------------------------------
        #pragma mark- CCAccelerometer Delegate Method
// ----------------------------------------------------------------
-(void)acceleroMeterDidAccelerate:(CMAccelerometerData*)accelerometerData
{
        CMAcceleration acceleration = accelerometerData.acceleration;
    
        //CCLOG(@"ACCELEROMETER DATA (x, y, z) = (%f,%f,%f)",acceleration.x,acceleration.y,acceleration.z);
    
        // controls how quickly velocity decelerates (lower=quicker to change direction)
        float deceleration =0.2f;
        // determines how sensitive the accelerometer reacts (higher=more sensitive)
        float sensitivity = 20.0f;
        // how fast the velocity can be at most
        float maxVelocity = 800;
        
        if ([CCAcceleroMeter sharedAccelerometer].orientation == DeviceOrientationLandscapeHomeButtonLeft) {
            // adjust velocity based on current accelerometer acceleration
            _spriteVelocity.x = _spriteVelocity.x * deceleration + acceleration.y * sensitivity;
        }
        else if([CCAcceleroMeter sharedAccelerometer].orientation == DeviceOrientationLandscapeHomeButtonRight)
        {
            // adjust velocity based on current accelerometer acceleration
            _spriteVelocity.x = _spriteVelocity.x * deceleration - acceleration.y * sensitivity;
        }
        
        // Limiting velocity in both direction
        
        if (_spriteVelocity.x>maxVelocity)
        {
            _spriteVelocity.x = maxVelocity;
        }
        else if (_spriteVelocity.x <- maxVelocity)
        {
            _spriteVelocity.x = - maxVelocity;
        }
}
@end
