//
//  BackendlessWebService.h
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 5/13/16.
//  Copyright © 2016 Data Transparency Coalition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BackendlessWebService : NSObject
+ (BackendlessWebService*) sharedInstance;
- (NSDictionary*) retrieveAppMetadata;
- (NSArray*) retrieveHomeDataForConference:(NSString*)conferenceId;
- (NSArray*) retrieveProgramDataForConference:(NSString*)conferenceId;
- (NSArray*) retrieveSpeakersDataForConference:(NSString*)conferenceId;
- (NSArray*) retrieveSponsorsDataForConference:(NSString*)conferenceId;
@end
