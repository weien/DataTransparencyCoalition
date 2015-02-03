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
    
    self.spinner = [self startSpinner:self.spinner inView:self.view];
    dispatch_async(dispatch_queue_create("decideMetaData", NULL), ^{
        NSDictionary* metadata = [[ParseWebService sharedInstance] retrieveMetaData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self stopSpinner:self.spinner];
            if (metadata[@"conferenceModeEnabled"]) {
                [DTCUtil saveDataToPlistWithComponent:kPlistComponentForConferenceMetadata andDictionaryOfInfo:metadata];
                UIViewController* newVC = [[DTCUtil currentStoryboard] instantiateViewControllerWithIdentifier:@"ConferenceTabBarController"];
                newVC.transitioningDelegate = self;
                newVC.modalPresentationStyle = UIModalPresentationCustom;
                [self presentViewController:newVC animated:YES completion:nil];
            }
            else {
                
            }
        });
    });
}

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



