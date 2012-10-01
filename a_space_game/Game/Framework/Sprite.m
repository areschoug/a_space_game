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

@implementation Sprite{

    GLfloat _colorValues[4];
}


@synthesize textureInfo = _textureInfo;
@synthesize program = _program;

- (void)draw {
    [_program use];
    [self updatePosition];
    
    glViewport(_position.x, _position.y, _textureInfo.width, _textureInfo.height);
    glEnable(GL_TEXTURE);    
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, _textureInfo.name);
    
    glUniform4f(uniforms[UNIFORM_COLOR], _colorValues[0], _colorValues[1], _colorValues[2], _colorValues[3]);
    
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
        _textureInfo = [[TextureCache sharedTextureCache] addImage:fileName];
        _program = [[ProgramManager sharedProgramManager] getDefaultProgram];
        [self setColor:[UIColor colorWithRed:0.549 green:0.192 blue:0.678 alpha:1]];
    }
    return self;
}

+ (id)spriteWithFile:(NSString*)filename {
	return [[self alloc] initWithFile:filename];
}

-(void)setColor:(UIColor *)color{
    CGColorRef colorref = [color CGColor];
    
    int numComponents = CGColorGetNumberOfComponents(colorref);
    if (numComponents == 4) {
        const CGFloat *components = CGColorGetComponents(colorref);
        _colorValues[0] = components[0];
        _colorValues[1] = components[1];
        _colorValues[2] = components[2];
        _colorValues[3] = components[3];
    }
}

@end
