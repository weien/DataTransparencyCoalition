//
//  BackendlessWebService.h
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 5/13/16.
//  Copyright © 2016 Data Transparency Coalition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Metadata.h"
#import "Conference.h"

@interface BackendlessWebService : NSObject
+ (BackendlessWebService*) sharedInstance;
- (Metadata*) retrieveAppMetadata;
- (NSArray*) retrieveDataForClass:(Class)class andConference:(NSString*)conferenceId;
@end
