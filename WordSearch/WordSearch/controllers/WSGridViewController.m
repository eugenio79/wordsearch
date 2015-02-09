//
//  ViewController.m
//  WordSearch
//
//  Created by Giuseppe Morana on 04/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import "WSGridViewController.h"
#import "WSGameGenerator.h"
#import "WSGridCell.h"
#import "WSPalette.h"
#import "WSMarksFactory.h"
#import "WSMark.h"
#import "WSMarksOverlay.h"
#import "WSWordList.h"
#import "WSWordCell.h"
#import "WSCharsMatrix.h"
#import "WSChar.h"
#import "UIColor+WS.h"

static NSString *kWSGridCellIdentifier = @"WSGridCellIdentifier";   // chars grid id
static NSString *kWSWordCellIdentifier = @"WSWordCellIdentifier";   // word list id

static UIEdgeInsets kWSGridSectionInsets = {0.0f, 0.0f, 0.0f, 0.0f};
static UIEdgeInsets kWSWordListSectionInsets = {10.0f, 10.0f, 10.0f, 10.0f};

@interface WSGridViewController () <WSTouchesProtocol> {
    WSGameGenerator *_gameGenerator;
    WSWordList *_wordList;  // the list of the words to look for (it contains an array of WSWord objects)
    WSCharsMatrix *_charsGrid;  // the grid model (a grid of WSChar objects)
    WSMarksFactory *_permanentMarksFactory; // creates the 'word found marks' above the grid
    WSMarksFactory *_tempMarksFactory;      // creates temporary marks
    WSMark *_currentMark;   // current temp mark
    NSArray *_wordStrings;  // the list of words to look for (an array of NSString, derived from _wordList)
    NSArray *_colorsPalette;
    NSUInteger _currentColorIndex;
}

@property (weak, nonatomic) IBOutlet UICollectionView *gridView;
@property (weak, nonatomic) IBOutlet UICollectionView *wordListView;
@property (weak, nonatomic) IBOutlet WSMarksOverlay *tempMarksOverlay;
@property (weak, nonatomic) IBOutlet WSMarksOverlay *permanentMarksOverlay;

@property (nonatomic) CGSize gridCellSize;
@property (nonatomic) CGFloat gridCellFontSize;

@end

@implementation WSGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self generateTheGame];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupUI];   // only now I can setup some UI settings, because I need to know how big a cell is
}

- (CGFloat)gridCellFontSize
{
    if (_gridCellFontSize == 0) {
        NSString *charStr = @"A";   // random char, I choosed an 'A' as a template letter
        CGFloat fontSize = 17.0f;
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"TrebuchetMS" size:fontSize]};
        CGSize size = [charStr sizeWithAttributes:attributes];
        CGFloat pointsPerPixel = fontSize / size.height;
        _gridCellFontSize = self.gridCellSize.height * pointsPerPixel * 0.65;
    }
    return _gridCellFontSize;
}

- (void)setupUI
{
    self.tempMarksOverlay.touchesDelegate = self;
    
    _colorsPalette = @[[WSPalette violet],
                       [WSPalette orange],
                       [WSPalette green],
                       [WSPalette yellow],
                       [WSPalette blue],
                       [WSPalette red]];
    
    _currentColorIndex = _colorsPalette.count;  // in this way I'll start with first color (@see nextColor method)
    
    _permanentMarksFactory = [WSMarksFactory factoryWithCellSize:self.gridCellSize];
    _tempMarksFactory = [WSMarksFactory factoryWithCellSize:self.gridCellSize];
}

- (void)generateTheGame
{
    // here the term 'dictionary' refers to the collection of words and not to the underlying data structure (which is an array)
    NSArray *fullDictionary = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fullDictionary" ofType:@"plist"]];
    
    NSSet *wordsSubset = [NSSet setWithArray:fullDictionary];   // in a real world app it would be an actual subset, e.g. thematic
    
    _gameGenerator = [WSGameGenerator generatorWithWordsSet:wordsSubset andGameLevel:self.gameLevel];
    [_gameGenerator generate];
    
    _charsGrid = [_gameGenerator charsGrid];
    _wordList = [_gameGenerator wordList];
    _wordStrings = [_wordList strings]; // cache them
}

