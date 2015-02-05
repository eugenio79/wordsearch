//
//  WSMark.m
//  GridViewExample
//
//  Created by Giuseppe Morana on 01/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import "WSMark.h"

@interface WSMark()
@property (nonatomic) WSBrush brush;
@property (nonatomic) CGSize cellSize;
@end

@implementation WSMark

+ (instancetype)markWithBrush:(WSBrush)brush withCellSize:(CGSize)cellSize {
    return [[WSMark alloc] initWithBrush:brush withCellSize:cellSize];
}

- (instancetype)initWithBrush:(WSBrush)brush withCellSize:(CGSize)cellSize {
    if (self = [super init]) {
        self.brush = brush;
        self.cellSize = cellSize;
    }
    return self;
}

- (void)setEndPosition:(WSGridPosition)endPosition {
    _endPosition = endPosition;
    if ([self isHorizontal] || [self isVertical] || [self isDiagonal])
        self.needsLayout = YES;
}

- (BOOL)isHorizontal {
    return self.startPosition.column == self.endPosition.column;
}

- (BOOL)isVertical {
    return self.startPosition.row == self.endPosition.row;
}

- (BOOL)isDiagonal {
    return abs((int)self.startPosition.row - (int)self.endPosition.row) == abs((int)self.startPosition.column - (int)self.endPosition.column);
}

- (CGPoint)startPoint {
    return [self pointForPosition:self.startPosition];
}

- (CGPoint)endPoint {
    return [self pointForPosition:self.endPosition];
}

- (CGPoint)pointForPosition:(WSGridPosition)position {
    
    CGPoint point;
    
    point.x = position.column * self.cellSize.width + self.cellSize.width / 2;
    point.y = position.row * self.cellSize.height + self.cellSize.height / 2;
    
    return point;
}

@end
