//
//  TLTransitionAnimator.m
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/2/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import "TLTransitionAnimator.h"

@implementation TLTransitionAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.2f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect toVCStartingFrame = CGRectMake(CGRectGetWidth(fromViewController.view.frame), 0, CGRectGetWidth(fromViewController.view.frame), CGRectGetHeight(fromViewController.view.frame));
    
    CGRect toVCEndingFrame = fromViewController.view.frame;
    
    fromViewController.view.userInteractionEnabled = NO;
    
    [transitionContext.containerView addSubview:fromViewController.view];
    [transitionContext.containerView addSubview:toViewController.view];
    
    toViewController.view.alpha = 0;
    toViewController.view.frame = toVCStartingFrame;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:.5 options:0 animations:^{
        toViewController.view.frame = toVCEndingFrame;
        toViewController.view.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
