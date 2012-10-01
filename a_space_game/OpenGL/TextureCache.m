//
//  TextureCache.m
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import "TextureCache.h"
#import "Config.h"

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
		self.textures = [[NSMutableDictionary alloc] init];

    }
    return self;
}

- (GLKTextureInfo*)addImage:(NSString *)fileName {
    GLKTextureInfo *textureInfo = [self.textures objectForKey:fileName];
    if(!textureInfo) {
        
        NSError *error;
        NSDictionary *options = @{ GLKTextureLoaderOriginBottomLeft : @(YES) };
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
        
        textureInfo = [GLKTextureLoader textureWithContentsOfFile:filePath options:options error:&error];
        
        if(error) {
            NSLog(@"\nERRPR LOADING TEXTURE FROM IMAGE:\n\nNAME:%@\n\nPATH:%@\n\nERROR:%@",fileName,filePath,error);
            return nil;
        }
    
        [self.textures setObject:textureInfo forKey:fileName];
        
    }
    return textureInfo;
}

- (void)loadAll{

    for (int i = 0; i < kGameDecorationNumberOf; i++) {
        [self addImage:[NSString stringWithFormat:@"decoration_test_%i",i]];
    }
}

@end
