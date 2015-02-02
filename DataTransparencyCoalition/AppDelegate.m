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
#import "PrivateKeys.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Parse setApplicationId:kPARSE_APPLICATION_ID
                  clientKey:kPARSE_CLIENT_KEY];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [[UITabBar appearance] setTintColor:[UIColor orangeColorSun]];
    [[UITabBar appearance] setBarTintColor:[UIColor grayColorVeryDark]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor:[UIColor orangeColorSun]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor grayColorVeryDark]];
    return YES;
}

@end
