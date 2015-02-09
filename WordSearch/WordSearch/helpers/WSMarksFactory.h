//
//  WSMarksFactory.h
//  GridViewExample
//
//  Created by Giuseppe Morana on 01/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSMark.h"

/**
 * Creates the marks
 */
@interface WSMarksFactory : NSObject

+ (instancetype)factoryWithCellSize:(CGSize)cellSize;

- (WSMark *)createMarkWithColor:(UIColor *)color;

@end
