//
//  ShimNotificationCenter.m
//  Employee Mobile Shim
//
//  Created by Fei, Michael (Enterprise Infrastructure) on 4/3/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "ShimNotificationCenter.h"
#import "SVProgressHUD.h"
#import "ALAlertBanner.h"

@implementation ShimNotificationCenter

- (void) show:(CDVInvokedUrlCommand *)command
{
    id message = [command argumentAtIndex:0];
    
    if([message isKindOfClass:[NSString class]])
    {
        dispatch_async(dispatch_get_main_queue(), ^(){
            
            [SVProgressHUD showWithStatus:(NSString*) message];
            
            //force it to disappear after some time
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            
        });
    }
}

- (void) dismiss:(CDVInvokedUrlCommand *)command
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void) showSuccess:(CDVInvokedUrlCommand *)command
{
    id message = [command argumentAtIndex:0];
    
    if([message isKindOfClass:[NSString class]])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD showSuccessWithStatus:(NSString*) message];
            
            //force it to disappear after some time
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            
        });
    }
}

- (void) showError:(CDVInvokedUrlCommand *)command
{
    id message = [command argumentAtIndex:0];
    
    if([message isKindOfClass:[NSString class]])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD showErrorWithStatus:(NSString*) message];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            
        });
    }
}

- (void) alert: (CDVInvokedUrlCommand *)command
{
    int type = [[command argumentAtIndex:0] intValue];
    NSString *title = [command argumentAtIndex:1];
    NSString *subtitle = [command argumentAtIndex:2];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        ALAlertBannerStyle style = ALAlertBannerStyleSuccess;
        switch (type) {
            case AlertBannerTypeSuccess:
                style = ALAlertBannerStyleSuccess;
                break;
            case AlertBannerTypeError:
                style = ALAlertBannerStyleFailure;
                break;
            case AlertBannerTypeInfo:
                style = ALAlertBannerStyleNotify;
                break;
            default:
                style = ALAlertBannerStyleWarning;
                break;
        }
        
        ALAlertBanner *banner = [ALAlertBanner alertBannerForView:self.webView
                                                            style:style
                                                         position:ALAlertBannerPositionBottom
                                                            title:title
                                                         subtitle:subtitle
                                                      tappedBlock:^(ALAlertBanner *alertBanner) {
                                                          [alertBanner hide];
                                                      }];
        banner.secondsToShow = 2.75f;
        banner.showAnimationDuration = 0.25f;
        banner.hideAnimationDuration = 0.2f;
        [banner show];
    });
}

@end
