//
//  HelloWorldLayer.m
//  TouchQuickly
//
//  Created by IDUP-B1 on 12-8-22.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer


// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)spriteMoveFinished:(id)sender{
    CCSprite *sprite = (CCSprite *)sender;
    [self removeChild:sprite cleanup:YES];
}




-(void)changeTime:(NSTimer *)theTimer{
    static int timeLeft = 3;
    if(timeLeft == 0){
         self.isTouchEnabled = YES;
        [theTimer invalidate];
        [TimeLabel setString:@""];
        return;
    }
    else{
        timeLeft = timeLeft - 1;

    }
    if(timeLeft == 0) 
        [TimeLabel setString:@"START"];
    else
        [TimeLabel setString:[NSString stringWithFormat:@"%d",timeLeft]];
    
}


// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        x = size.width/2;

        TimeLabel = [CCLabelTTF labelWithString:[[NSString alloc]initWithFormat:@"%d",3] fontName:@"Marker Felt" fontSize:64];
        TimeLabel.color = ccYELLOW;
        TimeLabel.position = ccp(size.width/2,size.height/2);
        [TimeLabel setString:@"3"];

        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeTime:) userInfo:nil repeats:YES];

 
        faceBack = [CCSprite spriteWithFile:@"backface.png"];
        faceBack.position = ccp(x, size.height/2);
        [self addChild:faceBack];
        
        faceForward = [CCSprite spriteWithFile:@"face.png"];
        faceForward.position = ccp(x, size.height/2);
        [self addChild:faceForward];
     
         [self addChild:TimeLabel];
        

	} 

	return self;
}



- (BOOL)ccTouchesBegan:(UITouch *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];

    
    CGSize winSize = [[CCDirector sharedDirector]winSize];
    if(location.x<winSize.width/2){
        x += 10;
    }else{
        x -= 10;
    }
    if(x <= winSize.width*3/8){
        CCTexture2D *boywin = [[CCTextureCache sharedTextureCache]addImage:@"bluewin.png"];
        faceForward.texture = boywin;
    }
    else if(x > winSize.width*3/8 && x<winSize.width*5/8){
        CCTexture2D *nowin = [[CCTextureCache sharedTextureCache]addImage:@"face.png"];
        faceForward.texture = nowin;
    }
    else if(x >= winSize.width*5/8){
        CCTexture2D *girlwin = [[CCTextureCache sharedTextureCache]addImage:@"redwin.png"];
        faceForward.texture = girlwin;
    }
    if(x<=0){
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"BlueWin" fontName:@"Marker Felt" fontSize:100];
		label.position =  ccp( winSize.width /2 , winSize.height/2 );
		[self addChild: label];
        
        self.isTouchEnabled = NO;
    }
    else if(x>=winSize.width){
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"RedWin" fontName:@"Marker Felt" fontSize:100];
		label.position =  ccp( winSize.width /2 , winSize.height/2 );
		[self addChild: label];
        
        self.isTouchEnabled = NO;
    }
        
    faceBack.position = ccp(x,winSize.height/2);
    faceForward.position = ccp(x,winSize.height/2);

    return YES;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    faceForward = NULL;
    faceBack = NULL;

	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
