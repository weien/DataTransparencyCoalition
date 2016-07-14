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

#pragma mark - dates
+ (NSDateFormatter*) sharedDateFormatter {
    NSMutableDictionary* dictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter* dateFormatter = [dictionary objectForKey:@"SharedDateFormatter"];
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dictionary setObject:dateFormatter forKey:@"SharedDateFormatter"];
    }
    return dateFormatter;
}

//thanks http://stackoverflow.com/a/23273686/2284713
+ (NSString *)daySuffixForDate:(NSDate *)date {
    NSInteger day_of_month = [[[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:date] day];
    switch (day_of_month) {
        case 1:
        case 21:
        case 31: return @"st";
        case 2:
        case 22: return @"nd";
        case 3:
        case 23: return @"rd";
        default: return @"th";
    }
}

#pragma mark - archiving
+ (void) saveDataToPlistWithComponent:(NSString*)component andInfo:(id)info {
    NSString *destinationPath = [self destinationPathWithComponent:component];
    [NSKeyedArchiver archiveRootObject:info toFile:destinationPath];
}

+ (id) plistDataWithComponent:(NSString*)component {
    NSString *destinationPath = [self destinationPathWithComponent:component];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:destinationPath];
}

+ (NSString*) destinationPathWithComponent:(NSString*)component {
    NSString *destinationPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    destinationPath = [destinationPath stringByAppendingPathComponent:component];
    return destinationPath;
}

@end
