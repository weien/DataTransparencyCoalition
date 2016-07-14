//
//  Home.m
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 5/13/16.
//  Copyright © 2016 Data Transparency Coalition. All rights reserved.
//

#import "Home.h"

@implementation Home

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.rank = [decoder decodeObjectForKey:@"rank"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.url = [decoder decodeObjectForKey:@"url"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.rank forKey:@"rank"];
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.url forKey:@"url"];
}

@end
