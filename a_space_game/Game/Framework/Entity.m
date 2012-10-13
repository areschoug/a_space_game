//
//  Entity.m
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import "Entity.h"

@interface Entity()

@end

@implementation Entity
@synthesize children = _children;

+ (id)build {
    return [[self alloc] init];
}

- (void)addChild:(Entity*)child {
    [self.children addObject:child];
}

- (id)init {
    self = [super init];
    if(self) {
        _shouldRemove = 0;
    }
    return self;
}

- (void)draw {

}

- (void)visit {
    if (!self.shouldBeRemoved) [self draw];
    
    if(_children) {
        for (Entity* child in self.children) [child visit];
    }

    
    
}


- (NSMutableSet*)children {
    if (!_children) _children = [NSMutableSet set];
    return _children;
}

@end
