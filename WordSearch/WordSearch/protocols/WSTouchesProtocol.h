//
//  WSTouchesProtocol.h
//  GridViewExample
//
//  Created by Giuseppe Morana on 01/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WSTouchesProtocol <NSObject>

@optional
- (void)touchBeganAtPoint:(CGPoint)point;
- (void)touchMovedAtPoint:(CGPoint)point;
- (void)touchEndedAtPoint:(CGPoint)point;
- (void)touchCancelled;

@end
