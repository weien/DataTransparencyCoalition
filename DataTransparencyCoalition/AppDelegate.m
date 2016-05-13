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
#import <ParseUI/ParseUI.h>
#import "PrivateKeys.h"
#import "DTCUtil.h"
#import <Crashlytics/Crashlytics.h>
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>
#import "Backendless.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //[Crashlytics startWithAPIKey:kCRASHLYTICS_API_KEY];
    [Fabric with:@[[Crashlytics class], [Twitter class]]];
    
    [Parse setApplicationId:kPARSE_APPLICATION_ID
                  clientKey:kPARSE_CLIENT_KEY];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [PFImageView class];
    
    [[Backendless sharedInstance] initApp:kBACKENDLESS_APPLICATION_ID secret:kBACKENDLESS_SECRET_KEY version:@"v1"];
    
    // Register for Push Notitications
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
    else {
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert];
    }
    
    [[UITabBar appearance] setTintColor:[UIColor orangeColorSun]];
    [[UITabBar appearance] setBarTintColor:[UIColor grayColorVeryDark]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[DTCUtil currentBoldFontWithSize:21]}];
    [[UINavigationBar appearance] setTintColor:[UIColor orangeColorSun]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor grayColorVeryDark]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[@"global"];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //we'll do some "smart push" later
    [PFPush handlePush:userInfo];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    if (currentInstallation.badge != 0) {
        currentInstallation.badge = 0;
        [currentInstallation saveEventually];
    }
}

@end
