//
//  WSWord.m
//  GridViewExample
//
//  Created by Giuseppe Morana on 03/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import "WSWord.h"

@interface WSWord()

@property (nonatomic, strong) NSString *text;
@property (nonatomic) WSGridPosition startPosition;
@property (nonatomic) WSGridPosition endPosition;
@property (nonatomic) BOOL crossedOut;

@end

@implementation WSWord

+ (instancetype)wordWithText:(NSString *)text
           withStartPosition:(WSGridPosition)startPosition
             withEndPosition:(WSGridPosition)endPosition
{
    return [[WSWord alloc] initWithText:text withStartPosition:startPosition withEndPosition:endPosition];
}

- (instancetype)initWithText:(NSString *)text
           withStartPosition:(WSGridPosition)startPosition
             withEndPosition:(WSGridPosition)endPosition
{
    if (self = [super init]) {
        _text = [text copy];
        _startPosition = startPosition;
        _endPosition = endPosition;
        _crossedOut = NO;
    }
    return self;
}

- (WSGridPosition)gridPositionForCharAtIndex:(NSUInteger)charIndex {
    if (charIndex >= self.text.length)
        return WSGridPositionNotFound;
    
    WSGridPosition position;
    
    if (self.startPosition.row < self.endPosition.row)
        position.row = self.startPosition.row + charIndex;
    else if (self.startPosition.row > self.endPosition.row)
        position.row = self.startPosition.row - charIndex;
    else
        position.row = self.startPosition.row;
    
    if (self.startPosition.column < self.endPosition.column)
        position.column = self.startPosition.column + charIndex;
    else if (self.startPosition.column > self.endPosition.column)
        position.column = self.startPosition.column - charIndex;
    else
        position.column = self.startPosition.column;
    
    return position;
}

- (BOOL)isCrossedOut {
    return _crossedOut;
}

- (BOOL)crossOut {
    if (_crossedOut)
        return NO;
    else {
        _crossedOut = YES;
        return YES;
    }
}

@end