- (IBAction)menuItem_tapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource implementation

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.gridView) {
        if (_charsGrid != nil)
            return [_charsGrid size];
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
            WSChar *wsChar = [_charsGrid charAtGridPosition:position];
            cell.charLabel.text = [NSString stringWithFormat:@"%c", wsChar.character];
            cell.charLabel.textColor = wsChar.marked ? [WSPalette white] : [WSPalette black];
            cell.charLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:self.gridCellFontSize];
        }
        
        return cell;
    }
    else if (collectionView == self.wordListView) {
        WSWordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kWSWordCellIdentifier forIndexPath:indexPath];
        if (cell != nil && _wordList != nil) {
            NSString *text = _wordStrings[indexPath.row];
            WSWord *word = [_wordList wordWithText:text];
            cell.word = word;
            cell.wordLabel.textColor = _colorsPalette[_currentColorIndex];
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
        return self.gridCellSize;
    }
    else if (collectionView == self.wordListView) {
        return [self wordCellSize];
    }
    return CGSizeZero;
}

#pragma mark - touches

- (void)touchBeganAtPoint:(CGPoint)point {
    
    WSGridPosition gridPosition = [self gridPositionForItemAtPoint:point];
    
    _currentMark = [_tempMarksFactory createMarkWithColor:[WSPalette gray]];
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
        [self markCharsForWord:crossedOut_word];
        [self crossOutString:crossedOut_word.text];
    }
    
    [_tempMarksOverlay clear];
    _currentMark = nil;
}

- (void)touchCancelled {
    
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
    gridPosition.row = (NSUInteger)(indexPath.row / [_charsGrid rowsCount]);
    gridPosition.column = (NSUInteger)(indexPath.row %  [_charsGrid columnsCount]);
    return gridPosition;
}

// computed one time
- (CGSize)gridCellSize {
    if (areEqualsSizes(_gridCellSize, CGSizeZero)) {
        _gridCellSize.width = self.gridView.frame.size.width / [_charsGrid columnsCount];
        _gridCellSize.height = self.gridView.frame.size.height / [_charsGrid rowsCount];
    }
    return _gridCellSize;
}

- (CGSize)wordCellSize {

    CGRect drawableFrame = UIEdgeInsetsInsetRect(self.wordListView.frame, kWSWordListSectionInsets);

    CGSize size;
    
    // for demo purpose I take into account only two configurations: 9 and 12 words
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
    
    WSMark *mark = [_permanentMarksFactory createMarkWithColor:[self nextColor]];
    mark.startPosition = word.startPosition;
    mark.endPosition = word.endPosition;
    [_permanentMarksOverlay addMark:mark];
}

// changes the color of the letters once "marked"
- (void)markCharsForWord:(WSWord *)word {
    
    NSMutableArray *indexPathsToReload = [NSMutableArray new];
    
    NSUInteger charIndex = 0;
    while (charIndex < word.text.length) {
        WSGridPosition currentPosition = [word gridPositionForCharAtIndex:charIndex];
        WSChar *wsChar = [_charsGrid charAtGridPosition:currentPosition];
        wsChar.marked = YES;
        [indexPathsToReload addObject:[self indexPathForGridPosition:currentPosition]];
        charIndex++;
    }
    
    if (indexPathsToReload.count > 0)
        [self.gridView reloadItemsAtIndexPaths:indexPathsToReload];
}

- (NSIndexPath *)indexPathForGridPosition:(WSGridPosition)gridPosition
{
    if (areEqualsPosition(gridPosition, WSGridPositionNotFound))
        return nil;
    
    NSUInteger index = gridPosition.row * [_charsGrid rowsCount] + gridPosition.column;
    return [NSIndexPath indexPathForItem:index inSection:0];
}

// adds a mark onto a word in the lower list 
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

- (UIColor *)nextColor {
    _currentColorIndex++;
    if (_currentColorIndex >= _colorsPalette.count)
        _currentColorIndex = 0;
    return _colorsPalette[_currentColorIndex];
}

@end
