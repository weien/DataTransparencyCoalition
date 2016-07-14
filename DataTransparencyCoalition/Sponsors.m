#import "Backendless.h"
#import "Sponsors.h"

@implementation Sponsors

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.category = [decoder decodeObjectForKey:@"category"];
        self.picture = [decoder decodeObjectForKey:@"picture"];
        self.categoryRank = [decoder decodeObjectForKey:@"categoryRank"];
        self.url = [decoder decodeObjectForKey:@"url"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.conference = [decoder decodeObjectForKey:@"conference"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.category forKey:@"category"];
    [encoder encodeObject:self.picture forKey:@"picture"];
    [encoder encodeObject:self.categoryRank forKey:@"categoryRank"];
    [encoder encodeObject:self.url forKey:@"url"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.conference forKey:@"conference"];
}
@end