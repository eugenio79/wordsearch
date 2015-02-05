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
    NSArray *_colorsPalette;
    NSUInteger _currentColorIndex;
}

@end

@implementation WSMarksFactory

+ (instancetype)factoryWithCellSize:(CGSize)cellSize andColorsPalette:(NSArray *)colorsPalette {
    return [[WSMarksFactory alloc] initWithCellSize:cellSize andColorsPalette:colorsPalette];
}

- (instancetype)initWithCellSize:(CGSize)cellSize andColorsPalette:(NSArray *)colorsPalette
{
    if (self = [super init]) {
        _colorsPalette = colorsPalette;
        _currentColorIndex = colorsPalette.count;
        _brush.opacity = 0.6f;
        _cellSize = cellSize;
        _brush.size = cellSize.width - (cellSize.width / 10);   // I'm assuming that width == height
    }
    return self;
}

- (WSMark *)createMark {
    _brush.rgb = [self nextColor];
    return [WSMark markWithBrush:_brush withCellSize:_cellSize];
}

- (rgbColor)nextColor {
    _currentColorIndex++;
    if (_currentColorIndex >= _colorsPalette.count)
        _currentColorIndex = 0;
    return [_colorsPalette[_currentColorIndex] rgbColor];
}

@end
