//
//  MDMShimRemoteLogger.m
//  MDMShim
//
//  Created by Fei, Michael (Enterprise Infrastructure) on 7/22/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "RemoteLogger.h"

@implementation RemoteLogger

- (void)logMessage:(DDLogMessage *)logMessage
{
    NSString *logMsg = logMessage->logMsg;
    
    if (self->formatter)
        logMsg = [self->formatter formatLogMessage:logMessage];
    
    if (logMsg)
    {
        // Post to server
        //NSLog(@"Remote!: %@", logMsg);
#warning TODO: send logMsg to remote server via POST
    }
}

@end
