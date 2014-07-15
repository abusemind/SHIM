//
//  MatrixPortalApplicationCache.h
//  MS Mobile
//
//  Created by Kwan, Mike (ISGT) on 11/06/2014.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import <Cordova/CDV.h>

@interface MatrixPortalApplicationCache : CDVPlugin

- (void)cacheUrlOnDisk:(CDVInvokedUrlCommand *)command;
- (void)removeUrlFromDisk:(CDVInvokedUrlCommand *)command;
- (void)hasUrlOnDisk:(CDVInvokedUrlCommand *)command;

@end
