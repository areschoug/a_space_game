//
//  IntroScene.m
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import "IntroScene.h"
#import "Decoration.h"

@implementation IntroScene{
    float lastAddedDecoration;
}

- (id)init {
    self = [super init];
    if(self) {
        
    }
    return self;
}

-(void)update:(NSTimeInterval)td{
    lastAddedDecoration += td;
    [self clean];
    if (lastAddedDecoration > kGameDecorationAddRate) {

        lastAddedDecoration = 0;
        Decoration *dec = [Decoration randomDecoration];
        dec.position = CGPointMake(320.0, 480.0);
        
        int up = arc4random() % 2;
        int left = arc4random() % 2;
        BOOL goUp;
        BOOL goLeft;
        
        if (up < 1) goUp = 1;
        else goUp = -1;
        
        if (left < 1) goLeft = 1;
        else goLeft = -1;
        
        dec.velocity = CGPointMake(( arc4random() % 10 + 5.0) * goLeft,( arc4random() % 10 + 5.0) * goUp);
        dec.allowToRemove = YES;
        [self addChild:dec];

        
//        Decoration *dec2 = [Decoration randomDecoration];
//        float f2 = arc4random() % 100;
//        dec2.position = CGPointMake((f2/100) * 640.0, 1000);
//        dec2.velocity = CGPointMake(0,-( arc4random() % 6000/1000 + 10.0));
//        dec2.allowToRemove = YES;
//        [self addChild:dec2];
//
//        Decoration *dec3 = [Decoration randomDecoration];
//        float f3 = arc4random() % 100;
//        dec3.position = CGPointMake((f3/100) * 640.0, 1000);
//        dec3.velocity = CGPointMake(0,-( arc4random() % 6000/1000 + 10.0));
//        dec3.allowToRemove = YES;
//        [self addChild:dec3];
//
//        Decoration *dec4 = [Decoration randomDecoration];
//        float f4 = arc4random() % 100;
//        dec4.position = CGPointMake((f4/100) * 640.0, 1000);
//        dec4.velocity = CGPointMake(0,-( arc4random() % 6000/1000 + 10.0));
//        dec4.allowToRemove = YES;
//        [self addChild:dec4];
//        
//        Decoration *dec5 = [Decoration randomDecoration];
//        float f5 = arc4random() % 100;
//        dec5.position = CGPointMake((f5/100) * 640.0, 1000);
//        dec5.velocity = CGPointMake(0,-( arc4random() % 6000/1000 + 10.0));
//        dec5.allowToRemove = YES;
//        [self addChild:dec5];
//        
//        Decoration *dec6 = [Decoration randomDecoration];
//        float f6 = arc4random() % 100;
//        dec6.position = CGPointMake((f6/100) * 640.0, 1000);
//        dec6.velocity = CGPointMake(0,-( arc4random() % 6000/1000 + 10.0));
//        dec6.allowToRemove = YES;
//        [self addChild:dec6];
//        
//        Decoration *dec7 = [Decoration randomDecoration];
//        float f7 = arc4random() % 100;
//        dec7.position = CGPointMake((f7/100) * 640.0, 1000);
//        dec7.velocity = CGPointMake(0,-( arc4random() % 6000/1000 + 10.0));
//        dec7.allowToRemove = YES;
//        [self addChild:dec7];
    }
}

@end
