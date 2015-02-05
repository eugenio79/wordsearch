//
//  UIColor+WS.h
//  GridViewExample
//
//  Created by Giuseppe Morana on 02/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSCommon.h"

@interface UIColor (WS)

/**
 * Assumes input like "#00FF00" (#RRGGBB)
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

/**
 * @return An rgb representation of the color; each component can have a value in the range [0, 1]
 */
- (rgbColor)rgbColor;

@end
