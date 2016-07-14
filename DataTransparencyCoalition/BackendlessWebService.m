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
    BackendlessCollection *collection = [[Backendless sharedInstance].persistenceService find:[Metadata class]
                                                                                    dataQuery:nil
                                                                                        error:&fault];
    Metadata* md = collection.data.firstObject;
    return md;
}

- (NSArray*) retrieveHomeDataForConference:(NSString*)conferenceId {
    Fault* fault = nil;
    BackendlessDataQuery *query = [BackendlessDataQuery query];
    query.whereClause = [NSString stringWithFormat:@"conference.objectId = \'%@\'", conferenceId];
    query.queryOptions = [QueryOptions query:100 offset:0];
    BackendlessCollection *collection = [[Backendless sharedInstance].persistenceService find:[Home class]
                                                                                  dataQuery:query
                                                                                      error:&fault];
    //NSLog(@"Collection is %@, fault is %@", collection, fault);
    return collection.data;
}


@end
