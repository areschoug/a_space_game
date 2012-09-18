//
//  ViewController.m
//  a_space_game
//
//  Created by Andreas Areschoug on 2012-09-18.
//  Copyright (c) 2012 Andreas Areschoug. All rights reserved.
//

#import "ViewController.h"
#import "Scene.h"

static ViewController* _sharedDirector = nil;

@interface ViewController ()

@property(nonatomic,strong) EAGLContext *context;
@property (strong, nonatomic) Scene *nextScene;
@property (strong, nonatomic) Scene *currentScene;

@end

@implementation ViewController


@synthesize nextScene = _nextScene;
@synthesize currentScene = _currentScene;

- (void)pushScene:(Scene *)scene {
    self.nextScene = scene;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _sharedDirector = self;
}

+ (ViewController*)sharedDirector {
	return _sharedDirector;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create context
    _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    if (!_context) {
        NSLog(@"Failed to create ES context");
        exit(1);
    }
    
    if (![EAGLContext setCurrentContext:_context])
    {
        NSLog(@"Failed to set current OpenGL context");
        exit(1);
    }
    
    // Initialize view
    GLKView *view = (GLKView *)self.view;
    view.context = _context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat16;
    view.drawableMultisample = GLKViewDrawableMultisample4X;
    
}

- (void)setNextScene {
//    self.currentScene = self.nextScene;
//    self.nextScene = nil;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    NSLog(@"GLKVIEW");
//    if(self.nextScene)
//		[self setNextScene];
//    
//    [self.currentScene visit];
}

- (void)update {
    NSLog(@"UPDATE");
//    int td = self.timeSinceLastUpdate;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Cleanup GL
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
