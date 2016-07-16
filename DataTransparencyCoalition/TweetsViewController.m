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
#import "Metadata.h"
#import "Conference.h"

@interface TweetsViewController()
@property (strong, nonatomic) Conference *conferenceMetadata;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *composeButton;

@end

@interface TweetsViewController()

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Tweets";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    Metadata* md = [DTCUtil unarchiveWithComponent:kComponentForConferenceMetadata];
    self.conferenceMetadata = md.currentConference;
        
    self.showTweetActions = YES;
    
    TWTRAPIClient *client = [[TWTRAPIClient alloc] init];
    TWTRSearchTimelineDataSource *searchTimelineDataSource = [[TWTRSearchTimelineDataSource alloc] initWithSearchQuery:self.conferenceMetadata.hashtag APIClient:client];
    self.dataSource = searchTimelineDataSource;
}

- (IBAction)composeButtonTapped:(id)sender {
    TWTRComposer *composer = [[TWTRComposer alloc] init]; //apparently we're not allowed to reuse this https://docs.fabric.io/ios/twitter/compose-tweets.html
    
    [composer setText:self.conferenceMetadata.hashtag];
    [composer showFromViewController:self completion:^(TWTRComposerResult result) {
        if (result == TWTRComposerResultCancelled) {
            NSLog(@"Tweet composition cancelled");
        }
        else {
            NSLog(@"Sending Tweet!");
        }
    }];
}

@end
