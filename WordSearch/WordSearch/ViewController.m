//
//  ViewController.m
//  WordSearch
//
//  Created by Giuseppe Morana on 04/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import "ViewController.h"
#import "WSGameGenerator.h"
#import "WSGridCell.h"
#import "WSPalette.h"
#import "WSMarksFactory.h"
#import "WSMark.h"
#import "WSMarksOverlay.h"
#import "WSWordList.h"
#import "WSWordCell.h"

static NSString *kWSGridCellIdentifier = @"WSGridCellIdentifier";   // chars grid id
static NSString *kWSWordCellIdentifier = @"WSWordCellIdentifier";   // word list id

static UIEdgeInsets kWSGridSectionInsets = {0.0f, 0.0f, 0.0f, 0.0f};
static UIEdgeInsets kWSWordListSectionInsets = {10.0f, 10.0f, 10.0f, 10.0f};

@interface ViewController () <WSTouchesProtocol> {
    WSGameGenerator *_gameGenerator;
    WSWordList *_wordList;  // the list of the words to look for (an array of WSWord objects)
    NSArray *_charsGrid;  // array of array of chars (each char is modeled as NSString)
    WSMarksFactory *_permanentMarksFactory; // creates the 'marks' above the grid
    WSMarksFactory *_tempMarksFactory;      // creates temporary marks
    WSMark *_currentMark;   // current temp mark
    NSArray *_wordStrings;  // the list of words to look for (an array of NSString, derived from _wordList)
}

@property (weak, nonatomic) IBOutlet UICollectionView *gridView;
@property (weak, nonatomic) IBOutlet UICollectionView *wordListView;
@property (weak, nonatomic) IBOutlet WSMarksOverlay *tempMarksOverlay;
@property (weak, nonatomic) IBOutlet WSMarksOverlay *permanentMarksOverlay;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self generateTheGame];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupMarkOverlays];   // only now I can setup the overlays, because I need to know how big is a cell
}

- (void)setupMarkOverlays
{
    self.tempMarksOverlay.touchesDelegate = self;
    
    NSArray *palette = @[[WSPalette violet],
                         [WSPalette orange],
                         [WSPalette green],
                         [WSPalette yellow],
                         [WSPalette blue],
                         [WSPalette red]];
    
    _permanentMarksFactory = [WSMarksFactory factoryWithCellSize:[self gridCellSize]
                                                andColorsPalette:palette];
    
    _tempMarksFactory = [WSMarksFactory factoryWithCellSize:[self gridCellSize]
                                           andColorsPalette:@[[UIColor blackColor]]];
}

- (void)generateTheGame
{
    // here the term 'dictionary' refers to the collection of words and not to the underlying data structure (which is an array)
    NSArray *fullDictionary = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fullDictionary" ofType:@"plist"]];
    
    NSSet *wordsSubset = [NSSet setWithArray:fullDictionary];   // in a real world app it would be an actual subset, e.g. thematic
    
    _gameGenerator = [WSGameGenerator generatorWithWordsSet:wordsSubset andGameLevel:WSGameLevelHard];
    [_gameGenerator generate];
    
    _charsGrid = [_gameGenerator charsGrid];
    _wordList = [_gameGenerator wordList];
    _wordStrings = [_wordList strings]; // cache them
}


#pragma mark - UICollectionViewDataSource implementation

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.gridView) {
        if (_charsGrid != nil)
            return _charsGrid.count * _charsGrid.count;  // assuming, for demo purposes, that it's a square matrix
    }
    else if (collectionView == self.wordListView) {
        if (_wordStrings != nil)
            return [_wordStrings count];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.gridView) {
        WSGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kWSGridCellIdentifier forIndexPath:indexPath];
        
        if (cell != nil && _charsGrid != nil) {
            WSGridPosition position = [self gridPositionForIndexPath:indexPath];
            NSArray *charsRow = [_charsGrid objectAtIndex:position.row];
            NSString *charText = [charsRow objectAtIndex:position.column];
            cell.charLabel.text = charText;
        }
        
        return cell;
    }
    else if (collectionView == self.wordListView) {
        WSWordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kWSWordCellIdentifier forIndexPath:indexPath];
        if (cell != nil && _wordList != nil) {
            NSString *text = _wordStrings[indexPath.row];
            WSWord *word = [_wordList wordWithText:text];
            cell.word = word;
        }
        return cell;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout implementation

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (collectionView == self.gridView)
        return kWSGridSectionInsets;
    else if (collectionView == self.wordListView)
        return kWSWordListSectionInsets;
    else
        return UIEdgeInsetsZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.gridView) {
        return [self gridCellSize];
    }
    else if (collectionView == self.wordListView) {
        return [self wordCellSize];
    }
    return CGSizeZero;
}

