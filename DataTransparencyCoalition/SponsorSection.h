//
//  SponsorSection.h
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/9/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SponsorSection : NSObject
@property (nonatomic, strong) NSString* sectionName;
@property (nonatomic, strong) NSArray* sectionItems;
@property (nonatomic, assign) NSInteger sectionRank;
@end
