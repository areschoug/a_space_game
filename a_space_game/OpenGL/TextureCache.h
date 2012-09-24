//
//  TextureCache.h
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface TextureCache : NSObject

+ (TextureCache*) sharedTextureCache;

- (GLKTextureInfo*)addImage:(NSString*)fileName;
- (void)loadAll;

@end