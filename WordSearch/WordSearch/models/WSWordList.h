//
//  WSWordList.h
//  GridViewExample
//
//  Created by Giuseppe Morana on 03/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSWord.h"

@interface WSWordList : NSObject

+ (instancetype)list;

- (BOOL)addWord:(WSWord *)word;

- (WSWord *)wordWithText:(NSString *)text;

/**
 * @return the list of word text values
 */
- (NSArray *)strings;

/**
 * @return the WSWord crossed out or nil if no WSWord to cross with the provided parameters
 */
- (WSWord *)crossOutFromStartPosition:(WSGridPosition)startPosition toEndPosition:(WSGridPosition)endPosition;

@end
