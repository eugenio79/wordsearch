//
//  WSGameGenerator.h
//  GridViewExample
//
//  Created by Giuseppe Morana on 02/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSCommon.h"
#import "WSWordList.h"

/**
 * It's the core game engine. It generates the word list and the chars grid.
 */
@interface WSGameGenerator : NSObject

+ (instancetype)generatorWithWordsSet:(NSSet *)wordsSet andSideSize:(NSUInteger)sideSize;

- (void)generate;

- (NSArray *)charsGrid;
- (WSWordList *)wordList;

@end
