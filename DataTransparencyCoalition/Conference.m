#import "Backendless.h"
#import "Conference.h"

@implementation Conference

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.objectId = [decoder decodeObjectForKey:@"objectId"];
        self.conferenceDate = [decoder decodeObjectForKey:@"conferenceDate"];
        self.location = [decoder decodeObjectForKey:@"location"];
        self.mapURL = [decoder decodeObjectForKey:@"mapURL"];
        self.hashtag = [decoder decodeObjectForKey:@"hashtag"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.tweetURL = [decoder decodeObjectForKey:@"tweetURL"];
        self.conferenceURL = [decoder decodeObjectForKey:@"conferenceURL"];
        self.coalitionURL = [decoder decodeObjectForKey:@"coalitionURL"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.objectId forKey:@"objectId"];
    [encoder encodeObject:self.conferenceDate forKey:@"conferenceDate"];
    [encoder encodeObject:self.location forKey:@"location"];
    [encoder encodeObject:self.mapURL forKey:@"mapURL"];
    [encoder encodeObject:self.hashtag forKey:@"hashtag"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.tweetURL forKey:@"tweetURL"];
    [encoder encodeObject:self.conferenceURL forKey:@"conferenceURL"];
    [encoder encodeObject:self.coalitionURL forKey:@"coalitionURL"];
}
@end