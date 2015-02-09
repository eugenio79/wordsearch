//
//  WSGridChar.h
//  WordSearch
//
//  Created by Giuseppe Morana on 07/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSCommon.h"

/**
 * A letter in the grid
 */
@interface WSChar : NSObject

@property (nonatomic) char character;
@property (nonatomic) WSGridPosition gridPosition;
@property (nonatomic) BOOL marked;

+ (instancetype)charWithChar:(char)character withGridPosition:(WSGridPosition)gridPosition andMarked:(BOOL)marked;

@end
