//
//  UIViewController+DTC.m
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/2/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import "UIViewController+DTC.h"

@implementation UIViewController (DTC)
- (UIActivityIndicatorView*) startSpinner:(UIActivityIndicatorView*)spinner inView:(UIView*)view {
    if (!spinner) {
        spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.hidesWhenStopped = YES;
    }
    UIView* desiredSuperview = view;
    if (view.superview) {
        desiredSuperview = view.superview;
    }
    [desiredSuperview addSubview:spinner];
    spinner.center = view.center;
    
    
    [spinner startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    return spinner;
}

- (void) stopSpinner:(UIActivityIndicatorView*)spinner {
    [spinner stopAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
@end
