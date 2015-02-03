//
//  ParseUtil.m
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/2/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import "ParseWebService.h"
#import <Parse/Parse.h>
#import "DTCUtil.h"

@implementation ParseWebService
+ (ParseWebService*) sharedInstance {
    static ParseWebService *sharedParseUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedParseUtil = [self new];
    });
    return sharedParseUtil;
}

- (NSDictionary*) retrieveMetaData {
    PFQuery *query = [PFQuery queryWithClassName:@"Metadata"];
    [query includeKey:@"currentConference"];
    
    NSError* error = nil;
    PFObject* metadata = [query getFirstObject:&error];
    if (error) {
        NSLog(@"Error fetching metadata: %@", error);
    }
    
    NSMutableDictionary* returnDict = [NSMutableDictionary dictionary];
    if (metadata[@"conferenceModeEnabled"]) {
        PFObject* conference = metadata[@"currentConference"];
        //NSLog(@"conference is %@", conference);
        
        for (NSString * key in [conference allKeys]) {
            [returnDict setObject:[conference objectForKey:key] forKey:key];
        }
        [returnDict setObject:@(YES) forKey:@"conferenceModeEnabled"];
    }
    else {
        //For future development
        [returnDict setObject:@(NO) forKey:@"conferenceModeEnabled"];
    }
    
    return returnDict;
}

@end
