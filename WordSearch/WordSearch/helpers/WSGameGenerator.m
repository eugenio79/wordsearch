//
//  WSGameGenerator.m
//  GridViewExample
//
//  Created by Giuseppe Morana on 02/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import "WSGameGenerator.h"

@interface WSGameGenerator() {
    WSCharsMatrix *_generatedCharsGrid;
    WSWordList *_generatedWordList;
}

@end

@implementation WSGameGenerator

+ (instancetype)generatorWithWordsSet:(NSSet *)wordsSet andGameLevel:(WSGameLevel)gameLevel {
    return [[WSGameGenerator alloc] initWithWordsSet:wordsSet andGameLevel:gameLevel];
}

- (instancetype)initWithWordsSet:(NSSet *)wordsSet andGameLevel:(WSGameLevel)gameLevel {
    if (self = [super init]) {
        self.wordsSet = wordsSet;
        self.gameLevel = gameLevel;
    }
    return self;
}

- (WSCharsMatrix *)charsGrid {
    return _generatedCharsGrid;
}

- (WSWordList *)wordList {
    return _generatedWordList;
}

// fake! demo purpose only
- (void)generate {
    
    switch (self.gameLevel) {
        case WSGameLevelEasy:
            [self fakeGeneration_easy];
            break;
        case WSGameLevelHard:
            [self fakeGeneration_hard];
            break;
        default:
            [self fakeGeneration_medium];
            break;
    }
}

- (void)fakeGeneration_easy {
    
    NSArray *rows = @[@"F L Q E",
                      @"F I X H",
                      @"G A N T",
                      @"W O R D"];
    
    _generatedCharsGrid = [WSCharsMatrix matrixWithArrayOfStrings:rows];
    
    _generatedWordList = [WSWordList list];
    
    WSWord *word;
    
    word = [WSWord wordWithText:@"FIND"
              withStartPosition:WSMakeGridPosition(0, 0)
                withEndPosition:WSMakeGridPosition(3, 3)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"THE"
              withStartPosition:WSMakeGridPosition(2, 3)
                withEndPosition:WSMakeGridPosition(0, 3)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"WORD"
              withStartPosition:WSMakeGridPosition(3, 0)
                withEndPosition:WSMakeGridPosition(3, 3)];
    [_generatedWordList addWord:word];
}

- (void)fakeGeneration_medium {
    
    NSArray *rows = @[@"K A E M O R A E",
                      @"O M I I Q H N U",
                      @"B I T N P E I T",
                      @"B N R O C M E U",
                      @"A A A D U S A C",
                      @"B V F I I Y V O",
                      @"G G F O R T I M",
                      @"N A P I L E S E"];
    
    _generatedCharsGrid = [WSCharsMatrix matrixWithArrayOfStrings:rows];
    
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

- (void)fakeGeneration_hard {
    
    
    NSArray *rows = @[@"A T I N G I D I E E",
                      @"V M D E L L O S R R",
                      @"A Q L Z R T I E E S",
                      @"T T G L A M N N O I",
                      @"N R T I Q E D G N C",
                      @"E L G I T E G O K U",
                      @"T A O N R E E R Y R",
                      @"D I O G T A A U S E",
                      @"K C L T A S R M R W",
                      @"O I I G B O R E N W"];
    
    _generatedCharsGrid = [WSCharsMatrix matrixWithArrayOfStrings:rows];
    
    _generatedWordList = [WSWordList list];
    
    WSWord *word;
    
    word = [WSWord wordWithText:@"AGIATO"
              withStartPosition:WSMakeGridPosition(6, 1)
                withEndPosition:WSMakeGridPosition(1, 6)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"ATTIRARE"
              withStartPosition:WSMakeGridPosition(2, 0)
                withEndPosition:WSMakeGridPosition(9, 7)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"CONTENERE"
              withStartPosition:WSMakeGridPosition(8, 1)
                withEndPosition:WSMakeGridPosition(0, 9)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"DELLO"
              withStartPosition:WSMakeGridPosition(1, 2)
                withEndPosition:WSMakeGridPosition(1, 6)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"DIGNITÀ"
              withStartPosition:WSMakeGridPosition(0, 6)
                withEndPosition:WSMakeGridPosition(0, 0)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"MISE"
              withStartPosition:WSMakeGridPosition(3, 5)
                withEndPosition:WSMakeGridPosition(0, 8)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"MURO"
              withStartPosition:WSMakeGridPosition(8, 7)
                withEndPosition:WSMakeGridPosition(5, 7)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"NERO"
              withStartPosition:WSMakeGridPosition(9, 8)
                withEndPosition:WSMakeGridPosition(9, 5)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"OGGETTI"
              withStartPosition:WSMakeGridPosition(3, 8)
                withEndPosition:WSMakeGridPosition(9, 2)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"RENDERGLI"
              withStartPosition:WSMakeGridPosition(1, 9)
                withEndPosition:WSMakeGridPosition(9, 1)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"SICURE"
              withStartPosition:WSMakeGridPosition(2, 9)
                withEndPosition:WSMakeGridPosition(7, 9)];
    [_generatedWordList addWord:word];
    
    word = [WSWord wordWithText:@"TENTAVA"
              withStartPosition:WSMakeGridPosition(6, 0)
                withEndPosition:WSMakeGridPosition(0, 0)];
    [_generatedWordList addWord:word];
}

@end
