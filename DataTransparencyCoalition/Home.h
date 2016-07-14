//
//  Home.h
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 5/13/16.
//  Copyright © 2016 Data Transparency Coalition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Home : NSObject <NSCoding>
@property (nonatomic, strong) NSNumber* rank;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* url;
@end
