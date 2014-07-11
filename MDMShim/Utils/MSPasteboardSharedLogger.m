//
//  MSPasteboardSharedLogger.h
//  MDMShim
//
//  Created by Michael Fei on 7/11/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "MSPasteboardSharedLogger.h"
#import <UIKit/UIKit.h>

static FILE *file;
static NSString *const fileName = @"mobile-dev-mdmshim.log";
static NSString *const sharedID = @"mobile-dev-mdmshim";


@implementation MSPasteboardSharedLogger

+ (NSString *)documentsDir
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if([paths count] > 0) {
        return [paths objectAtIndex:0];
    }
    
    return nil;
}

+ (const char *)filePath
{
    return strdup([[[self documentsDir] stringByAppendingPathComponent:fileName] UTF8String]);
}

+ (void)setup
{
    const char *filePath = [self filePath];
    file = fopen(filePath, "a");
    
    //redirect NSLog
    dup2(fileno(file), STDERR_FILENO);
}

+ (void)enable
{
    [self setup];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(fetchLogs:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(flushLogs:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

+ (BOOL)isSentinelValue:(NSString *)log
{
    return [log isEqualToString:@" "];
}

+ (void)fetchLogs:(NSNotification *)notification
{
    @synchronized(self) {
        UIPasteboard *pasteboard = [UIPasteboard pasteboardWithName:sharedID create:YES];
        [pasteboard setPersistent:YES];
        
        //read
        NSString *log = [pasteboard string];
        if([self isSentinelValue:log]) {
            remove([self filePath]);
            [self setup];
        }
    }
}

+ (void)flushLogs:(NSNotification *)notification
{
    @synchronized(self) {
        NSString *log = [NSString stringWithContentsOfFile:[NSString stringWithUTF8String:[self filePath]] encoding:NSUTF8StringEncoding error:nil];
        UIPasteboard *pasteboard = [UIPasteboard pasteboardWithName:sharedID create:YES];
        [pasteboard setPersistent:YES];
        
        //write
        [pasteboard setString:log];
    }
}

@end
