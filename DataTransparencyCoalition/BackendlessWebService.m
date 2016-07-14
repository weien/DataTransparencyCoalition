//
//  BackendlessWebService.m
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 5/13/16.
//  Copyright © 2016 Data Transparency Coalition. All rights reserved.
//

#import "BackendlessWebService.h"
#import "Backendless.h"

@implementation BackendlessWebService
+ (BackendlessWebService*) sharedInstance {
    static BackendlessWebService *sharedBackendlessUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedBackendlessUtil = [self new];
    });
    return sharedBackendlessUtil;
}

- (Metadata*) retrieveAppMetadata {
    Fault* fault = nil;
    BackendlessCollection *collection = [[Backendless sharedInstance].persistenceService find:[Metadata class] dataQuery:nil error:&fault];
    Metadata* md = collection.data.firstObject;
    return md;
}

- (NSArray*) retrieveHomeDataForConference:(NSString*)conferenceId {
    Fault* fault = nil;
    BackendlessDataQuery *query = [BackendlessDataQuery query];
    query.whereClause = [NSString stringWithFormat:@"conference = %@", conferenceId];
    query.queryOptions = [QueryOptions query:999 offset:0];
    BackendlessCollection *metadata = [[Backendless sharedInstance].persistenceService find:[Home class]
                                                                                  dataQuery:query
                                                                                      error:&fault];

//    PFQuery *query = [PFQuery queryWithClassName:@"Home"];
//    PFObject *pointerToConference = [PFObject objectWithoutDataWithClassName:@"Conference" objectId:conferenceId];
//    [query whereKey:@"conference" equalTo:pointerToConference];
//    
//    NSError* error = nil;
//    NSArray* dataFromParse = [query findObjects:&error];
//    if (error) {
//        NSLog(@"Error fetching home data: %@", error);
//    }
//    
    NSMutableArray* returnArr = [NSMutableArray array];
//    for (PFObject* obj in dataFromParse) {
//        NSMutableDictionary* dictToAdd = [NSMutableDictionary dictionary];
//        for (NSString * key in [obj allKeys]) {
//            id subObj = [obj objectForKey:key];
//            if ([subObj isKindOfClass:[PFObject class]]) {
//                PFObject* pfObj = (PFObject*)subObj;
//                [dictToAdd setObject:pfObj.objectId forKey:key];
//            }
//            else if ([subObj isKindOfClass:[PFFile class]]) {
//                PFFile* pfFile = (PFFile*)subObj;
//                [dictToAdd setObject:pfFile.url forKey:key];
//            }
//            else {
//                [dictToAdd setObject:[obj objectForKey:key] forKey:key];
//            }
//        }
//        [returnArr addObject:dictToAdd];
//    }
    
    return returnArr;
}


@end
