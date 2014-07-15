//
//  MatrixPortal.m
//  MS Mobile
//
//  Created by Kwan, Mike (ISGT) on 15/04/2014.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "MatrixPortal.h"
//#import "AppSettings.h"
//#import "Navigable.h"
//#import "MSConfig.h"

@implementation MatrixPortal

- (void)putGlobalData:(CDVInvokedUrlCommand *)command
{
//    NSString *key = command.arguments[0];
//    NSString *value = command.arguments[1];
//    
//    [AppSettings putGlobalDataWithKey:key value:value];
    DLog(@"Not implemented");
}

- (void)getGlobalData:(CDVInvokedUrlCommand *)command
{
//    NSString *key = command.arguments[0];
//    
//    NSString *value = [AppSettings globalDataForKey:key];
//    NSMutableDictionary *result = [@{@"key" : key} mutableCopy];
//    if(value) {
//        result[@"value"] = value;
//    }
//    
//    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
//    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    DLog(@"Not implemented");
}

- (void)reauthSucceeded:(CDVInvokedUrlCommand *)command
{
//    NSURL *loginSuccessUrl = [NSURL URLWithString:[MSConfig loginSuccessUrl]];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:loginSuccessUrl]];
    DLog(@"Not implemented");
}

- (void)showWelcomeScreen:(CDVInvokedUrlCommand *)command
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"launchWelcome" object:nil];
    DLog(@"Not implemented");
}

- (void)refreshOrientation:(CDVInvokedUrlCommand *)command
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"setSupportedOrientation" object:command.arguments];
    DLog(@"Not implemented");
}

@end
