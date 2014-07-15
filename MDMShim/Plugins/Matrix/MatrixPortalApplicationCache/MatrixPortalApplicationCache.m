//
//  MatrixPortalApplicationCache.m
//  MS Mobile
//
//  Created by Kwan, Mike (ISGT) on 11/06/2014.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "MatrixPortalApplicationCache.h"


@interface MatrixPortalApplicationCache ()


@end

@implementation MatrixPortalApplicationCache

- (void)pluginInitialize
{
    [super pluginInitialize];
    
    DLog(@"Not implemented");
}

- (void)cacheUrlOnDisk:(CDVInvokedUrlCommand *)command
{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSString *url = [command arguments][0];
//        BOOL success = [self.cache cacheDocumentWithUrl:url];
//        CDVPluginResult *result;
//        if(success) {
//            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
//        } else {
//            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[NSString stringWithFormat:@"Error caching file - %@", url]];
//        }
//        
//        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//    });
    DLog(@"Not implemented");
}

- (void)removeUrlFromDisk:(CDVInvokedUrlCommand *)command
{
//    NSString *url = [command arguments][0];
//    [self.cache removeDocumentWithUrl:url];
    DLog(@"Not implemented");
}

- (void)hasUrlOnDisk:(CDVInvokedUrlCommand *)command
{
//    NSString *url = [command arguments][0];
//    BOOL hasUrl = [self.cache cacheExistsForDocument:url];
//    
//    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:hasUrl ? @"true" : @"false"];
//    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    DLog(@"Not implemented");
}

@end
