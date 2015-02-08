//
//  WSMarksView.m
//  GridViewExample
//
//  Created by Giuseppe Morana on 01/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import "WSMarksOverlay.h"

@implementation WSMarksOverlay {
    NSMutableArray *_marks;
}

- (void)addMark:(WSMark *)mark {
    if (_marks == nil)
        _marks = [NSMutableArray new];
    [_marks addObject:mark];
    [mark addObserver:self forKeyPath:@"endPosition" options:NSKeyValueObservingOptionNew context:nil];
    [self drawMark:mark];
}

- (void)drawMark:(WSMark *)mark {
    
    UIGraphicsBeginImageContext(self.frame.size);
    
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), mark.startPoint.x, mark.startPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), mark.endPoint.x, mark.endPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), mark.brush.size );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), mark.brush.rgb.red, mark.brush.rgb.green, mark.brush.rgb.blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModePlusDarker);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    [self setAlpha:mark.brush.opacity];
    
    UIGraphicsEndImageContext();
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isKindOfClass:[WSMark class]] && [keyPath isEqualToString:@"endPosition"]) {
        WSMark *mark = (WSMark *)object;
        if (mark.needsLayout) {
            self.image = nil;
            [self drawMark:mark];
            mark.needsLayout = NO;
        }
    }
}

- (void)clear {
    self.image = nil;
    for (WSMark *mark in _marks) {
        [mark removeObserver:self forKeyPath:@"endPosition"];
    }
    [_marks removeAllObjects];
}

- (void)dealloc {
    [self clear];
}


#pragma mark - touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (self.touchesDelegate != nil && [self.touchesDelegate respondsToSelector:@selector(touchBeganAtPoint:)]) {
        
        UITouch *touch = [touches anyObject];   // multipleTouchEnabled = NO, so I don't have to mind about what touch is it
        CGPoint point = [touch locationInView:self];
        [self.touchesDelegate touchBeganAtPoint:point];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (self.touchesDelegate != nil && [self.touchesDelegate respondsToSelector:@selector(touchMovedAtPoint:)]) {
        
        UITouch *touch = [touches anyObject];   // multipleTouchEnabled = NO, so I don't have to mind about what touch is it
        CGPoint point = [touch locationInView:self];
        [self.touchesDelegate touchMovedAtPoint:point];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (self.touchesDelegate != nil && [self.touchesDelegate respondsToSelector:@selector(touchEndedAtPoint:)]) {
        
        UITouch *touch = [touches anyObject];   // multipleTouchEnabled = NO, so I don't have to mind about what touch is it
        CGPoint point = [touch locationInView:self];
        [self.touchesDelegate touchEndedAtPoint:point];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesCancelled");
    
    if (self.touchesDelegate != nil && [self.touchesDelegate respondsToSelector:@selector(touchCancelled)]) {
        [self.touchesDelegate touchCancelled];
    }
}

@end
