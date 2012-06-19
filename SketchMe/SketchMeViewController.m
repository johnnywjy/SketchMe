//
//  SketchMeViewController.m
//  SketchMe
//
//  Created by CPD User on 19/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SketchMeViewController.h"
#import "MyDataStore.h"

@implementation SketchMeViewController

@synthesize statusLabel;
@synthesize sketchView;
@synthesize myDrawingModel;
@synthesize redSlider;
@synthesize greenSlider;
@synthesize blueSlider;
@synthesize alphaSlider;
@synthesize lineWidthSlider;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [redSlider setValue:(redValue = 0.5) animated:YES];
    [greenSlider setValue:(greenValue = 0.5) animated:YES];
    [blueSlider setValue:(blueValue = 0.5) animated:YES];
    [alphaSlider setValue:(alphaValue = 0.5) animated:YES];
    [lineWidthSlider setValue:(lineWidthValue = 10.0) animated:YES];
    if (!myDrawingModel) {
        myDrawingModel = [[MyDataStore alloc] init];
    }
    [sketchView setMyDrawingModel:myDrawingModel];
     
    //[penView setNeedsDisplay];
    
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
    //[super viewDidAppear:animated];
    [self becomeFirstResponder];
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

- (void)dealloc
{
    [myDrawingModel release];
    [super dealloc];
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
        
        [myDrawingModel addStartPoint:touchPoint
                        withLineWidth:lineWidthValue
                         withRedValue:redValue
                       withGreenValue:greenValue
                        withBlueValue:blueValue
                       withAlphaValue:alphaValue];
        [sketchView setNeedsDisplay];
        // As we are using a class factory here, we don't have to worry about
        // managing the memory - it has already been autoreleased!
        NSString *statusMsg = [NSString
                               stringWithFormat:@"Touch Move at %.0f, %.0f, having added %d points",
                               touchPoint.x, touchPoint.y, [myDrawingModel pointsInCurrentPath]];
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
        
        [myDrawingModel addMovePoint:touchPoint];
        [sketchView setNeedsDisplay];
        
        float px = touchPoint.x > 0?touchPoint.x < 728?touchPoint.x:728:0;
        float py = touchPoint.y > 0?touchPoint.y < 728?touchPoint.y:728:0;
        NSString *statusMsg = [NSString
                               stringWithFormat:@"Touch Move at %.0f, %.0f, having added %d points",
                               px, py, [myDrawingModel pointsInCurrentPath]];
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

// ========================================
#pragma mark - Motion Events
// ========================================


- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    // An empty implementation to avoid the event
    // going up the responder hierarchy
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    // Handle the shake
    
    // =============================================
    // Initially add some message to appear in the status
    // label to announce a shake event.
    // Later - delete a line segment.
    // This is something that still needs to be done    
    // =============================================
    if ([myDrawingModel pathsInStore] > 0) {
        [myDrawingModel clearLastPath];
        [statusLabel setText:[NSString stringWithFormat:@"%d paths remaining", [myDrawingModel pathsInStore]]];
        [sketchView setNeedsDisplay];
    }else{
        [statusLabel setText:@"no path to be deleted."];
    
    }
    
    
}

- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    // An empty implementation to avoid the event
    // going up the responder hierarchy
}

// ========================================

// Allow the view controller to become the first responder
// so that it can handle motion events.

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (IBAction)clearScreenButtonPressed
{
    if ([myDrawingModel pathsInStore] > 0) {
        [myDrawingModel clearAll];
        [sketchView setNeedsDisplay];
    } else
        [statusLabel setText:[NSString stringWithFormat:@"There is no image to delete!"]];
}

- (IBAction)sliderValueChanged:(id)sender
{
    UISlider *slider = (UISlider *)sender;  // Cast sender into a UISlider
    // so "value" calls the UISlider method
    

    if (slider == redSlider)
        redValue = [slider value];
    if (slider == greenSlider)
        greenValue = [slider value];
    if (slider == blueSlider)
        blueValue = [slider value];
    if (slider == alphaSlider)
        alphaValue = [slider value];
    if (slider == lineWidthSlider)
        lineWidthValue = [slider value];
    [penView setNeedsDisplay];
}

- (IBAction)resetPen
{
    [redSlider setValue:(redValue = 0.5) animated:YES];
    [greenSlider setValue:(greenValue = 0.5) animated:YES];
    [blueSlider setValue:(blueValue = 0.5) animated:YES];
    [alphaSlider setValue:(alphaValue = 0.5) animated:YES];
    [lineWidthSlider setValue:(lineWidthValue = 10.0) animated:YES];
}


@end
