//
//  ViewController.m
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import "MainView.h"
#import "Scene.h"
#import "IntroScene.h"
#import "TextureCache.h"

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
    [EAGLContext setCurrentContext:self.context];
    [self setPreferredFramesPerSecond:60.0];
    
    view.drawableDepthFormat = GLKViewDrawableDepthFormat16;
    view.drawableMultisample = GLKViewDrawableMultisample4X;
    
    [[TextureCache sharedTextureCache] loadAll];
    
    [self pushScene:[IntroScene build]];
    
}

- (void)setNextScene {
    self.currentScene = self.nextScene;
    self.nextScene = nil;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
        
    glClearColor(0.071, 0.008, 0.098, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_BLEND);
    
    if(_nextScene) [self setNextScene];
    [_currentScene visit];
    
    
}

- (void)update {
    //TODO:Update

    [_currentScene update:self.timeSinceLastUpdate];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Cleanup GL
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
