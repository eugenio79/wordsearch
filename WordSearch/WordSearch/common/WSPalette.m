//
//  WSColors.m
//  GridViewExample
//
//  Created by Giuseppe Morana on 02/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import "WSPalette.h"
#import "UIColor+WS.h"

@implementation WSPalette

+ (UIColor *)violet {
    return [UIColor colorWithHexString:@"#a684b3"]; // #C39BD2
}

+ (UIColor *)orange {
    return [UIColor colorWithHexString:@"#cb9667"]; // #EFB079
}

+ (UIColor *)green {
    return [UIColor colorWithHexString:@"#63ad82"]; // #75CB99
}

+ (UIColor *)yellow {
    return [UIColor colorWithHexString:@"#d1ba5e"]; // #F6DB6E
}

+ (UIColor *)blue {
    return [UIColor colorWithHexString:@"#71a4c6"]; // #85C1E9
}

+ (UIColor *)red {
    return [UIColor colorWithHexString:@"#cc7d74"]; // #F09389
}

+ (UIColor *)gray {
    return [UIColor colorWithHexString:@"#ADADAD"];
}

+ (UIColor *)white {
    return [UIColor colorWithHexString:@"#FFFFFF"];
}

+ (UIColor *)black {
    return [UIColor colorWithHexString:@"#000000"];
}

@end
