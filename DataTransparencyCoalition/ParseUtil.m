//
//  ParseUtil.m
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/2/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import "ParseUtil.h"
#import <Parse/Parse.h>

@implementation ParseUtil
+ (ParseUtil*) sharedInstance {
    static ParseUtil *sharedParseUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedParseUtil = [self new];
    });
    return sharedParseUtil;
}

- (NSArray*) retrieveMetaData {
    PFQuery *query = [PFQuery queryWithClassName:@"Metadata"];
    [query includeKey:@"currentConference"];
    
    NSError* error = nil;
    PFObject* metadata = [query getFirstObject:&error];
    if (error) {
        NSLog(@"Error fetching metadata: %@", error);
    }
    
    if (metadata[@"conferenceModeEnabled"]) {
        PFObject* conference = metadata[@"currentConference"];
        NSLog(@"conference is %@", conference);
    }
    else {
        //For future development
        NSLog(@"Conference mode disabled.");
    }
    
    return nil;
}

@end
