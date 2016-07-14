#import <Foundation/Foundation.h>

@interface Conference : NSObject
@property (nonatomic, strong) NSString *objectId;

@property (nonatomic, strong) NSDate *conferenceDate;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *mapURL;
@property (nonatomic, strong) NSString *hashtag;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *tweetURL;
@property (nonatomic, strong) NSString *conferenceURL;
@property (nonatomic, strong) NSString *coalitionURL;
@end