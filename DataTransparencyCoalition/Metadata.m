//
//  Metadata.m
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 5/13/16.
//  Copyright © 2016 Data Transparency Coalition. All rights reserved.
//

#import "Metadata.h"

@implementation Metadata

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.currentConference = [decoder decodeObjectForKey:@"currentConference"];
        self.conferenceModeEnabled = [decoder decodeBoolForKey:@"conferenceModeEnabled"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.currentConference forKey:@"currentConference"];
    [encoder encodeBool:self.conferenceModeEnabled forKey:@"conferenceModeEnabled"];
}
@end
