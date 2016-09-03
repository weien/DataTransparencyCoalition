//
//  ProgramSection.h
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/3/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProgramSection : NSObject
@property (nonatomic, strong) NSString* sectionName;
@property (nonatomic, strong) NSDate* sectionTime;
@property (nonatomic, strong) NSArray* sectionItems;
@property (nonatomic, strong) NSString* sectionSponsor;

@end
