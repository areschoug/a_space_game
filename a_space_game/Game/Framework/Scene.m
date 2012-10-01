//
//  Scene.h
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import "Scene.h"
#import "Sprite.h"

@implementation Scene

-(void)update:(double)td{

}

-(void)clean{

    for (Entity *entity in self.children) {
        if ([entity isKindOfClass:[Sprite class]]) {
            
            Sprite *sprite = (Sprite *)entity;
            if (sprite.shouldBeRemoved){

                sprite = nil;
//                sprite.velocity = CGPointMake(0, 0);


            }
        }
    }
}

@end
