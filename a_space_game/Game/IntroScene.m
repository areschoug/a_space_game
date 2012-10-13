//
//  IntroScene.m
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import "IntroScene.h"
#import "Decoration.h"
#import "Player.h"

@implementation IntroScene{
    Player *_player;
    float _lastAddedDecoration;
}

- (id)init {
    self = [super init];
    if(self) {
        _player = [[Player alloc] init];
        _player.position = CGPointMake(0, 0);
        [self addChild:_player];
    }
    return self;
}

-(void)update:(NSTimeInterval)td{
    _lastAddedDecoration += td;
    [self clean];
    
    
    if (_lastAddedDecoration > kGameDecorationAddRate) {
        
        _lastAddedDecoration = 0;
        {
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
            
            dec.rotation = arc4random() % 360;
            dec.velocity = CGPointMake(( arc4random() % 10 + 2.5) * goLeft,( arc4random() % 10 + 2.5) * goUp);
            dec.allowToRemove = YES;
            [self addChild:dec];
        }
        return;;
        {
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
            
            dec.rotation = arc4random() % 360;
            dec.velocity = CGPointMake(( arc4random() % 10 + 2.5) * goLeft,( arc4random() % 10 + 2.5) * goUp);
            dec.allowToRemove = YES;
            [self addChild:dec];
        }
        {
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
            
            dec.rotation = arc4random() % 360;
            dec.velocity = CGPointMake(( arc4random() % 10 + 2.5) * goLeft,( arc4random() % 10 + 2.5) * goUp);
            dec.allowToRemove = YES;
            [self addChild:dec];
        }
        
        {
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
            
            dec.rotation = arc4random() % 360;
            dec.velocity = CGPointMake(( arc4random() % 10 + 2.5) * goLeft,( arc4random() % 10 + 2.5) * goUp);
            dec.allowToRemove = YES;
            [self addChild:dec];
        }

    }
}

@end
