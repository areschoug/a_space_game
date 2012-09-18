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

- (BOOL)loadVertexShader:(NSString *)vertexShaderName fragmentShader:(NSString *)fragmentShaderName forProgram:(GLuint *)programPointer{
    
    GLuint vertexShader, fragShader;
    
    // Create shader program.
    *programPointer = glCreateProgram();
    
    NSString *vertShaderPathname = [[NSBundle mainBundle] pathForResource:vertexShaderName ofType:@"glsl"];
    if (![self compileShader:&vertexShader type:GL_VERTEX_SHADER file:vertShaderPathname]){
        NSLog(@"Failed to compile vertex shader");
        return FALSE;
    }
    
    NSString *fragShaderPathname = [[NSBundle mainBundle] pathForResource:fragmentShaderName ofType:@"glsl"];
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname]){
        NSLog(@"Failed to compile fragment shader");
        return FALSE;
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
        
        return FALSE;
    }
    
    uniforms[UNIFORM_TEXTURE] = glGetUniformLocation(*programPointer, "textureFrame");
    
    if (vertexShader) glDeleteShader(vertexShader);
    if (fragShader) glDeleteShader(fragShader);
    
    return TRUE;
}

- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file {
    GLint status;
    const GLchar *source;
    
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source){
        NSLog(@"Failed to load vertex shader");
        return FALSE;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0){
        glDeleteShader(*shader);
        return FALSE;
    }
    
    return TRUE;
}

- (BOOL)linkProgram:(GLuint)prog {
    GLint status;
    
    glLinkProgram(prog);
    
    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0)
        return FALSE;
    
    return TRUE;
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
        return FALSE;
    }
    
    return TRUE;
}

- (id)initWithVertexShader:(NSString*)vertexShaderName fragmentShader:(NSString*)fragmentShaderName {
    self = [super init];
    if (self) {
        [self loadVertexShader:@"vertex" fragmentShader:@"fragment" forProgram:&_program];

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
