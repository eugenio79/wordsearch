//
//  WSWord.h
//  GridViewExample
//
//  Created by Giuseppe Morana on 03/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSCommon.h"

@interface WSWord : NSObject

+ (instancetype)wordWithText:(NSString *)text
           withStartPosition:(WSGridPosition)startPosition
             withEndPosition:(WSGridPosition)endPosition;

@property (nonatomic, strong, readonly) NSString *text;
@property (nonatomic, readonly) WSGridPosition startPosition;
@property (nonatomic, readonly) WSGridPosition endPosition;

- (BOOL)isCrossedOut;

/**
 * @return YES if the word was crossed out successfully, NO if it was already crossed out
 */
- (BOOL)crossOut;


@end
