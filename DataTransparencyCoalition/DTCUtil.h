//
//  DTCUtil.h
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/2/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DTCUtil : NSObject
+ (UIFont*) currentMainFontWithSize:(float)size;
+ (UIFont*) currentBoldFontWithSize:(float)size;
+ (UIFont*) currentItalicFontWithSize:(float)size;

+ (UIStoryboard*) currentStoryboard;

//plists
+ (void) saveDataToPlistWithComponent:(NSString*)component andInfo:(id)info;
+ (id) plistDataWithComponent:(NSString*)component;
@end
