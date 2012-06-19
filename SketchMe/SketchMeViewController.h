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
    float redValue;
    float greenValue;
    float blueValue;
    float alphaValue;
    float lineWidthValue;
    UISlider *redSlider;
    UISlider *greenSlider;
    UISlider *blueSlider;
    UISlider *alphaSlider;
    UISlider *lineWidthSlider;
}

@property (nonatomic, retain) IBOutlet UILabel *statusLabel;
@property (nonatomic, retain) IBOutlet MySketchView *sketchView;
@property (nonatomic, retain) MyDataStore *myDrawingModel;
@property (nonatomic, retain) IBOutlet UISlider *redSlider;
@property (nonatomic, retain) IBOutlet UISlider *greenSlider;
@property (nonatomic, retain) IBOutlet UISlider *blueSlider;
@property (nonatomic, retain) IBOutlet UISlider *alphaSlider;
@property (nonatomic, retain) IBOutlet UISlider *lineWidthSlider;


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
- (IBAction)clearScreenButtonPressed;
- (IBAction)sliderValueChanged:(id)sender;

@end
