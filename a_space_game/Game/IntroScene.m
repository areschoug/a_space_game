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
    NSTimeInterval lastAddedDecoration;
}

- (id)init {
    self = [super init];
    if(self) {

        
    }
    return self;
}

-(void)draw{

    if (lastAddedDecoration > kGameDecorationAddRate) {
        Decoration *dec = [[Decoration alloc] init];
        dec.position = CGPointMake(320, 500);
        dec.velocity = CGPointMake(0, 0.1);
        [self addChild:dec];
        NSLog(@"ADDED");
    } else {
        NSLog(@"%f %i",lastAddedDecoration,kGameDecorationAddRate);
    }
    
}

@end
