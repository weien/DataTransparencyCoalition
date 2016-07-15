#import "Backendless.h"
#import "Program.h"

@implementation Program

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.speakerName = [decoder decodeObjectForKey:@"speakerName"];
        self.eventName = [decoder decodeObjectForKey:@"eventName"];
        self.time = [decoder decodeObjectForKey:@"time"];
        self.speakerTitles = [decoder decodeObjectForKey:@"speakerTitles"];
        self.conference = [decoder decodeObjectForKey:@"conference"];
        self.isSupport = [decoder decodeBoolForKey:@"isSupport"];
        self.isSponsor = [decoder decodeBoolForKey:@"isSponsor"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.speakerName forKey:@"speakerName"];
    [encoder encodeObject:self.eventName forKey:@"eventName"];
    [encoder encodeObject:self.time forKey:@"time"];
    [encoder encodeObject:self.speakerTitles forKey:@"speakerTitles"];
    [encoder encodeObject:self.conference forKey:@"conference"];
    [encoder encodeBool:self.isSupport forKey:@"isSupport"];
    [encoder encodeBool:self.isSponsor forKey:@"isSponsor"];
}

@end