//
//  BackendlessWebService.m
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 5/13/16.
//  Copyright © 2016 Data Transparency Coalition. All rights reserved.
//

#import "BackendlessWebService.h"
#import "Backendless.h"
#import "Metadata.h"
#import "Home.h"

@implementation BackendlessWebService
+ (BackendlessWebService*) sharedInstance {
    static BackendlessWebService *sharedBackendlessUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedBackendlessUtil = [self new];
    });
    return sharedBackendlessUtil;
}

- (NSDictionary*) retrieveAppMetadata {
    Fault* fault = nil;
    BackendlessCollection *returnedCollection = [[Backendless sharedInstance].persistenceService find:[Home class] dataQuery:nil error:&fault];
    
//    [[[Backendless sharedInstance].persistenceService of:[Home class]] findFirst:^(id first) {
//        NSLog(@"first is %@", first);
//    } error:^(Fault *fault) {
//        NSLog(@"fault is %@", fault);
//    }];
    
//    @try {
//        id<IDataStore> dataStore = [[[Backendless sharedInstance] persistenceService] of:[Home class]];
//        BackendlessCollection *returnedCollection = [dataStore findFirst];
//        if ([returnedCollection isKindOfClass:[NSObject class]]) {
//            NSLog(@"BEL returned %@", returnedCollection);
//        }
//    }
//    @catch (Fault *fault){
//        NSLog(@"Fault is %@", fault);
//    }
    
    return nil;
    
    
    /*
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
     */
}
@end
