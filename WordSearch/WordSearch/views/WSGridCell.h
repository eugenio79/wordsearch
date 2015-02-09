//
//  WSGridCell.h
//  GridViewExample
//
//  Created by Giuseppe Morana on 31/01/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSCommon.h"

/**
 * It contains a letter
 */
@interface WSGridCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *charLabel;

@end
