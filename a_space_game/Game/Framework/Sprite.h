//
//  Sprite.h
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "Entity.h"
#import "TextureCache.h"
#import "GLProgram.h"
#import "ProgramManager.h"

typedef enum{
    kDefaultTextureProgram,
    kDefaultTextureColorProgram,
} DefaultPrograms;

@interface Sprite : Entity

@property (strong, nonatomic) GLKTextureInfo *textureInfo;
@property (strong, nonatomic) GLProgram *program;
@property (strong, nonatomic) UIColor *color;
@property (assign, nonatomic) BOOL allowToRemove;

@property (readwrite, nonatomic) CGPoint position;
@property (readwrite, nonatomic) CGPoint velocity;
@property (readwrite, nonatomic) CGFloat rotation;

+ (id)spriteWithFile:(NSString*)filename;
- (id)initWithFile:(NSString*)fileName andDefaultProgram:(DefaultPrograms)program;
@end
