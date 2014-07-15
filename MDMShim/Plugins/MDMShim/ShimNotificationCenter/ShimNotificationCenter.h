//
//  ShimNotificationCenter.h
//  Employee Mobile Shim
//
//  Created by Fei, Michael (Enterprise Infrastructure) on 4/3/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import <Cordova/CDV.h>

typedef NS_ENUM(NSInteger, AlertBannerType)
{
    AlertBannerTypeError = -1,
    AlertBannerTypeSuccess = 0,
    AlertBannerTypeInfo = 1
};


@interface ShimNotificationCenter : CDVPlugin

- (void) show:(CDVInvokedUrlCommand *)command;
- (void) dismiss:(CDVInvokedUrlCommand *)command;
- (void) showSuccess:(CDVInvokedUrlCommand *)command; //auto dismiss
- (void) showError:(CDVInvokedUrlCommand *)command;   //auto dismiss


- (void) alert: (CDVInvokedUrlCommand *)command;

@end
