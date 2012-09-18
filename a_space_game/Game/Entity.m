//
//  Entity.m
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import "Entity.h"

@interface Entity()
@property (strong, nonatomic) NSMutableArray *children;
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
        
    }
    return self;
}

- (void)draw {

}

- (void)visit {
    if(_children) {
        for (Entity* child in self.children) {
            [child visit];
        }
    }
    [self draw];
}

- (NSMutableArray*)children {
    if (!_children) {
        _children = [NSMutableArray array];
    }
    return _children;
}

- (GLKMatrix4) modelMatrix {
    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
//    modelMatrix = GLKMatrix4Translate(modelMatrix, _position.x, _position.y, 0);
//    modelMatrix = GLKMatrix4Translate(modelMatrix, - _size.width/2, -_size.height/2, 0);
    modelMatrix = GLKMatrix4Translate(modelMatrix, 50, 50, 0);
    modelMatrix = GLKMatrix4Translate(modelMatrix, 50, 50, 0);
    return modelMatrix;
}

@end
