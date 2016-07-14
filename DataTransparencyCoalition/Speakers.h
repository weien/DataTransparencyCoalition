#import <Foundation/Foundation.h>

@class Conference;

@interface Speakers : NSObject
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *bio;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) Conference *conference;
@end