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

//dates
+ (NSDateFormatter*) sharedDateFormatter;
+ (NSString *)daySuffixForDate:(NSDate *)date;

//plists
+ (void) archiveWithComponent:(NSString*)component andInfo:(id)info;
+ (id) unarchiveWithComponent:(NSString*)component;
@end
