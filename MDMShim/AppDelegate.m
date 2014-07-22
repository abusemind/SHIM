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

#import "ConsoleLoggingFormatter.h"
#import "FileLoggingFormatter.h"
#import "LogFileManager.h"
#import "RemoteLoggingFormatter.h"

@interface AppDelegate()

@property (nonatomic, strong) NSTimer* touchIdleTimer;

@end

@implementation AppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#if !TARGET_IPHONE_SIMULATOR
    //[MSPasteboardSharedLogger enable];
#endif
    
    [[AuthManager defaultManager] startIdleTimer];
    [self setupLoggingFramework];
    
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

#pragma makr - Logging
/**
 DDLogError
 DDLogWarn
 DDLogInfo (Reserved for general passenger app logging - MDMShim itself should not use this log level)
 DDLogDebug
 DDLogVerbose
 */
- (void) setupLoggingFramework
{
    //Console & Apple System Log
    ConsoleLoggingFormatter *consoleFormat = [ConsoleLoggingFormatter new];
    [DDLog addLogger:[DDASLLogger sharedInstance] withLogLevel:LOG_LEVEL_VERBOSE];
    [DDLog addLogger:[DDTTYLogger sharedInstance] withLogLevel:LOG_LEVEL_VERBOSE];
    [[DDTTYLogger sharedInstance] setLogFormatter:consoleFormat];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    //File
    FileLoggingFormatter *fileFormat = [FileLoggingFormatter new];
    LogFileManager *fileMgr = [LogFileManager new];
    DDFileLogger *fileLogger;
    fileLogger = [[DDFileLogger alloc] initWithLogFileManager:fileMgr];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [fileLogger setLogFormatter:fileFormat];
    [DDLog addLogger:fileLogger withLogLevel:LOG_LEVEL_WARN];
    //Remote (against MDM Server?)
    RemoteLoggingFormatter *remoteFormat = [RemoteLoggingFormatter new];
    RemoteLogger *remoteLogger = [RemoteLogger new];
    [remoteLogger setLogFormatter:remoteFormat];
    [DDLog addLogger:remoteLogger withLogLevel:LOG_LEVEL_INFO];
    
    //customize different colors for different log levels printed in console (ie, DDTTYLogger). Need XcodeColors Plugin pre-installed
    UIColor *verb  = [UIColor colorWithRed:135.0/255 green:135.0/255 blue:135.0/255 alpha:1];
    UIColor *debug = [UIColor blackColor];
    UIColor *info  = [UIColor colorWithRed:0/255 green:89.0/255 blue:156.0/255 alpha:1];
    UIColor *warn  = [UIColor colorWithRed:255.0/255 green:101.0/255 blue:0 alpha:1];
    UIColor *error = [UIColor colorWithRed:206.0/255 green:0 blue:0 alpha:1];
    
    [[DDTTYLogger sharedInstance] setForegroundColor:verb backgroundColor:nil forFlag:LOG_FLAG_VERBOSE];
    [[DDTTYLogger sharedInstance] setForegroundColor:debug backgroundColor:nil forFlag:LOG_FLAG_DEBUG];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor whiteColor] backgroundColor:info forFlag:LOG_FLAG_INFO];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor whiteColor] backgroundColor:warn forFlag:LOG_FLAG_WARN];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor whiteColor] backgroundColor:error forFlag:LOG_FLAG_ERROR];
    
    DDLogVerbose(@"Logging framework Verbose test");
    DDLogDebug(@"Logging framework Debug test");
    DDLogInfo(@"Logging framework Info test");
    DDLogWarn(@"Logging framework Warn test");
    DDLogError(@"Logging framework error test");
    
    
    DDLogInfo(@"Below are tests for log stored in File system:");
    NSArray *loggers = [DDLog allLoggers];
    for(id <DDLogger> logger in loggers){
        if([logger isKindOfClass:[DDFileLogger class]]){
            DDFileLogger *fileLogger = (DDFileLogger *)logger;
            
            NSArray *logPaths = [[fileLogger logFileManager] sortedLogFilePaths];
            for(NSString *path in logPaths){
                NSString *log = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
                DDLogDebug(@"\n%@", log);
            }
        }
    }
    
}

@end
