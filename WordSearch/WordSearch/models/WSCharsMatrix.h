//
//  WSCharsMatrix.h
//  WordSearch
//
//  Created by Giuseppe Morana on 07/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSChar.h"

/**
 * The data structure behind the grid view
 */
@interface WSCharsMatrix : NSObject

+ (instancetype)matrixWithArrayOfStrings:(NSArray *)arrayOfStrings;

/**
 * @return Number of elements of the grid
 */
- (NSUInteger)size;

- (NSUInteger)rowsCount;
- (NSUInteger)columnsCount;

- (WSChar *)charAtGridPosition:(WSGridPosition)gridPosition;


@end
