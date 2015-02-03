//
//  DeciderViewController.m
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/2/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import "DeciderViewController.h"
#import "ParseWebService.h"

@implementation DeciderViewController

- (void)viewDidLoad {
//    if (![DTCUtil plistDataWithComponent:kPlistComponentForConferenceMetadata]) {
        [[ParseWebService sharedInstance] retrieveMetaData];
//    }
}

@end
