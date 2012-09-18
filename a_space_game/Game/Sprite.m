//
//  Sprite.h
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import "Sprite.h"

@implementation Sprite
@synthesize textureInfo = _textureInfo;
@synthesize program = _program;

- (void)draw
{
    NSLog(@"Drawing a sprite");
}

- (id)initWithFile:(NSString*)fileName
{
    self = [super init];
    if(self){
        self.textureInfo = [[TextureCache sharedTextureCache] addImage:fileName];
        self.program = [[ProgramManager sharedProgramManager] getDefaultProgram];
    }
    return self;
}

+ (id)spriteWithFile:(NSString*)filename
{
	return [[self alloc] initWithFile:filename];
}

@end
