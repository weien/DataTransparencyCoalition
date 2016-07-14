#import <Foundation/Foundation.h>

@class Conference;

@interface Program : NSObject <NSCoding>
@property (nonatomic, strong) NSString *speakerName;
@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSDate *time;
@property (nonatomic, strong) NSString *speakerTitles;
@property (nonatomic, strong) Conference *conference;
@end