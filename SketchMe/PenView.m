//
//  PenPreview.m
//  SketchMe
//
//  Created by CPD User on 19/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PenView.h"
#import "MyDataStore.h"

@implementation PenView

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
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetRGBStrokeColor (context,
                                [myDrawingModel colourValueForPath:0 forColour:RED],
                                [myDrawingModel colourValueForPath:0 forColour:GREEN],
                                [myDrawingModel colourValueForPath:0 forColour:BLUE],
                                [myDrawingModel colourValueForPath:0 forColour:ALPHA]);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 48, 802);
    CGContextAddLineToPoint(context, 50, 800);
    CGContextStrokePath(context);
    [self resetRectView];
}

- (void)resetRectView{
    CGRect bounds = [self bounds];
    [[UIColor blackColor] set];
    UIRectFrame(bounds);
}

@end
