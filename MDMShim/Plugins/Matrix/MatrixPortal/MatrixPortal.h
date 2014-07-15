//
//  MatrixPortal.h
//  MS Mobile
//
//  Created by Kwan, Mike (ISGT) on 15/04/2014.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import <Cordova/CDV.h>

@interface MatrixPortal : CDVPlugin

- (void)putGlobalData:(CDVInvokedUrlCommand *)command;
- (void)getGlobalData:(CDVInvokedUrlCommand *)command;

- (void)reauthSucceeded:(CDVInvokedUrlCommand *)command;
- (void)showWelcomeScreen:(CDVInvokedUrlCommand *)command;

- (void)refreshOrientation:(CDVInvokedUrlCommand *)command;

@end
