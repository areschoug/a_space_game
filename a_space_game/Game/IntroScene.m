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
        Decoration *dec = [Decoration randomDecoration];
        dec.position = CGPointMake(320, 500);
        dec.velocity = CGPointMake(0, 0.1);
        [self addChild:dec];
        
        Decoration *dec2 = [Decoration randomDecoration];
        dec2.position = CGPointMake(320, 100);
        dec2.velocity = CGPointMake(0, 0.1);
        [self addChild:dec2];
        
    }
    return self;
}

-(void)update:(NSTimeInterval)td{
    lastAddedDecoration += td;
    
    if (lastAddedDecoration > kGameDecorationAddRate) {
        lastAddedDecoration = 0;
        Decoration *dec = [Decoration randomDecoration];
        dec.position = CGPointMake(320, 900);
        dec.velocity = CGPointMake(0, -3);
        [self addChild:dec];
        NSLog(@"ADDED");
    } 
}

@end
