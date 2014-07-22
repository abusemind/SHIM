//
//  LogFileManager.m
//  MDMShim
//
//  Created by Fei, Michael (Enterprise Infrastructure) on 7/22/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "LogFileManager.h"

@implementation LogFileManager

- (id)init
{
    return [self initWithLogsDirectory:nil];
}

- (instancetype)initWithLogsDirectory:(NSString *)aLogsDirectory
{
    if ((self = [super initWithLogsDirectory:aLogsDirectory]))
    {
        _defaultFileProtectionLevel = NSFileProtectionComplete;
    }
    return self;
}

- (NSString *)defaultLogsDirectory
{
#if TARGET_OS_IPHONE
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *baseDir = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *logsDirectory = [baseDir stringByAppendingPathComponent:@"Logs"];
    
#else
    NSString *appName = [[NSProcessInfo processInfo] processName];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
    NSString *logsDirectory = [[basePath stringByAppendingPathComponent:@"Logs"] stringByAppendingPathComponent:appName];
    
#endif
    
    return logsDirectory;
}

@end
