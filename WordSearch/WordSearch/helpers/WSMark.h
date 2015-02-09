//
//  WSMark.h
//  GridViewExample
//
//  Created by Giuseppe Morana on 01/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WSCommon.h"

/**
 * It contains all info to draw a mark onto an overlay 
 */
@interface WSMark : NSObject

@property (nonatomic, readonly) WSBrush brush;
@property (nonatomic, readonly) CGSize cellSize;

@property (nonatomic) WSGridPosition startPosition;
@property (nonatomic) WSGridPosition endPosition;

/**
 * @YES if the mark needs to be redraw
 */
@property (nonatomic) BOOL needsLayout;

+ (instancetype)markWithBrush:(WSBrush)brush withCellSize:(CGSize)cellSize;

- (CGPoint)startPoint;
- (CGPoint)endPoint;


@end
