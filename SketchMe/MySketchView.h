//
//  MySketchView.h
//  SketchMe
//
//  Created by CPD User on 19/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyDataStore;

@interface MySketchView : UIView{
    MyDataStore *myDrawingModel;
}

@property (nonatomic, retain) MyDataStore *myDrawingModel;

- (void)resetRectView;

@end
