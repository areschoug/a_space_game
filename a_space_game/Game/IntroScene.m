//
//  IntroScene.m
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import "IntroScene.h"
#import "Decoration.h"

@implementation IntroScene

- (id)init {
    self = [super init];
    if(self) {
        Decoration *dec = [[Decoration alloc] init];
        dec.position = CGPointMake(320, 250);
        [self addChild:dec];

    }
    return self;
}

@end
