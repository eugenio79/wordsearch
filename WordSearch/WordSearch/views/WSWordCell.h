//
//  WSWordCell.h
//  GridViewExample
//
//  Created by Giuseppe Morana on 02/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSWord.h"

/**
 * It contains a word (bottom part of the screen)
 */
@interface WSWordCell : UICollectionViewCell

@property (nonatomic, strong) WSWord *word;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;

@end
