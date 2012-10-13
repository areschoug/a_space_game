//
//  GLProgram.m
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import "GLProgram.h"

@interface GLProgram(){
    GLuint _program;
}
@end

@implementation GLProgram

- (id)initWithVertexShader:(NSString*)vertexShaderName fragmentShader:(NSString*)fragmentShaderName {
    self = [super init];
    if (self) {
        [self loadVertexShader:vertexShaderName fragmentShader:fragmentShaderName forProgram:&_program];
        
    }
    return self;
}

- (GLuint)compileShader:(NSString*)shaderName withType:(GLenum)shaderType {
    // Load the shader in memory
    NSString *shaderPath = [[NSBundle mainBundle] pathForResource:shaderName ofType:@"glsl"];
    NSError *error;
    NSString *shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
    if(!shaderString) {
        NSLog(@"Error loading shader: %@", error.localizedDescription);
        exit(1);
    }
    
    // Create the shader inside openGL
    GLuint shaderHandle = glCreateShader(shaderType);
    
    // Give that shader the source code loaded in memory
    const char *shaderStringUTF8 = [shaderString UTF8String];
    int shaderStringLength = [shaderString length];
    glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength);
    
    // Compile the source code
    glCompileShader(shaderHandle);
    
    // Get the error messages in case the compiling has failed
    GLint compileSuccess;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
    if (compileSuccess == GL_FALSE) {
        GLint logLength;
        glGetShaderiv(shaderHandle, GL_INFO_LOG_LENGTH, &logLength);
        if(logLength > 0) {
            GLchar *log = (GLchar *)malloc(logLength);
            glGetShaderInfoLog(shaderHandle, logLength, &logLength, log);
            NSLog(@"Shader compile log:\n%s", log);
            free(log);
        }
        exit(1);
    }
    
    return shaderHandle;
}

- (BOOL)loadVertexShader:(NSString *)vertexShaderName fragmentShader:(NSString *)fragmentShaderName forProgram:(GLuint *)programPointer{
    
    GLuint vertexShader, fragShader;
    
    // Create shader program.
    *programPointer = glCreateProgram();
    
    NSString *vertShaderPathname = [[NSBundle mainBundle] pathForResource:vertexShaderName ofType:@"glsl"];
    if (![self compileShader:&vertexShader type:GL_VERTEX_SHADER file:vertShaderPathname]){
        NSLog(@"Failed to compile vertex shader");
        return NO;
    }
    
    NSString *fragShaderPathname = [[NSBundle mainBundle] pathForResource:fragmentShaderName ofType:@"glsl"];
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname]){
        NSLog(@"Failed to compile fragment shader");
        return NO;
    }
    
    glAttachShader(*programPointer, vertexShader);
    glAttachShader(*programPointer, fragShader);
    
    glBindAttribLocation(*programPointer, ATTRIB_VERTEX, "position");
    glBindAttribLocation(*programPointer, ATTRIB_TEXTUREPOSITON, "inputTextureCoordinate");

    
    if (![self linkProgram:*programPointer]){
        NSLog(@"Failed to link program: %d", *programPointer);
        
        if (vertexShader){
            glDeleteShader(vertexShader);
            vertexShader = 0;
        }
        
        if (fragShader) {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        
        if (*programPointer){
            glDeleteProgram(*programPointer);
            *programPointer = 0;
        }
        
        return NO;
    }
    
    uniforms[UNIFORM_TEXTURE] = glGetUniformLocation(*programPointer, "textureFrame");
    uniforms[UNIFORM_COLOR] = glGetUniformLocation(*programPointer, "color");
    uniforms[UNIFORM_PROJECTION] = glGetUniformLocation(*programPointer, "projection");
    uniforms[UNIFORM_MODELVIEW] = glGetUniformLocation(*programPointer, "modelview");
    
    if (vertexShader) glDeleteShader(vertexShader);
    if (fragShader) glDeleteShader(fragShader);
    
    return YES;
}

- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file {
    GLint status;
    const GLchar *source;
    
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source){
        NSLog(@"Failed to load vertex shader");
        return NO;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0){
        glDeleteShader(*shader);
        return NO;
    }
    
    return YES;
}

- (BOOL)linkProgram:(GLuint)prog {
    GLint status;
    
    glLinkProgram(prog);
    
    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0) return NO;
    
    return YES;
}

- (BOOL)validateProgram:(GLuint)prog {
    GLint logLength, status;
    
    glValidateProgram(prog);
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
    
    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == 0){
        return NO;
    }
    
    return YES;
}

- (void)use {
    glUseProgram(_program);
}

@end
