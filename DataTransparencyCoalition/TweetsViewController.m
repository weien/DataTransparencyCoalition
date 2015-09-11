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
#import "UIColor+Custom.h"
//#import "PBWebViewController.h"
//#import "PBSafariActivity.h"

@interface TweetsViewController() //<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *mainWebView;
@property (strong, nonatomic) NSDictionary *conferenceMetadata;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *composeButton;

//@property (strong, nonatomic) PBWebViewController* pbwVC;

@end

@interface TweetsViewController()

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Tweets";
    
    //    self.mainWebView.delegate = self;
    //
    //    self.pbwVC = [PBWebViewController new];
    //    PBSafariActivity *activity = [PBSafariActivity new];
    //    self.pbwVC.applicationActivities = @[activity];
    
    self.conferenceMetadata = [DTCUtil plistDataWithComponent:kPlistComponentForConferenceMetadata];
    
    //[self.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.conferenceMetadata[@"tweetURL"]]]];
    //use a custom web lib instead of UIWEbView
    //try https://github.com/dfmuir/KINWebBrowser
    //or https://github.com/kmikael/PBWebViewController
    
    //[self.composeButton setTitle:@"Compose" forState:UIControlStateNormal];
    //self.composeButton.frame = CGRectMake(0, 0, 60, 30);//CGRectMake(0, 0, 32, 32);
//    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.composeButton]];
    
    self.showTweetActions = YES;
    
    TWTRAPIClient *client = [[TWTRAPIClient alloc] init];
    TWTRSearchTimelineDataSource *searchTimelineDataSource = [[TWTRSearchTimelineDataSource alloc] initWithSearchQuery:self.conferenceMetadata[@"hashtag"] APIClient:client];
    self.dataSource = searchTimelineDataSource;
}

- (IBAction)composeButtonTapped:(id)sender {
}

@end
