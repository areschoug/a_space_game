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

@interface Sprite()

@end

@implementation Sprite
@synthesize textureInfo = _textureInfo;
@synthesize program = _program;

- (void)draw {
    [_program use];
    [self updatePosition];
    
    glViewport(_position.x, _position.y, _textureInfo.width, _textureInfo.height);
    glEnable(GL_TEXTURE);    
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, _textureInfo.name);
    
    glUniform1f(uniforms[UNIFORM_TEXTURE], 0);
    
    glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, squareVertices);
	glEnableVertexAttribArray(ATTRIB_VERTEX);
	glVertexAttribPointer(ATTRIB_TEXTUREPOSITON, 2, GL_FLOAT, 0, 0, textureVertices);
	glEnableVertexAttribArray(ATTRIB_TEXTUREPOSITON);
	
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);

}

-(void)updatePosition{
    _position.x += _velocity.x;
    _position.y += _velocity.y;
}

- (id)initWithFile:(NSString*)fileName {
    self = [super init];
    if(self) {
        NSLog(@"[ADDED DECORATION]%@",fileName);
        _textureInfo = [[TextureCache sharedTextureCache] addImage:fileName];
        _program = [[ProgramManager sharedProgramManager] getDefaultProgram];
        

    }
    return self;
}

+ (id)spriteWithFile:(NSString*)filename {
	return [[self alloc] initWithFile:filename];
}

@end
