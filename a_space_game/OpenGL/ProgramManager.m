//
//  ProgramManager.m
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import "ProgramManager.h"

#define VERTEX_SHADER @"vertex"
#define FRAGMENT_SHADER @"fragment"

#define COLOR_VERTEX_SHADER @"color_vertex"
#define COLOR_FRAGMENT_SHADER @"color_fragment"

static ProgramManager* _sharedProgramManager = nil;

@interface ProgramManager()
@property (strong, nonatomic) GLProgram *defaultProgram;
@property (strong, nonatomic) GLProgram *defaultColorProgram;
@end

@implementation ProgramManager
@synthesize defaultProgram = _defaultProgram;

+ (ProgramManager*)sharedProgramManager {
    if (!_sharedProgramManager) _sharedProgramManager = [[ProgramManager alloc] init];
    
	return _sharedProgramManager;
}

- (GLProgram*)getDefaultProgram {
    if (self.defaultProgram) return self.defaultProgram;
    return nil;
}

- (GLProgram*)getDefaultColorProgram {
    if (self.defaultColorProgram) return self.defaultColorProgram;
    NSLog(@"NO COLOR");
    return nil;
}

- (void)loadDefaultProgram {
    self.defaultProgram = [[GLProgram alloc] initWithVertexShader:VERTEX_SHADER fragmentShader:FRAGMENT_SHADER];
}

- (void)loadDefaultColorProgram {
    self.defaultColorProgram = [[GLProgram alloc] initWithVertexShader:COLOR_VERTEX_SHADER fragmentShader:COLOR_FRAGMENT_SHADER];
}

-(id) init {
    self = [super init];
	if(self) {
		[self loadDefaultProgram];
        [self loadDefaultColorProgram];
	}
	return self;
}

@end
