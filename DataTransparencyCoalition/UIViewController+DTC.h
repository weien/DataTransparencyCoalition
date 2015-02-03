//
//  UIViewController+DTC.h
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/2/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DTC)
- (UIActivityIndicatorView*) startSpinner:(UIActivityIndicatorView*)spinner inView:(UIView*)view;
- (void) stopSpinner:(UIActivityIndicatorView*)spinner;
@end
