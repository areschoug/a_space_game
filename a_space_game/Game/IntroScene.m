#import "IntroScene.h"
#import "Sprite.h"


@implementation IntroScene

- (id)init
{
    self = [super init];
    if(self)
    {
        Sprite* sprite = [[Sprite alloc] init];
        [self addChild:sprite];
    }
    return self;
}

@end
