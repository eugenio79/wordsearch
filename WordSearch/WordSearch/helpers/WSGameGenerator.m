//
//  WSGameGenerator.m
//  GridViewExample
//
//  Created by Giuseppe Morana on 02/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import "WSGameGenerator.h"

@interface WSGameGenerator() {
    NSSet *_wordsSet;   // unused in this demo
    NSUInteger _sideSize;   // unused in this demo
    NSArray *_generatedCharsGrid;
    WSWordList *_generatedWordList;
}

@end

@implementation WSGameGenerator

+ (instancetype)generatorWithWordsSet:(NSSet *)wordsSet andSideSize:(NSUInteger)sideSize {
    return [[WSGameGenerator alloc] initWithWordsSet:wordsSet andSideSize:sideSize];
}

- (instancetype)initWithWordsSet:(NSSet *)wordsSet andSideSize:(NSUInteger)sideSize {
    if (self = [super init]) {
        _wordsSet = wordsSet;
        _sideSize = sideSize;
    }
    return self;
}

// fake! demo purpose only
- (void)generate {
    NSArray *rows = @[@"K A E M O R A E",
                      @"O M I I Q H N U",
                      @"B I T N P E I T",
                      @"B N R O C M E U",
                      @"A A A D U S A C",
                      @"B V F I I Y V O",
                      @"G G F O R T I M",
                      @"N A P I L E S E"];
    
    NSMutableArray *matrix = [[NSMutableArray alloc] initWithCapacity:rows.count];
    for (NSString *rowStr in rows) {
        NSArray *row = [rowStr componentsSeparatedByString:@" "];
        [matrix addObject:row];
    }
    
    _generatedCharsGrid = [NSArray arrayWithArray:matrix];
//    NSArray *wordTexts = [[_wordsSet allObjects] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    _generatedWordList = [WSWordList list];
    
    WSWord *word;
    
    word = [WSWord wordWithText:@"AMPIE"
              withStartPosition:WSMakeGridPosition(4, 6)
                withEndPosition:WSMakeGridPosition(0, 2)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"ANIMA"
              withStartPosition:WSMakeGridPosition(4, 1)
                withEndPosition:WSMakeGridPosition(0, 1)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"BABBO"
              withStartPosition:WSMakeGridPosition(5, 0)
                withEndPosition:WSMakeGridPosition(1, 0)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"CENE"
              withStartPosition:WSMakeGridPosition(3, 4)
                withEndPosition:WSMakeGridPosition(0, 7)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"COME"
              withStartPosition:WSMakeGridPosition(4, 7)
                withEndPosition:WSMakeGridPosition(7, 7)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"DONI"
              withStartPosition:WSMakeGridPosition(4, 3)
                withEndPosition:WSMakeGridPosition(1, 3)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"FARTI"
              withStartPosition:WSMakeGridPosition(5, 2)
                withEndPosition:WSMakeGridPosition(1, 2)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"FIUMI"
              withStartPosition:WSMakeGridPosition(6, 2)
                withEndPosition:WSMakeGridPosition(2, 6)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"FORTI"
              withStartPosition:WSMakeGridPosition(6, 2)
                withEndPosition:WSMakeGridPosition(6, 6)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"MORA"
              withStartPosition:WSMakeGridPosition(0, 3)
                withEndPosition:WSMakeGridPosition(0, 6)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"PILE"
              withStartPosition:WSMakeGridPosition(7, 2)
                withEndPosition:WSMakeGridPosition(7, 5)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"TESI"
              withStartPosition:WSMakeGridPosition(2, 7)
                withEndPosition:WSMakeGridPosition(5, 4)];
    [_generatedWordList addWord:word];
}

- (NSArray *)charsGrid {
    return _generatedCharsGrid;
}

- (WSWordList *)wordList {
    return _generatedWordList;
}

@end
