#import "Backendless.h"
#import "Speakers.h"

@implementation Speakers

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.lastName = [decoder decodeObjectForKey:@"lastName"];
        self.picture = [decoder decodeObjectForKey:@"picture"];
        self.bio = [decoder decodeObjectForKey:@"bio"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.firstName = [decoder decodeObjectForKey:@"firstName"];
        self.conference = [decoder decodeObjectForKey:@"conference"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.lastName forKey:@"lastName"];
    [encoder encodeObject:self.picture forKey:@"picture"];
    [encoder encodeObject:self.bio forKey:@"bio"];
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.firstName forKey:@"firstName"];
    [encoder encodeObject:self.conference forKey:@"conference"];
}

@end