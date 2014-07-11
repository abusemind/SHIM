//
//  AppViewController.m
//  MDMShim
//
//  Created by Michael Fei on 7/12/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "BaseHybridViewController.h"

@interface BaseHybridViewController ()

@end

@implementation BaseHybridViewController

- (void)createGapView
{
    [super createGapView];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque:NO];
    [self.webView setDataDetectorTypes:UIDataDetectorTypeNone];
}

- (BOOL)isRequestTryingToLoadAnIframe:(NSURLRequest *)request
{
    return ![request.URL isEqual:request.mainDocumentURL];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if(![super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType]) {
        return NO;
    } else if([request.URL.absoluteString hasPrefix:self.startPage]) {
        return YES;
    } else if([request.URL.absoluteString hasPrefix:@"tel:"]) {
        return YES;
    } else if([request.URL.absoluteString hasPrefix:@"mailto:"]) {
        return YES;
    } else if([request.URL.absoluteString isEqualToString:@"about:blank"]) {
        return YES;
    } else if([self isRequestTryingToLoadAnIframe:request]) {
        return YES;
    }
    
    return YES;
}

@end
