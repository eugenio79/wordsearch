//
//  ViewController.h
//  WordSearch
//
//  Created by Giuseppe Morana on 04/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSCommon.h"

/**
 * The main controller of the app, where the user plays the game.
 */
@interface WSGridViewController : UIViewController
@property (nonatomic) WSGameLevel gameLevel;
@end

