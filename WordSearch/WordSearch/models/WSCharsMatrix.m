//
//  WSCharsMatrix.m
//  WordSearch
//
//  Created by Giuseppe Morana on 07/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import "WSCharsMatrix.h"

@interface WSCharsMatrix() {
    NSArray *_matrix;
}
@end

@implementation WSCharsMatrix

+ (instancetype)matrixWithArrayOfStrings:(NSArray *)arrayOfStrings {
    return [[WSCharsMatrix alloc] initWithArrayOfStrings:arrayOfStrings];
}

- (instancetype)initWithArrayOfStrings:(NSArray *)arrayOfStrings {
    
    if (self = [super init]) {
        // param validity omitted for demo purpose
        
        NSMutableArray *matrix = [NSMutableArray new];
        
        for (NSUInteger rowIndex=0; rowIndex<arrayOfStrings.count; rowIndex++) {
            
            NSMutableArray *row = [NSMutableArray new];
            
            NSArray *charsStr = [arrayOfStrings[rowIndex] componentsSeparatedByString:@" "];
            for (NSUInteger columnIndex=0; columnIndex<charsStr.count; columnIndex++) {
                char c = [charsStr[columnIndex] characterAtIndex:0];
                WSGridPosition position = {rowIndex, columnIndex};
                WSChar *wsChar = [WSChar charWithChar:c withGridPosition:position andMarked:NO];
                [row addObject:wsChar];
            }
            
            [matrix addObject:row];
        }
        
        _matrix = matrix;
    }
    return self;
}

- (NSUInteger)size {
    return _matrix.count * _matrix.count;   // assumed it's always a square matrix for demo purpose
}

- (NSUInteger)rowsCount {
    return _matrix.count;
}

- (NSUInteger)columnsCount {
    return [_matrix[0] count];
}

- (WSChar *)charAtGridPosition:(WSGridPosition)gridPosition {
    return _matrix[gridPosition.row][gridPosition.column];
}

@end
