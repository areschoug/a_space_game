//
//  TextureCache.m
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import "TextureCache.h"

static TextureCache *_sharedTextureCache;

@interface TextureCache()
@property (strong, nonatomic) NSMutableDictionary *textures;
@end

@implementation TextureCache
@synthesize textures = _textures;

+ (TextureCache*)sharedTextureCache {
	if (!_sharedTextureCache)
		_sharedTextureCache = [[self alloc] init];
    
	return _sharedTextureCache;
}

- (id)init {
    self=[super init];
	if(self) {
		self.textures = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return self;
}

- (GLKTextureInfo*)addImage:(NSString *)fileName {
    GLKTextureInfo *textureInfo = [self.textures objectForKey:fileName];
    if(!textureInfo) {
        NSError *error;
        NSString* filePath;
        filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
        textureInfo = [GLKTextureLoader textureWithContentsOfFile:filePath options:nil error:&error];
        if(error) {
            NSLog(@"Error loading texture from image: %@", error);
        }
    }
    return textureInfo;
}

@end
