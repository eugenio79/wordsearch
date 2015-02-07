//
//  WSGridChar.m
//  WordSearch
//
//  Created by Giuseppe Morana on 07/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import "WSChar.h"

@implementation WSChar

+ (instancetype)charWithChar:(char)character withGridPosition:(WSGridPosition)gridPosition andMarked:(BOOL)marked {
    WSChar *wsChar = [[WSChar alloc] init];
    wsChar.character = character;
    wsChar.gridPosition = gridPosition;
    wsChar.marked = marked;
    return wsChar;
}

@end
