//
//  Sprite.h
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import "Sprite.h"
#import "CC3GLMatrix.h"

static const GLfloat squareVertices[] = {
    -1.0f, -1.0f, 1.0f,
    1.0f, -1.0f,  1.0f,
    -1.0f,  1.0f,  1.0f,
    1.0f,  1.0f,  1.0f,
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
    int _removed;
    GLfloat _colorValues[4];
}

@synthesize textureInfo = _textureInfo;
@synthesize program = _program;


- (id)initWithFile:(NSString*)fileName {
    self = [super init];
    if(self) {
        _textureInfo = [[TextureCache sharedTextureCache] addImage:fileName];
        _program = [[ProgramManager sharedProgramManager] getDefaultColorProgram];
        
        [self setColor:[UIColor colorWithRed:0.549 green:0.192 blue:0.678 alpha:1.0]];
    }
    return self;
}


- (void)draw {
    
    [_program use];
    [self updatePosition];

    CC3GLMatrix *projection = [CC3GLMatrix matrix];
    float h = 4.0f * _textureInfo.height / _textureInfo.width;
    [projection populateFromFrustumLeft:-2 andRight:2 andBottom:-h/2 andTop:h/2 andNear:6 andFar:10];
    glUniformMatrix4fv(uniforms[UNIFORM_PROJECTION], 1, 0, projection.glMatrix);
    
    CC3GLMatrix *modelView = [CC3GLMatrix matrix];
    [modelView populateFromTranslation:CC3VectorMake(0, 0, -7)];
    [modelView rotateByZ:_rotation];
    glUniformMatrix4fv(uniforms[UNIFORM_MODELVIEW], 1, 0, modelView.glMatrix);
    
    glUniform4f(uniforms[UNIFORM_COLOR], _colorValues[0], _colorValues[1], _colorValues[2], _colorValues[3]);
    
    glViewport(_position.x, _position.y, _textureInfo.width, _textureInfo.height);
    
    glVertexAttribPointer(ATTRIB_VERTEX, 3, GL_FLOAT, 0, 0, squareVertices);
	glEnableVertexAttribArray(ATTRIB_VERTEX);
	glVertexAttribPointer(ATTRIB_TEXTUREPOSITON, 2, GL_FLOAT, 0, 0, textureVertices);
	glEnableVertexAttribArray(ATTRIB_TEXTUREPOSITON);

    
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, _textureInfo.name);
    
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);




}

-(void)updatePosition{
    _position.x += _velocity.x;
    _position.y += _velocity.y;
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

-(void)visit{
    [super visit];
    
    
    
    if (_allowToRemove && !self.shouldBeRemoved) {
        BOOL left = (_velocity.x < 0) ? YES : NO;
        BOOL up = (_velocity.y < 0) ? YES : NO;
        
        CGRect rect = [[[UIApplication sharedApplication]keyWindow]frame];
        float scale = [[[[UIApplication sharedApplication]keyWindow]screen] scale];

        BOOL removeVertical;
        BOOL removeHorizontal;
        
        float height = (float) _textureInfo.height;
        float width = (float) _textureInfo.width;
        
        if (up) removeVertical = (_position.y < -height) ? YES : NO;
        else removeVertical = (_position.y > (rect.size.height * scale) + height) ? YES : NO;

        if (left) removeHorizontal = (_position.x < -width) ? YES : NO;
        else removeHorizontal = (_position.x > (rect.size.width * scale) + width) ? YES : NO;
        
        if (removeVertical || removeHorizontal){
            self.shouldBeRemoved = YES;
        }



    }

}

@end
