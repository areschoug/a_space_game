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

- (id)initWithVertexShader:(NSString*)vertexShaderName fragmentShader:(NSString*)fragmentShaderName {
    self = [super init];
    if (self) {
        // Compile both shaders
        GLuint vertexShader = [self compileShader:vertexShaderName withType:GL_VERTEX_SHADER];
        GLuint fragmentShader = [self compileShader:fragmentShaderName withType:GL_FRAGMENT_SHADER];
        
        // Create the program in openGL, attach the shaders and link them
        GLuint programHandle = glCreateProgram();
        glAttachShader(programHandle, vertexShader);
        glAttachShader(programHandle, fragmentShader);
        glLinkProgram(programHandle);
        
        // Get the error message in case the linking has failed
        GLint linkSuccess;
        glGetProgramiv(programHandle, GL_LINK_STATUS, &linkSuccess);
        if (linkSuccess == GL_FALSE) {
            GLint logLength;
            glGetProgramiv(programHandle, GL_INFO_LOG_LENGTH, &logLength);
            if(logLength > 0) {
                GLchar *log = (GLchar *)malloc(logLength);
                glGetProgramInfoLog(programHandle, logLength, &logLength, log);
                NSLog(@"Program link log:\n%s", log);
                free(log);
            }
            exit(1);
        }
        
        _program =  programHandle;
    }
    return self;
}

- (void)use {
    glUseProgram(_program);
}

//+ (UniformInfo)getUniforms:(GLuint)program
//{
//    GLint maxUniformLength;
//    GLint numberOfUniforms;
//    char *uniformName;
//    UniformInfo uniformArray;
//    
//    // Get the number of uniforms and the max length of their names
//    glGetProgramiv(program, GL_ACTIVE_UNIFORMS, &numberOfUniforms);
//    glGetProgramiv(program, GL_ACTIVE_UNIFORM_MAX_LENGTH, &maxUniformLength);
//    
//    uniformArray.Uniform = malloc(numberOfUniforms * sizeof(Uniform));
//    uniformArray.NumberOfUniforms = numberOfUniforms;
//    
//    for(int i = 0; i < numberOfUniforms; i++)
//    {
//        GLint size;
//        GLenum type;
//        GLint location;
//        // Get the Uniform Info
//        uniformName = malloc(sizeof(char) * maxUniformLength);
//        glGetActiveUniform(program, i, maxUniformLength, NULL, &size, &type, uniformName);
//        uniformArray.Uniform[i].Name = uniformName;
//        // Get the uniform location
//        location = glGetUniformLocation(program, uniformName);
//        uniformArray.Uniform[i].Location = location;
//    }
//    
//    return uniformArray;
//}

@end
