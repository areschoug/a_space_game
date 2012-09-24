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
    if (lastAddedDecoration > kGameDecorationAddRate) {
        lastAddedDecoration = 0;
        Decoration *dec = [Decoration randomDecoration];
        float f = arc4random() % kGameDecorationNumberOf;
        dec.position = CGPointMake((f/kGameDecorationNumberOf) * 640.0, 1000);
        dec.velocity = CGPointMake(0,-( arc4random() % 6000/1000 + 10.0));
        [self addChild:dec];
    } 
}

@end
