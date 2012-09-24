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
        Sprite *s = [Sprite spriteWithFile:@"temp_sprite_three"];
        Sprite *s2 = [Sprite spriteWithFile:@"temp_sprite_two"];
        [self addChild:s2];
        [self addChild:s];

    }
    return self;
}

@end
