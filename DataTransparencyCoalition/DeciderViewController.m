//
//  DeciderViewController.m
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/2/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import "DeciderViewController.h"
#import "ParseWebService.h"
#import "UIViewController+DTC.h"
#import "Constants.h"
#import "DTCUtil.h"
#import "UIColor+Custom.h"
#import "TLTransitionAnimator.h"
#import "WWReachability.h"

@interface DeciderViewController() <UIViewControllerTransitioningDelegate>
@property (strong, nonatomic) UIActivityIndicatorView* spinner;
@end

@implementation DeciderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColorSun];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //TODO: We should check somewhere if it's a new conference; if so, wipe out the old conference data
    
    WWReachability* reach = [WWReachability reachabilityForInternetConnection];
    if ([reach isReachable]) {
        self.spinner = [self startSpinner:self.spinner inView:self.view];
        dispatch_async(dispatch_queue_create("decideMetaData", NULL), ^{
            NSDictionary* metadata = [[ParseWebService sharedInstance] retrieveMetaData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self stopSpinner:self.spinner];
                if (metadata[@"conferenceModeEnabled"]) {
                    [DTCUtil archiveWithComponent:kPlistComponentForConferenceMetadata andInfo:metadata];
                    [self goToConferenceHome];
                }
                else {
                    
                }
            });
        });
    }
    else {
        //we're offline. As long as we have old metadata, just run with that.
        NSDictionary* oldMetadata = [DTCUtil unarchiveWithComponent:kPlistComponentForConferenceMetadata];
        if (oldMetadata) {
            if (oldMetadata[@"conferenceModeEnabled"]) {
                [self goToConferenceHome];
            }
            else {
                
            }
        }
        else {
            UILabel* offlineLabel = [[UILabel alloc] initWithFrame:self.view.frame];
            offlineLabel.font = [DTCUtil currentMainFontWithSize:20];
            offlineLabel.numberOfLines = 2;
            offlineLabel.textAlignment = NSTextAlignmentCenter;
            offlineLabel.textColor = [UIColor grayColorVeryDark];
            offlineLabel.text = @"Please check your internet connection.";
            [self.view addSubview:offlineLabel];
        }
    }
}

- (void) goToConferenceHome {
    UIViewController* newVC = [[DTCUtil currentStoryboard] instantiateViewControllerWithIdentifier:@"ConferenceTabBarController"];
    newVC.transitioningDelegate = self;
    newVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:newVC animated:YES completion:nil];
}

//thanks http://www.teehanlax.com/blog/custom-uiviewcontroller-transitions/
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    TLTransitionAnimator *animator = [TLTransitionAnimator new];
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    TLTransitionAnimator *animator = [TLTransitionAnimator new];
    return animator;
}
@end



