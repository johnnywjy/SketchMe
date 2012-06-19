//
//  SketchMeViewController.h
//  SketchMe
//
//  Created by CPD User on 19/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MySketchView.h"
@class MyDataStore;

@interface SketchMeViewController : UIViewController{
    UILabel * statusLabel;
    MySketchView *sketchView;
    MyDataStore *myDrawingModel;
}

@property (nonatomic, retain) IBOutlet UILabel *statusLabel;
@property (nonatomic, retain) IBOutlet MySketchView *sketchView;
@property (nonatomic, retain) MyDataStore *myDrawingModel;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
- (IBAction)clearScreenButtonPressed;

@end
