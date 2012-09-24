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
    self = [super initWithFile:[NSString stringWithFormat:@"decoration_%i",kGameDecorationRandom]];
    if (self) {
        
    }
    return self;
}


+ (id)randomDecoration {
	return [[self alloc] initWithFile:[NSString stringWithFormat:@"decoration_%i",kGameDecorationRandom]];
}


@end
