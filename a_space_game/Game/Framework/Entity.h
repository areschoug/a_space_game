//
//  Entity.h
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "Config.h"

@interface Entity : NSObject

@property (strong, nonatomic) NSMutableSet *children;
@property (assign, nonatomic) BOOL shouldBeRemoved;
@property (assign, nonatomic) int shouldRemove;

+ (id)build;

- (id)init;
- (void)visit;
- (void)addChild:(Entity*)child;
- (void)draw;

@end