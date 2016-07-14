//
//  Metadata.h
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 5/13/16.
//  Copyright © 2016 Data Transparency Coalition. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Conference;

@interface Metadata : NSObject <NSCoding>
@property (nonatomic, strong) Conference *currentConference;
@property (nonatomic, assign) BOOL conferenceModeEnabled;

@end
