//
//  MySketchView.m
//  SketchMe
//
//  Created by CPD User on 19/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MySketchView.h"
#import "MyDataStore.h"

@implementation MySketchView

@synthesize myDrawingModel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    int pathCount, pointsCount;
    CGPoint myPoint;
    int i, j;
    float pathLineWidth;
    
    // Get the current graphic context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Save the current context status
    CGContextSaveGState(context);
    
    if((pathCount = [myDrawingModel pathsInStore]))
        for (i=0; i < pathCount; i++) {
            // Will need to set up the context regarding each path
            if ((pathLineWidth = [myDrawingModel lineWidthForPath:i]) > 1)
                CGContextSetLineWidth(context, pathLineWidth);
            else
                CGContextSetLineWidth(context, 1.0);
            CGContextSetLineCap (context, kCGLineCapRound);
            CGContextSetLineJoin (context, kCGLineJoinRound);
            
            CGContextSetRGBStrokeColor (context,
                                        [myDrawingModel colourValueForPath:i forColour:RED],
                                        [myDrawingModel colourValueForPath:i forColour:GREEN],
                                        [myDrawingModel colourValueForPath:i forColour:BLUE],
                                        [myDrawingModel colourValueForPath:i forColour:ALPHA]);
            
            CGContextBeginPath(context);
            myPoint = [myDrawingModel pointForPath:i atIndex:0]; 
            CGContextMoveToPoint(context, myPoint.x, myPoint.y);
            
            pointsCount = [myDrawingModel pointsInPath:i];
            for (j=1; j<pointsCount; j++) {
                myPoint = [myDrawingModel pointForPath:i atIndex:j]; 
                CGContextAddLineToPoint(context, myPoint.x, myPoint.y);
            }
            // Draw the path out
            CGContextStrokePath(context);
        }
    
    // Restore to previous context status
    CGContextRestoreGState(context);
    // Redraw the boundary of the subview
    [self resetRectView];
}

- (void)resetRectView{
    CGRect bounds = [self bounds];
    [[UIColor blackColor] set];
    UIRectFrame(bounds);
}

@end
