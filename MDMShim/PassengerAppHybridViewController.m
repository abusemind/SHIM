//
//  PassengerAppHybridViewController.m
//  MDMShim
//
//  Created by Michael Fei on 7/12/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "PassengerAppHybridViewController.h"

@interface PassengerAppHybridViewController ()

@end

@implementation PassengerAppHybridViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        // Custom initialization
    }
    
    return self;
}

/**
 Override
 */
- (void)createGapView
{
    [super createGapView];

    [self.webView setDataDetectorTypes:UIDataDetectorTypeAll];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setPassengerApp:(MDMApplication *)passengerApp
{
    _passengerApp = passengerApp;
    
    if(![passengerApp.url hasPrefix:@"http"])
    {
        self.startPage = [NSString stringWithFormat:@"http://%@", passengerApp.url];
    }
    else{
        self.startPage = passengerApp.url;
    }
    
    self.wwwFolderName = @"";
}

#pragma mark - UIWebView

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL shouldLoad = [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    if([request.URL.path hasPrefix:@"The prefix indicates a redirect to login screen"]) {
        //Present re-auth screen
        return NO;
    }
    
    return shouldLoad;
}

@end
