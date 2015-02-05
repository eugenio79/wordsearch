//
//  WSMarksFactory.h
//  GridViewExample
//
//  Created by Giuseppe Morana on 01/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSMark.h"

@interface WSMarksFactory : NSObject

/**
 * @param colorsPalette A list of colors to use to draw the marks
 */
+ (instancetype)factoryWithCellSize:(CGSize)cellSize
                   andColorsPalette:(NSArray *)colorsPalette;

- (WSMark *)createMark;

@end
