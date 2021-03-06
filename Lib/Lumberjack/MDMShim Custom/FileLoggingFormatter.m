//
//  MDMShimLoggingFormatter.m
//  MDMShim
//
//  Created by Fei, Michael (Enterprise Infrastructure) on 7/22/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "FileLoggingFormatter.h"
#import <libkern/OSAtomic.h>

/**
 https://github.com/CocoaLumberjack/CocoaLumberjack/wiki/CustomFormatters
 */
@interface FileLoggingFormatter()
{
    int atomicLoggerCount;
    NSDateFormatter *threadUnsafeDateFormatter;
}

@end

@implementation FileLoggingFormatter

-(instancetype) initWithContextName: (NSString *) contextName
{
    if(self = [super init]){
        _contextName = contextName;
    }
    
    return self;
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    NSString *logLevel;
    NSString *filename;
    int       lineNumber;
    NSString *timestamp;
    
    filename = [[NSString stringWithCString:logMessage->file encoding:NSUTF8StringEncoding] lastPathComponent];
    lineNumber = logMessage->lineNumber;
    timestamp = [self stringFromDate:logMessage->timestamp];
    
    switch (logMessage->logFlag)
    {
        case LOG_FLAG_ERROR :
            logLevel = @"E";
            break;
        case LOG_FLAG_WARN  :
            logLevel = @"W";
            break;
        case LOG_FLAG_INFO  :
            logLevel = @"I";
            break;
        case LOG_FLAG_DEBUG :
            logLevel = @"D";
            break;
        default             :
            logLevel = @"V";
            break;
    }
    
    if(!self.contextName)
        return [NSString stringWithFormat:@"%@|%@#%i %@| %@", logLevel, filename, lineNumber, timestamp, logMessage->logMsg];
    else
        return [NSString stringWithFormat:@"%@|%@|[%@] %@#%i| %@", timestamp, logLevel, self.contextName, filename, lineNumber, logMessage->logMsg];
}

- (void)didAddToLogger:(id <DDLogger>)logger
{
    OSAtomicIncrement32(&atomicLoggerCount);
}
- (void)willRemoveFromLogger:(id <DDLogger>)logger
{
    OSAtomicDecrement32(&atomicLoggerCount);
}

#pragma mark - Private Methods
- (NSString *)stringFromDate:(NSDate *)date
{
    int32_t loggerCount = OSAtomicAdd32(0, &atomicLoggerCount);
    
    if (loggerCount <= 1)
    {
        // Single-threaded mode.
        
        if (threadUnsafeDateFormatter == nil)
        {
            threadUnsafeDateFormatter = [[NSDateFormatter alloc] init];
            [threadUnsafeDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
            [threadUnsafeDateFormatter setDateFormat:@"yy/MM/dd HH:mm:ss:SS"];
        }
        
        return [threadUnsafeDateFormatter stringFromDate:date];
    }
    else
    {
        // Multi-threaded mode.
        // NSDateFormatter is NOT thread-safe.
        
        NSString *key = @"MyCustomFormatter_NSDateFormatter";
        
        NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
        NSDateFormatter *dateFormatter = [threadDictionary objectForKey:key];
        
        if (dateFormatter == nil)
        {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
            [dateFormatter setDateFormat:@"yy/MM/dd HH:mm:ss:SS"];
            
            [threadDictionary setObject:dateFormatter forKey:key];
        }
        
        return [dateFormatter stringFromDate:date];
    }
}

@end
