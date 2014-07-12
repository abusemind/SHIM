//
//  PassengerAppHybridViewController.m
//  MDMShim
//
//  Created by Michael Fei on 7/12/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "PassengerAppHybridViewController.h"
#import "btSimplePopUP.h"

@interface PassengerAppHybridViewController () <UIScrollViewDelegate>
{
    UIButton *_menuBtn;
    BOOL _isScrolling;
    
    UIImage *_home;
    UIImage *_apps;
    UIImage *_logout;
}
@end

@implementation PassengerAppHybridViewController

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
    
    self.webView.scrollView.delegate = self;
    
    _home = [[UIImage imageNamed:@"home.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _apps = [[UIImage imageNamed:@"apps.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _logout = [[UIImage imageNamed:@"logout.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [self setupMenuButton];
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

#pragma mark - Menu
- (void) setupMenuButton
{
    _menuBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_menuBtn addTarget:self action:@selector(hitMenuButtonOnWebView:)
                forControlEvents:UIControlEventTouchUpInside];
    
    [_menuBtn setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    
    CGFloat size = CDV_IsIPad()? 36:28;
    _menuBtn.frame = CGRectMake(10, self.view.bounds.size.height - size - 10, size, size);
    _menuBtn.alpha = 0.75;
    [self.view addSubview:_menuBtn];
}

-(void) hitMenuButtonOnWebView:(id) sender
{
    BTPopUpItemView *home = [[BTPopUpItemView alloc] initWithImage:_home title:@"Home" action:^{
        [self performSegueWithIdentifier:@"welcomeScreen" sender:self];
    }];
    
    BTPopUpItemView *apps = [[BTPopUpItemView alloc] initWithImage:_apps title:@"Other Apps" action:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showOtherApps];
        });
    }];
    
    BTPopUpItemView *logout = [[BTPopUpItemView alloc] initWithImage:_logout title:@"Logout" action:^{
        [self logout];
    }];
    
    NSArray *items = [NSArray arrayWithObjects:home, apps, logout, nil];
    btSimplePopUP *mainMenu = [[btSimplePopUP alloc] initWithItems:items addToViewController:self];
    [self.view addSubview:mainMenu];
    [mainMenu show];
}

- (void) showMainMenu
{
    
    
    
    
}

- (void) showOtherApps
{
    NSLog(@"Show Other apps");
}

- (void) logout
{
    NSLog(@"Logout");
}

#pragma mark - rotate
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    _menuBtn.userInteractionEnabled = NO;
    _menuBtn.hidden = YES;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    CGRect rect = _menuBtn.frame;
    rect.origin.x = 10;
    rect.origin.y = self.view.bounds.size.height - rect.size.height - 10;
    _menuBtn.frame = rect;
    
    _menuBtn.userInteractionEnabled = YES;
    _menuBtn.hidden = NO;
    
}

#pragma mark - Scroll View
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _menuBtn.userInteractionEnabled = NO;
    _menuBtn.hidden = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _menuBtn.userInteractionEnabled = YES;
    _menuBtn.hidden = NO;
}

@end
