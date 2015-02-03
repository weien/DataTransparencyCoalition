//
//  ParseUtil.h
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/2/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseWebService : NSObject
+ (ParseWebService*) sharedInstance;
- (NSDictionary*) retrieveMetaData;
- (NSArray*) retrieveProgramDataForConference:(NSString*)conferenceId;
@end
