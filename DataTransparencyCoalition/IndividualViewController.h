//
//  IndividualViewController.h
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/6/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Speakers.h"

@interface IndividualViewController : UIViewController
@property (nonatomic, strong) Speakers* speakerData;
@property (nonatomic, strong) UIImage* speakerImage;
@end
