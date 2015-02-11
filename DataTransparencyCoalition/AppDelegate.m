//
//  AppDelegate.m
//  DataTransparencyCoalition
//
//  Created by Weien Wang on 2/2/15.
//  Copyright (c) 2015 Data Transparency Coalition. All rights reserved.
//

#import "AppDelegate.h"
#import "UIColor+Custom.h"
#import <Parse/Parse.h>
#import <ParseCrashReporting/ParseCrashReporting.h>
#import "PrivateKeys.h"
#import "DTCUtil.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [ParseCrashReporting enable];
    [Parse setApplicationId:kPARSE_APPLICATION_ID
                  clientKey:kPARSE_CLIENT_KEY];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [[UITabBar appearance] setTintColor:[UIColor orangeColorSun]];
    [[UITabBar appearance] setBarTintColor:[UIColor grayColorVeryDark]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[DTCUtil currentBoldFontWithSize:21]}];
    [[UINavigationBar appearance] setTintColor:[UIColor orangeColorSun]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor grayColorVeryDark]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    return YES;
}

@end
