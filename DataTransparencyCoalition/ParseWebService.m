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
        [returnDict setObject:conference.objectId forKey:@"conferenceId"];
    }
    else {
        //For future development
        [returnDict setObject:@(NO) forKey:@"conferenceModeEnabled"];
    }
    
    return returnDict;
}

- (NSArray*) retrieveProgramDataForConference:(NSString*)conferenceId {
    PFQuery *query = [PFQuery queryWithClassName:@"Program"];
    [query whereKey:@"conference" equalTo:conferenceId];
    
    NSError* error = nil;
    NSArray* dataFromParse = [query findObjects:&error];
    if (error) {
        NSLog(@"Error fetching metadata: %@", error);
    }
    
    NSMutableArray* returnArr = [NSMutableArray array];
    for (PFObject* obj in dataFromParse) {
        NSMutableDictionary* dictToAdd = [NSMutableDictionary dictionary];
        for (NSString * key in [obj allKeys]) {
            [dictToAdd setObject:[obj objectForKey:key] forKey:key];
        }
        [returnArr addObject:dictToAdd];
    }
    
    return returnArr;
}

@end
