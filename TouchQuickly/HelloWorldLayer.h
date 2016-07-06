//
//  HelloWorldLayer.h
//  TouchQuickly
//
//  Created by IDUP-B1 on 12-8-22.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    CCSprite *faceBack;
    CCSprite *faceForward;
    int x;
    CCLabelTTF *TimeLabel;
  
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;


@end
