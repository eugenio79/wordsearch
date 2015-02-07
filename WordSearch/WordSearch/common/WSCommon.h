//
//  WSCommon.h
//  GridViewExample
//
//  Created by Giuseppe Morana on 01/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
    NSUInteger row;
    NSUInteger column;
} WSGridPosition;

typedef struct {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
} rgbColor;

typedef struct {
    CGFloat size;
    CGFloat opacity;
    rgbColor rgb;
} WSBrush;

BOOL areEqualsPosition(WSGridPosition firstPosition, WSGridPosition secondPosition);

WSGridPosition WSMakeGridPosition(NSUInteger row, NSUInteger column);

NSString *NSStringFromPosition(WSGridPosition position);

#define WSGridPositionNotFound WSMakeGridPosition(NSUIntegerMax, NSUIntegerMax)
