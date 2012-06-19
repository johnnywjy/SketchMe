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
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self resetRectView];
}

- (void)resetRectView{
    CGRect bounds = [self bounds];
    [[UIColor blackColor] set];
    UIRectFrame(bounds);
}

@end
