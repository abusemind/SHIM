//
//  MSShimContextFileLogger.m
//  MDMShim
//
//  Created by Fei, Michael (Enterprise Infrastructure) on 7/25/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "MSShimContextFileLogger.h"

#import "ShimLogFileManagerBase.h"
#import "FileLoggingFormatter.h"

@implementation MSShimContextFileLogger

- (instancetype) initWithContextName: (NSString *) contextName context: (int) ctx
{
    if(!contextName) contextName = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*) kCFBundleIdentifierKey];
    if(ctx < 0) ctx = 0;
    
    NSString *logsDirectory = [[ShimLogFileManagerBase rootLogsDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%i", ctx]];
    ShimLogFileManagerBase *fileManager = [[ShimLogFileManagerBase alloc] initWithLogsDirectory:logsDirectory contextName:contextName context:ctx];
    
    if(self = [super initWithLogFileManager:fileManager]){
        _contextName = contextName;
        _context = ctx;
        
        FileLoggingFormatter *contextFormatter = [[FileLoggingFormatter alloc] initWithContextName:contextName];;
        [self setLogFormatter:contextFormatter];
    }
    
    return self;
}

//Override
- (void)logMessage:(DDLogMessage *)logMessage
{
    //if context is zero, the logger is MDM Shim wide logger that should log everything
    if(logMessage->logContext != _context) //skip
        return;
    
    [super logMessage:logMessage];
}



@end
