#import <Foundation/Foundation.h>

@class Conference;

@interface Sponsors : NSObject
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSNumber *categoryRank;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Conference *conference;
@end