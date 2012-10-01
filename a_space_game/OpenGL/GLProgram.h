//
//  GLProgram.h
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    UNIFORM_TEXTURE,
    UNIFORM_COLOR,
    NUM_UNIFORMS
};
GLint uniforms[NUM_UNIFORMS];

enum {
    ATTRIB_VERTEX,
    ATTRIB_TEXTUREPOSITON,
    NUM_ATTRIBUTES
};

@interface GLProgram : NSObject

//+(GLuint)compileShader:(NSString*)shaderName withType:(GLenum)shaderType;
//+(GLuint)createProgram;
//+(UniformInfo)getUniforms:(GLuint)program;
- (void)use;
- (id)initWithVertexShader:(NSString*)vertexShaderName fragmentShader:(NSString*)fragmentShaderName;

@end