/*
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (collectionView == self.wordListView)
        return 10.0f;
    else
        return 0.0f;
}
 */

/*
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (collectionView == self.wordListView)
        return 0.0f;
    else
        return 0.0f;
}
 */

#pragma mark - touches

- (void)touchBeganAtPoint:(CGPoint)point {
    
    WSGridPosition gridPosition = [self gridPositionForItemAtPoint:point];
    
    _currentMark = [_tempMarksFactory createMark];
    _currentMark.startPosition = gridPosition;
    _currentMark.endPosition = gridPosition;
    [_tempMarksOverlay addMark:_currentMark];
}

- (void)touchMovedAtPoint:(CGPoint)point {
    
    WSGridPosition gridPosition = [self gridPositionForItemAtPoint:point];
    
    if (_currentMark != nil)
        _currentMark.endPosition = gridPosition;
}

- (void)touchEndedAtPoint:(CGPoint)point {
    
    WSGridPosition gridPosition = [self gridPositionForItemAtPoint:point];
    
    // update model
    WSWord *crossedOut_word = [_wordList crossOutFromStartPosition:_currentMark.startPosition toEndPosition:gridPosition];
    
    // update views
    if (crossedOut_word != nil) {
        [self addPermanentMarkForWord:crossedOut_word];
        [self crossOutString:crossedOut_word.text];
    }
    
    [_tempMarksOverlay clear];
    _currentMark = nil;
}

- (void)touchCancelled {
    NSLog(@"touchCancelled");
    
    [_tempMarksOverlay clear];
    _currentMark = nil;
}

#pragma mark - helpers methods

- (WSGridPosition)gridPositionForItemAtPoint:(CGPoint)point
{
    return [self gridPositionForIndexPath:[self.gridView indexPathForItemAtPoint:point]];
}

- (WSGridPosition)gridPositionForIndexPath:(NSIndexPath *)indexPath
{
    WSGridPosition gridPosition;
    gridPosition.row = (NSUInteger)(indexPath.row / _charsGrid.count);
    gridPosition.column = (NSUInteger)(indexPath.row %  _charsGrid.count);
    return gridPosition;
}

- (CGSize)gridCellSize {
    CGSize size;
    size.width = self.gridView.frame.size.width / _charsGrid.count;
    size.height = self.gridView.frame.size.height / _charsGrid.count;
    return size;
}

- (CGSize)wordCellSize {

//    NSLog(@"self.view.frame: %@", NSStringFromCGRect(self.view.frame));
//    NSLog(@"self.wordListView.frame: %@", NSStringFromCGRect(self.wordListView.frame));
    
    CGRect drawableFrame = UIEdgeInsetsInsetRect(self.wordListView.frame, kWSWordListSectionInsets);

    CGSize size;
    
    switch (_wordStrings.count) {
        case 12: {
            // e.g. iPhone portrait
            if (self.wordListView.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
                size.width = drawableFrame.size.width / 3;
                size.height = drawableFrame.size.height / 4;
            }
            // e.g. iPad
            else {
                size.width = drawableFrame.size.width / 4;
                size.height = drawableFrame.size.height / 3;
            }
            break;
        }
        default: {  // 9
            size.width = drawableFrame.size.width / 3;
            size.height = drawableFrame.size.height / 3;
            break;
        }
    }
    
    return size;
}

- (void)addPermanentMarkForWord:(WSWord *)word {
    
    WSMark *mark = [_permanentMarksFactory createMark];
    mark.startPosition = word.startPosition;
    mark.endPosition = word.endPosition;
    [_permanentMarksOverlay addMark:mark];
}

- (BOOL)crossOutString:(NSString *)string {
    
    NSUInteger index = [_wordStrings indexOfObject:string];
    if (index != NSNotFound) {
        
        // force cell reload
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.wordListView reloadItemsAtIndexPaths:@[indexPath]];
        
        return YES;
    }
    
    return NO;
}

@end
