//
//  Player.m
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-10-13.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import "Player.h"

@implementation Player

- (id)init {
    self = [super initWithFile:@"player_ship" andDefaultProgram:kDefaultTextureColorProgram];
    if (self) {
        [self setColor:[UIColor colorWithRed:1.000 green:0.996 blue:0.937 alpha:1]];
        [self setRotation:90.0];
    }
    return self;
}

@end
