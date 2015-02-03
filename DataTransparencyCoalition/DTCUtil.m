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

#pragma mark - plists
+ (void) saveDataToPlistWithComponent:(NSString*)component andInfo:(id)info {
    NSString *destinationPath = [self destinationPathWithComponent:component];
    [info writeToFile:destinationPath atomically:YES];
}

+ (id) plistDataWithComponent:(NSString*)component {
    NSError* error = nil;
    NSString *destinationPath = [self destinationPathWithComponent:component];
    NSData *plistData = [NSData dataWithContentsOfFile:destinationPath];
    NSPropertyListSerialization* serializedPlist = [NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListImmutable format:0 error:&error];
    
    return serializedPlist; //this could be... ANYTHING 8D
//    return [NSDictionary dictionaryWithContentsOfFile:destinationPath];
}

+ (NSString*) destinationPathWithComponent:(NSString*)component {
    NSString *destinationPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    destinationPath = [destinationPath stringByAppendingPathComponent:component];
    return destinationPath;
}

//
//+ (void) updateCurrentUserImageWithImage:(UIImage*)image {
//    NSString* key = [kLocalProfileImageDataPrefix stringByAppendingString:[self currentUser][@"email"]];
//    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image) forKey:key];
//}
//
//+ (UIImage*) currentUserImage {
//    NSString* key = [kLocalProfileImageDataPrefix stringByAppendingString:[self currentUser][@"email"]];
//    return [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] dataForKey:key]];
//}
@end
