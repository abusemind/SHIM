//
//  PassengerAppHybridViewController.m
//  MDMShim
//
//  Created by Michael Fei on 7/12/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "PassengerAppHybridViewController.h"
#import "PopupView.h"
#import "WelcomeScreenViewController.h"
#import "ALAlertBanner.h"
#import "MSShimContextFileLogger.h"

@interface PassengerAppHybridViewController () <UIScrollViewDelegate>
{
    UIButton *_menuBtn;
    BOOL _isScrolling;
    
    UIImage *_home;
    UIImage *_apps;
    UIImage *_logout;
}

@property (strong, nonatomic) MDMApplication *nextPassengerAppToOpen;

@end

@implementation PassengerAppHybridViewController

#pragma mark - Setup
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.scrollView.delegate = self;
    
    _home = [[UIImage imageNamed:@"home.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _apps = [[UIImage imageNamed:@"apps.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _logout = [[UIImage imageNamed:@"logout.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [self installPassengerAppLogger];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setupMenuButton];
    });
}

- (void)createGapView
{
    [super createGapView];
    
    [self.webView setDataDetectorTypes:UIDataDetectorTypeAll];
}

#pragma mark - logger
- (void) installPassengerAppLogger
{
    DDFileLogger *passengerAppLogger = [[MSShimContextFileLogger alloc] initWithContextName:self.passengerApp.name context:self.passengerApp.appId];
    passengerAppLogger.rollingFrequency = 60 * 60 ; // 1 hour rolling
    passengerAppLogger.logFileManager.maximumNumberOfLogFiles = 24; //for a whole day
    [DDLog addLogger:passengerAppLogger withLogLevel:LOG_LEVEL_DEBUG];
}

- (void) uninstallPassengerAppLogger
{
    NSArray *loggers = [DDLog allLoggers];
    for(id <DDLogger> logger in loggers)
    {
        if([logger isKindOfClass:[MSShimContextFileLogger class]]){
            MSShimContextFileLogger *contextAwaredLogger = (MSShimContextFileLogger *)logger;
            
            if(contextAwaredLogger.context == self.passengerApp.appId)
            {
                [DDLog removeLogger:contextAwaredLogger];
            }
        }
    }
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
    if([request.URL.path hasPrefix:@"TODO:The prefix indicates a redirect to login screen"]) {
        //Present re-auth screen
        return NO;
    }
    
    return shouldLoad;
}

#pragma mark - Menu & Menu's actions
- (void) setupMenuButton
{
    if(_menuBtn == nil)
    {
        _menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_menuBtn addTarget:self action:@selector(hitMenuButtonOnWebView:)
           forControlEvents:UIControlEventTouchUpInside];
        
        [_menuBtn setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
        
        CGFloat size = CDV_IsIPad()? 52:44;
        _menuBtn.frame = CGRectMake(self.view.bounds.size.width - size - 8, self.view.bounds.size.height - size - 8, size, size);
        _menuBtn.alpha = 0.95;
        _menuBtn.tintColor = MS_DARK_BLUE_100;
        
        _menuBtn.layer.cornerRadius = 7;
        _menuBtn.layer.masksToBounds = YES;
        
        [self.view addSubview:_menuBtn];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            NSString *logMsg = [NSString stringWithFormat:@"Loading: %@", _passengerApp.url];
            MSLogInfo(_passengerApp.appId, @"%@", logMsg);
            
            ALAlertBanner *banner = [ALAlertBanner alertBannerForView:self.webView
                                                                style:ALAlertBannerStyleNotify
                                                             position:ALAlertBannerPositionBottom
                                                                title:@"Loading"
                                                             subtitle:_passengerApp.url
                                                          tappedBlock:^(ALAlertBanner *alertBanner) {
                                                              [alertBanner hide];
                                                          }];
            banner.secondsToShow = 2.75f;
            banner.showAnimationDuration = 0.25f;
            banner.hideAnimationDuration = 0.2f;
            [banner show];
        });
        
        
    }
}

-(void) hitMenuButtonOnWebView:(id) sender
{
    BTPopUpItemView *home = [[BTPopUpItemView alloc] initWithImage:_home title:@"Home" action:^{
        [self showWelcomeScreen];
    }];
    
    BTPopUpItemView *apps = [[BTPopUpItemView alloc] initWithImage:_apps title:@"Other Apps" action:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.025 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showOtherApps];
        });
    }];
    
    BTPopUpItemView *logout = [[BTPopUpItemView alloc] initWithImage:_logout title:@"Logout" action:^{
        [self logout];
    }];
    
    NSArray *items = [NSArray arrayWithObjects:home, apps, logout, nil];
    PopupView *mainMenu = [[PopupView alloc] initWithItems:items addToViewController:self];
    [self.view addSubview:mainMenu];
    [mainMenu show];
}

- (void) showWelcomeScreen
{
    MSLogInfo(_passengerApp.appId, @"%@", @"Show welcome screen");
    
    WelcomeScreenViewController * welcomeScreen = (WelcomeScreenViewController *) self.presentingViewController;
    welcomeScreen.passengerAppToOpen = nil;
    welcomeScreen.bouncingImmediately= NO;
    
    [self performSegueWithIdentifier:SEGUE_WELCOME_SCREEN sender:self];
}

- (void) showOtherApps
{
    MSLogInfo(_passengerApp.appId, @"%@", @"List all other app");
    
    if(self.allApps == nil || [self.allApps count] == 0){
        DDLogWarn(@"%@", @"No other apps are currently available");
        return;
    }
    
    UIImage *placeholderImageForPassengerApps = [UIImage imageNamed:@"application.png"];
    NSMutableArray *menuItems = [NSMutableArray new];
    for(MDMApplication *app in self.allApps){
        if(self.passengerApp.appId == app.appId)
        {
            continue;
        }
        
        BTPopUpItemView *menuItem =
            [[BTPopUpItemView alloc] initWithImageURL:[NSURL URLWithString:app.iconUrl]
                                     placeholderImage:placeholderImageForPassengerApps
                                                title:app.name
                                               action:^{
            
            WelcomeScreenViewController * welcomeScreen = (WelcomeScreenViewController *) self.presentingViewController;
            welcomeScreen.passengerAppToOpen = app;
            welcomeScreen.bouncingImmediately= YES;
            
            [self performSegueWithIdentifier:SEGUE_WELCOME_SCREEN sender:self];
        }];
        
        [menuItems addObject:menuItem];
    }
    
    PopupView *mainMenu = [[PopupView alloc] initWithItems:menuItems addToViewController:self];
    [self.view addSubview:mainMenu];
    [mainMenu show];
}

- (void) logout
{
    DDLogWarn(@"TODO: %@", @"Logout");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //remove passenger app logger before performing any segue (which would cause leaving the app)
    [self uninstallPassengerAppLogger];
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
    rect.origin.x = self.view.bounds.size.width  - rect.size.width  - 8;
    rect.origin.y = self.view.bounds.size.height - rect.size.height - 8;
    _menuBtn.frame = rect;
    
    _menuBtn.userInteractionEnabled = YES;
    _menuBtn.hidden = NO;
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _menuBtn.userInteractionEnabled = NO;
    _menuBtn.hidden = YES;
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate){
        _menuBtn.userInteractionEnabled = YES;
        _menuBtn.hidden = NO;
    }
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _menuBtn.userInteractionEnabled = YES;
    _menuBtn.hidden = NO;
}

@end
