//
//  MyDataStore.m
//  COMP327
//
//  Created by Terry Payne on 04/01/2011.
//  Copyright 2011 University of Liverpool. All rights reserved.
//

#import "MyDataStore.h"


@implementation MyDataStore


/*To store CGPoint in NSArray:
 ------------------------------------
 
 NSArray *points = [NSArray arrayWithObjects:
 [NSValue valueWithCGPoint:CGPointMake(5.5, 8.3)],
 [NSValue valueWithCGPoint:CGPointMake(11.9, 8.5)],
 nil];
 
 To retrieve CGPoint from array:
 -----------------------------------
 From array to cgPoint variable.
 
 NSValue *val = [points objectAtIndex:0];
 CGPoint p = [val CGPointValue];
 */


// Initialize the the data store
- (id)init{
	self = [super init];
	if (self) {
        // Custom initialization
		pathArray = [[NSMutableArray alloc] init];
    }
    return self;
}

//Declaration of the user defined method
- (void)addStartPoint:(CGPoint)startPoint withLineWidth:(float)lineWidth
		 withRedValue:(float)redValue
	   withGreenValue:(float)greenValue
		withBlueValue:(float)blueValue
	   withAlphaValue:(float)alphaValue {

	// Create a new element in the pathArray
	// This is a dictionary, with elements for the
	// context, as well as an array of points
	NSMutableArray *pointsArray = [NSMutableArray arrayWithObject:[NSValue valueWithCGPoint:startPoint]];
	
	// Once we have all the elements for the dictionary, create
	// the dictionary with these elements
	NSDictionary *pathDict = [NSDictionary dictionaryWithObjectsAndKeys:pointsArray, POINTS,
							  [NSNumber numberWithFloat:lineWidth], WIDTH,
							  [NSNumber numberWithFloat:redValue], RED,
							  [NSNumber numberWithFloat:greenValue], GREEN,
							  [NSNumber numberWithFloat:blueValue], BLUE,
							  [NSNumber numberWithFloat:alphaValue], ALPHA,
							  nil];
	
	// Now add the dictionary to the array of paths
	[pathArray addObject:pathDict];
	
	// Do any cleaning up (if necessary)
	// NEED TO VERIFY THAT THE pointsArray IS RETAINED BY THE DICTIONARY
	//[pointsArray release];	
}

- (void)addMovePoint:(CGPoint)nextPoint {
	
	NSMutableArray *currentPath = [[pathArray lastObject] objectForKey:POINTS];
	if (currentPath)
		[currentPath addObject:[NSValue valueWithCGPoint:nextPoint]];

}

- (int) pathsInStore {
	return [pathArray count];
}

- (NSArray *) pointArrayForPath:(int)pathIndex {
	if (pathIndex < [pathArray count])
		return [[pathArray objectAtIndex:pathIndex] objectForKey:POINTS];
	return NULL;
}

- (CGPoint) pointForPath:(int)pathIndex atIndex:(int)pointIndex {
	CGPoint p = {0,0};
	
	if (pathIndex < [pathArray count]) {
		NSMutableArray *pointsArray = [[pathArray objectAtIndex:pathIndex] objectForKey:POINTS];
		if (pointIndex < [pointsArray count]) {
			NSValue *val = [pointsArray objectAtIndex:pointIndex];
			p = [val CGPointValue];
		}
	}
	return p;	
}

- (int) pointsInPath:(int)pathIndex {
	if (pathIndex < [pathArray count]) {
		NSMutableArray *currentPath = [[pathArray objectAtIndex:pathIndex] objectForKey:POINTS];

		if (currentPath)
			return [currentPath count];
	}
	return 0;
}

- (float) lineWidthForPath:(int)pathIndex {
	if (pathIndex < [pathArray count]) {
		NSNumber *lineWidth = [[pathArray objectAtIndex:pathIndex] objectForKey:WIDTH];
		
		if (lineWidth)
			return [lineWidth floatValue];
	}
	return 0.0;
}

- (float) colourValueForPath:(int)pathIndex forColour:(NSString *)colourStr {
	if (pathIndex < [pathArray count]) {
		NSNumber *value = [[pathArray objectAtIndex:pathIndex] objectForKey:colourStr];		
		if (value)
			return [value floatValue];
	}
	return 0.0;
}


- (signed int) pointsInCurrentPath {
	NSMutableArray *currentPath = [[pathArray lastObject] objectForKey:POINTS];
	if (currentPath)
		return [currentPath count];
	else
		return 0;
}

- (void)clearLastPath {
	// delete the last object.
	// Need to check if this also removes objects owned by last object?
	[pathArray removeLastObject];
}

- (void)clearAll {
	// delete all objects.
	// Need to check if this also removes objects owned by last object?
	[pathArray removeAllObjects];
}

@end
