//
//  WSMarksFactory.m
//  GridViewExample
//
//  Created by Giuseppe Morana on 01/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import "WSMarksFactory.h"
#import "WSCommon.h"
#import "UIColor+WS.h"

@interface WSMarksFactory() {
    WSBrush _brush;
    CGSize _cellSize;
}

@end

@implementation WSMarksFactory

+ (instancetype)factoryWithCellSize:(CGSize)cellSize {
    return [[WSMarksFactory alloc] initWithCellSize:cellSize];
}

- (instancetype)initWithCellSize:(CGSize)cellSize
{
    if (self = [super init]) {
        _brush.opacity = 0.6f;
        _cellSize = cellSize;
        _brush.size = cellSize.width * 4 / 5;   // I'm assuming that width == height
    }
    return self;
}

- (WSMark *)createMarkWithColor:(UIColor *)color
{
    _brush.rgb = [color rgbColor];
    return [WSMark markWithBrush:_brush withCellSize:_cellSize];
}

@end
