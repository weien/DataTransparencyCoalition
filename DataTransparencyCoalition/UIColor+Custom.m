//
//  UIColor+Custom.m
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/2/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import "UIColor+Custom.h"

@implementation UIColor (Custom)
+ (UIColor*) orangeColorSun {
    return [UIColor colorWithRed:0.96 green:0.55 blue:0.22 alpha:1];
}

+ (UIColor*) orangeColorTacao {
    return [UIColor colorWithRed:234/255.0 green:173/255.0 blue:125/255.0 alpha:255/255.0];
}

+ (UIColor*) grayColorVeryLight {
    return [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
}

+ (UIColor*) grayColorVeryDark {
    return [UIColor colorWithRed:0.18 green:0.2 blue:0.21 alpha:1];
}

+ (UIColor*) blueColorBlueDeFrance {
    return [UIColor colorWithRed:50/255.0 green:162/255.0 blue:240/255.0 alpha:255/255.0];
}

@end
