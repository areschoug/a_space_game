//
//  ViewController.m
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import "MainView.h"
#import "Scene.h"

static MainView* _sharedDirector = nil;

@interface MainView ()

@property(nonatomic,strong) EAGLContext *context;
@property (strong, nonatomic) Scene *nextScene;
@property (strong, nonatomic) Scene *currentScene;

@end

@implementation MainView


@synthesize nextScene = _nextScene;
@synthesize currentScene = _currentScene;

- (void)pushScene:(Scene *)scene {
    self.nextScene = scene;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _sharedDirector = self;
}

+ (MainView*)sharedDirector {
	return _sharedDirector;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create context
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    if (!self.context) {
        NSLog(@"Failed to create ES context");
        exit(1);
    }
    
    if (![EAGLContext setCurrentContext:self.context]) {
        NSLog(@"Failed to set current OpenGL context");
        exit(1);
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    //view.drawableDepthFormat = GLKViewDrawableDepthFormat16;
    //view.drawableMultisample = GLKViewDrawableMultisample4X;
}

- (void)setNextScene
{
    self.currentScene = self.nextScene;
    self.nextScene = nil;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    if(_nextScene) [self setNextScene];
    
    [_currentScene visit];
}

- (void)update {
    //TODO:Update
    //int td = self.timeSinceLastUpdate;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Cleanup GL
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
