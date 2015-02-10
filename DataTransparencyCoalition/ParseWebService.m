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

- (NSArray*) retrieveHomeDataForConference:(NSString*)conferenceId {
    PFQuery *query = [PFQuery queryWithClassName:@"Home"];
    PFObject *pointerToConference = [PFObject objectWithoutDataWithClassName:@"Conference" objectId:conferenceId];
    [query whereKey:@"conference" equalTo:pointerToConference];
    
    NSError* error = nil;
    NSArray* dataFromParse = [query findObjects:&error];
    if (error) {
        NSLog(@"Error fetching home data: %@", error);
    }
    
    NSMutableArray* returnArr = [NSMutableArray array];
    for (PFObject* obj in dataFromParse) {
        NSMutableDictionary* dictToAdd = [NSMutableDictionary dictionary];
        for (NSString * key in [obj allKeys]) {
            id subObj = [obj objectForKey:key];
            if ([subObj isKindOfClass:[PFObject class]]) {
                PFObject* pfObj = (PFObject*)subObj;
                [dictToAdd setObject:pfObj.objectId forKey:key];
            }
            else if ([subObj isKindOfClass:[PFFile class]]) {
                PFFile* pfFile = (PFFile*)subObj;
                [dictToAdd setObject:pfFile.url forKey:key];
            }
            else {
                [dictToAdd setObject:[obj objectForKey:key] forKey:key];
            }
        }
        [returnArr addObject:dictToAdd];
    }
    
    return returnArr;
}

- (NSArray*) retrieveProgramDataForConference:(NSString*)conferenceId {
    PFQuery *query = [PFQuery queryWithClassName:@"Program"];
    PFObject *pointerToConference = [PFObject objectWithoutDataWithClassName:@"Conference" objectId:conferenceId];
    [query whereKey:@"conference" equalTo:pointerToConference];
    
    NSError* error = nil;
    NSArray* dataFromParse = [query findObjects:&error];
    if (error) {
        NSLog(@"Error fetching program data: %@", error);
    }
    
    NSMutableArray* returnArr = [NSMutableArray array];
    for (PFObject* obj in dataFromParse) {
        NSMutableDictionary* dictToAdd = [NSMutableDictionary dictionary];
        for (NSString * key in [obj allKeys]) {
            id subObj = [obj objectForKey:key];
            if ([subObj isKindOfClass:[PFObject class]]) {
                PFObject* pfObj = (PFObject*)subObj;
                [dictToAdd setObject:pfObj.objectId forKey:key];
            }
            else {
                [dictToAdd setObject:[obj objectForKey:key] forKey:key];
            }
        }
        [returnArr addObject:dictToAdd];
    }
    
    return returnArr;
}

- (NSArray*) retrieveSpeakersDataForConference:(NSString*)conferenceId {
    PFQuery *query = [PFQuery queryWithClassName:@"Speakers"];
    PFObject *pointerToConference = [PFObject objectWithoutDataWithClassName:@"Conference" objectId:conferenceId];
    [query whereKey:@"conference" equalTo:pointerToConference];
    
    NSError* error = nil;
    NSArray* dataFromParse = [query findObjects:&error];
    if (error) {
        NSLog(@"Error fetching speaker data: %@", error);
    }
    
    NSMutableArray* returnArr = [NSMutableArray array];
    for (PFObject* obj in dataFromParse) {
        NSMutableDictionary* dictToAdd = [NSMutableDictionary dictionary];
        for (NSString * key in [obj allKeys]) {
            id subObj = [obj objectForKey:key];
            if ([subObj isKindOfClass:[PFObject class]]) {
                PFObject* pfObj = (PFObject*)subObj;
                [dictToAdd setObject:pfObj.objectId forKey:key];
            }
            else if ([subObj isKindOfClass:[PFFile class]]) {
                PFFile* pfFile = (PFFile*)subObj;
                [dictToAdd setObject:pfFile.url forKey:key];
            }
            else {
                [dictToAdd setObject:[obj objectForKey:key] forKey:key];
            }
        }
        [returnArr addObject:dictToAdd];
    }
    
    return returnArr;
}

- (NSArray*) retrieveSponsorsDataForConference:(NSString*)conferenceId {
    PFQuery *query = [PFQuery queryWithClassName:@"Sponsors"];
    PFObject *pointerToConference = [PFObject objectWithoutDataWithClassName:@"Conference" objectId:conferenceId];
    [query whereKey:@"conference" equalTo:pointerToConference];
    
    NSError* error = nil;
    NSArray* dataFromParse = [query findObjects:&error];
    if (error) {
        NSLog(@"Error fetching sponsor data: %@", error);
    }
    
    NSMutableArray* returnArr = [NSMutableArray array];
    for (PFObject* obj in dataFromParse) {
        NSMutableDictionary* dictToAdd = [NSMutableDictionary dictionary];
        for (NSString * key in [obj allKeys]) {
            id subObj = [obj objectForKey:key];
            if ([subObj isKindOfClass:[PFObject class]]) {
                PFObject* pfObj = (PFObject*)subObj;
                [dictToAdd setObject:pfObj.objectId forKey:key];
            }
            else if ([subObj isKindOfClass:[PFFile class]]) {
                PFFile* pfFile = (PFFile*)subObj;
                [dictToAdd setObject:pfFile.url forKey:key];
            }
            else {
                [dictToAdd setObject:[obj objectForKey:key] forKey:key];
            }
        }
        [returnArr addObject:dictToAdd];
    }
    
    return returnArr;
}

@end
