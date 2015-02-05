//
//  WSWordList.m
//  GridViewExample
//
//  Created by Giuseppe Morana on 03/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import "WSWordList.h"
#import "WSCommon.h"

@interface WSWordList()
@property (nonatomic, strong) NSMutableDictionary *wordsMap;    // underlying data structure (key: WSGridPosition, value: WSWord)
@property (nonatomic, strong) NSMutableDictionary *wordTextMap; // (key: NSString, value: WSWord)
@end

@implementation WSWordList

#pragma mark - Public APIs

+ (instancetype)list {
    WSWordList *wordList = [WSWordList new];
    wordList.wordsMap = [NSMutableDictionary new];
    wordList.wordTextMap = [NSMutableDictionary new];
    return wordList;
}

- (BOOL)addWord:(WSWord *)word {
    if (word == nil) return NO;
    NSString *key = [self keyForStartPosition:word.startPosition andEndPosition:word.endPosition];
    id obj = [self.wordsMap objectForKey:key];
    if (obj == nil) {
        [self.wordsMap setObject:word forKey:key];
        [self.wordTextMap setObject:word forKey:word.text];
        return YES;
    }
    else
        return NO;
}

- (WSWord *)crossOutFromStartPosition:(WSGridPosition)startPosition toEndPosition:(WSGridPosition)endPosition
{
    WSWord *word = [self wordFromStartPosition:startPosition toEndPosition:endPosition];
    if (word != nil && ![word isCrossedOut]) {
        [word crossOut];
        return word;
    }
    return nil;
}

- (NSArray *)strings {
    return [[self.wordTextMap allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (WSWord *)wordWithText:(NSString *)text {
    if (text != nil)
        return self.wordTextMap[text];
    return nil;
}

#pragma mark - private

// unique key for (start, end)
- (NSString *)keyForStartPosition:(WSGridPosition)startPosition andEndPosition:(WSGridPosition)endPosition
{
    return [NSString stringWithFormat:@"(%u, %u) -> (%u, %u)", (unsigned)startPosition.row, (unsigned)startPosition.column, (unsigned)endPosition.row, (unsigned)endPosition.column];
}

- (WSWord *)wordFromStartPosition:(WSGridPosition)startPosition toEndPosition:(WSGridPosition)endPosition {
    
    NSString *key = [self keyForStartPosition:startPosition andEndPosition:endPosition];
    return [self.wordsMap objectForKey:key];
}

- (BOOL)canCrossOutFromStartPosition:(WSGridPosition)startPosition toEndPosition:(WSGridPosition)endPosition
{
    WSWord *word = [self wordFromStartPosition:startPosition toEndPosition:endPosition];
    return (word != nil) && ![word isCrossedOut];
}

@end
