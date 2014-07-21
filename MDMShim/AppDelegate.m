//
//  AppDelegate.m
//  MDMShim
//
//  Created by Michael Fei on 7/11/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "AppDelegate.h"
#import "AuthManager.h"

#import "MSPasteboardSharedLogger.h"

@interface AppDelegate()

@property (nonatomic, strong) NSTimer* touchIdleTimer;

@end

@implementation AppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#if !TARGET_IPHONE_SIMULATOR
    [MSPasteboardSharedLogger enable];
#endif
    
    [[AuthManager defaultManager] startIdleTimer];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[AuthManager defaultManager] stopIdleTimer];
}

@end
