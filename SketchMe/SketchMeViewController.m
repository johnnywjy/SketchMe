//
//  SketchMeViewController.m
//  SketchMe
//
//  Created by CPD User on 19/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SketchMeViewController.h"

@implementation SketchMeViewController

@synthesize statusLabel;
@synthesize sketchView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSString *statusMsg = [NSString stringWithString:@"App init"];
    [statusLabel setText:statusMsg];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

// ========================================
#pragma mark - Touch Events
// ========================================

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // We only support single touches, so anyObject retrieves just that touch from touches
    UITouch *touch = [touches anyObject];
    MySketchView *myView = [self sketchView];
    
    if ([touch view] == myView) {
        // touches occured in this view only
        CGPoint touchPoint = [touch locationInView:myView];
        
        // As we are using a class factory here, we don't have to worry about
        // managing the memory - it has already been autoreleased!
        NSString *statusMsg = [NSString stringWithFormat:@"Touch Began at %.0f, %.0f",
                               touchPoint.x, touchPoint.y];
        [statusLabel setText:statusMsg];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // We only support single touches, so anyObject retrieves just that touch from touches
    UITouch *touch = [touches anyObject];
    MySketchView *myView = [self sketchView];
    
    if ([touch view] == myView) {
        // Several things worth noting here.  [touch view] returns the view in which
        // the touch *began*, and *not* the view the touch is currently in!  So
        // we still check this, in case the touch started outside the view!
        
        // We also don't check whether or not the touch goes outside the bounds
        // of the view.  This check is trivial - in the view class we get the view
        // bounds to paint this boundry.  We can do something similar here on that
        // view to check whether the touch has left the view.
        
        CGPoint touchPoint = [touch locationInView:myView];
        
        NSString *statusMsg = [NSString stringWithFormat:@"Touch Move at %.0f, %.0f",
                               touchPoint.x, touchPoint.y];
        [statusLabel setText:statusMsg];
    }
}

// touchesEnded and touchesCancelled are handled here to ensue consistency
// in managing touch events.  Even if we don't care about them, we should
// implement empty methods to prevent the event propagating up the responder
// chain.

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSString *statusMsg = [NSString stringWithString:@"Touch Ended"];
    [statusLabel setText:statusMsg];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSString *statusMsg = [NSString stringWithString:@"Touch Cancelled"];
    [statusLabel setText:statusMsg];
}

@end
