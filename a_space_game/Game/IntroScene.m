//
//  IntroScene.m
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import "IntroScene.h"
#import "Sprite.h"

@implementation IntroScene

- (id)init {
    self = [super init];
    if(self) {
        [self addChild:[Sprite spriteWithFile:@"temp_sprite"]];
    }
    return self;
}

@end
