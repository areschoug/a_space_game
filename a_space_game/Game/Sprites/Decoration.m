//
//  Decorations.m
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-24.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import "Decoration.h"

@implementation Decoration

- (id)init {
    self = [super initWithFile:[NSString stringWithFormat:@"decoration_test_%i",kGameDecorationRandom] andDefaultProgram:kDefaultTextureColorProgram];
    if (self) {
        [self setColor:[UIColor colorWithRed:0.549 green:0.192 blue:0.678 alpha:1.0]];        
    }
    return self;
}

+ (id)randomDecoration {
	return [[self alloc] init];
}


@end
