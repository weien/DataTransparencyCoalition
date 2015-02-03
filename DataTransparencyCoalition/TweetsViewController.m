//
//  TweetsViewController.m
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/2/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import "TweetsViewController.h"
#import "DTCUtil.h"
#import "Constants.h"

@interface TweetsViewController()
@property (strong, nonatomic) IBOutlet UIWebView *mainWebView;
@property (strong, nonatomic) NSDictionary *conferenceMetadata;

@end

@implementation TweetsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.conferenceMetadata = [DTCUtil plistDataWithComponent:kPlistComponentForConferenceMetadata];
    [self.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.conferenceMetadata[@"tweetURL"]]]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"Tweets";
}

@end
