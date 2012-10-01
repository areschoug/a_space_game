//
//  ProgramManager.m
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLProgram.h"

@interface ProgramManager : NSObject

+ (ProgramManager*)sharedProgramManager;

- (GLProgram*)getDefaultProgram;
- (GLProgram*)getDefaultColorProgram;
@end
