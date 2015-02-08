//
//  WSCommon.m
//  GridViewExample
//
//  Created by Giuseppe Morana on 01/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import "WSCommon.h"

BOOL areEqualsPosition(WSGridPosition firstPosition, WSGridPosition secondPosition) {
    return (firstPosition.column == secondPosition.column) && (firstPosition.row == secondPosition.row);
}

BOOL areEqualsSizes(CGSize firstSize, CGSize secondSize) {
    return (firstSize.height == secondSize.height) && (firstSize.width == secondSize.width);
}

WSGridPosition WSMakeGridPosition(NSUInteger row, NSUInteger column) {
    WSGridPosition position;
    position.row = row;
    position.column = column;
    return position;
}

NSString *NSStringFromPosition(WSGridPosition position) {
    return [NSString stringWithFormat:@"(%u, %u)", (unsigned)position.row, (unsigned)position.column];
}