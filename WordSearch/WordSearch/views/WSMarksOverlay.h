//
//  WSMarksView.h
//  GridViewExample
//
//  Created by Giuseppe Morana on 01/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSTouchesProtocol.h"
#import "WSMark.h"

/**
 * An overlay into will be drawn word marks
 */
@interface WSMarksOverlay : UIImageView

@property (nonatomic, weak) id<WSTouchesProtocol> touchesDelegate;

- (void)addMark:(WSMark *)mark;

- (void)clear;

@end
