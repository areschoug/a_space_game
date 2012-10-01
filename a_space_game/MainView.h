//
//  ViewController.h
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "Scene.h"

@interface MainView : GLKViewController

- (void)pushScene:(Scene *)scene;
+ (MainView*)sharedDirector;
- (IBAction)buttonPushed:(id)sender;

@end
