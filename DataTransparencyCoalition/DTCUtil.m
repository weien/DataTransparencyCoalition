//
//  DTCUtil.m
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/2/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import "DTCUtil.h"

@implementation DTCUtil
+ (UIFont*) currentMainFontWithSize:(float)size {
    return [UIFont fontWithName:@"GloriolaStd" size:size];
}

+ (UIFont*) currentBoldFontWithSize:(float)size {
    return [UIFont fontWithName:@"GloriolaStd-SemiBold" size:size];
}

+ (UIFont*) currentItalicFontWithSize:(float)size {
    return [UIFont fontWithName:@"GloriolaStd-Italic" size:size];
}

+ (UIStoryboard*) currentStoryboard {
    return [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}

/*    "GloriolaStd-Bold",
 "GloriolaStd-BoldItalic",
 "GloriolaStd-SemiBoldItalic",
 GloriolaStd,
 "GloriolaStd-Italic",
 "GloriolaStd-SemiBold"
 */
@end
