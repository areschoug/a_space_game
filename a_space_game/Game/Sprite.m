//
//  Sprite.h
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import "Sprite.h"

static const GLfloat squareVertices[] = {
    -1.0f, -1.0f,
    1.0f, -1.0f,
    -1.0f,  1.0f,
    1.0f,  1.0f,
};

static const GLfloat textureVertices[] = {
    1.0f, 1.0f,
    1.0f, 0.0f,
    0.0f,  1.0f,
    0.0f,  0.0f,
};

@implementation Sprite
@synthesize textureInfo = _textureInfo;
@synthesize program = _program;

- (void)draw {
    //TODO:Draw
    [_program use];

    
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, _textureInfo.name);
    
    glUniform1f(uniforms[UNIFORM_TEXTURE], 0);
    
    glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, squareVertices);
	glEnableVertexAttribArray(ATTRIB_VERTEX);
	glVertexAttribPointer(ATTRIB_TEXTUREPOSITON, 2, GL_FLOAT, 0, 0, textureVertices);
	glEnableVertexAttribArray(ATTRIB_TEXTUREPOSITON);
	
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
}

- (id)initWithFile:(NSString*)fileName {
    self = [super init];
    if(self) {
        _textureInfo = [[TextureCache sharedTextureCache] addImage:fileName];
        _program = [[ProgramManager sharedProgramManager] getDefaultProgram];
    }
    return self;
}

+ (id)spriteWithFile:(NSString*)filename {
	return [[self alloc] initWithFile:filename];
}

@end
