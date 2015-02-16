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
//#import "PBWebViewController.h"
//#import "PBSafariActivity.h"

@interface TweetsViewController() //<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *mainWebView;
@property (strong, nonatomic) NSDictionary *conferenceMetadata;
//@property (strong, nonatomic) PBWebViewController* pbwVC;

@end

@implementation TweetsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.mainWebView.delegate = self;
//    
//    self.pbwVC = [PBWebViewController new];
//    PBSafariActivity *activity = [PBSafariActivity new];
//    self.pbwVC.applicationActivities = @[activity];
    
    self.conferenceMetadata = [DTCUtil plistDataWithComponent:kPlistComponentForConferenceMetadata];
    [self.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.conferenceMetadata[@"tweetURL"]]]];
    
    //use a custom web lib instead of UIWEbView
    //try https://github.com/dfmuir/KINWebBrowser
    //or https://github.com/kmikael/PBWebViewController
    
    //or maybe even
    //https://dev.twitter.com/twitter-kit/ios/show-tweets
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"Tweets";
}

@end
