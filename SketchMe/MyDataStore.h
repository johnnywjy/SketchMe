//
//  MyDataStore.h
//  COMP327
//
//  Created by Terry Payne on 04/01/2011.
//  Copyright 2011 University of Liverpool. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RED @"redValue"
#define GREEN @"greenValue"
#define BLUE @"blueValue"
#define ALPHA @"alphaValue"
#define POINTS @"points"
#define WIDTH @"lineWidth"


@interface MyDataStore : NSObject {

	// Store should be an array of items, each of which correspond to a path
	// A path should consist of a dictionary, which contains:
	//   stroke points - an array of points
	//   linewidth - the width of the line
	//   colour - the colour of the line
	//   alpha - the alpha setting for the line
		
	NSMutableArray *pathArray;
}

//Declaration of the user defined method
- (void)addStartPoint:(CGPoint)startPoint withLineWidth:(float)lineWidth
		 withRedValue:(float)redValue
	   withGreenValue:(float)greenValue
		withBlueValue:(float)blueValue
	   withAlphaValue:(float)alphaValue;

- (void)addMovePoint:(CGPoint)nextPoint;

- (int) pathsInStore;
- (NSArray *) pointArrayForPath:(int)pathIndex;
- (CGPoint) pointForPath:(int)pathIndex atIndex:(int)pointIndex;
- (int) pointsInPath:(int)pathIndex;
- (float) lineWidthForPath:(int)pathIndex;
- (float) colourValueForPath:(int)pathIndex forColour:(NSString *)colourStr;
- (int) pointsInCurrentPath;
- (void)clearLastPath;
- (void)clearAll;


@end
