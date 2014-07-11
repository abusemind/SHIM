//
//  PassengerAppHybridViewController.m
//  MDMShim
//
//  Created by Michael Fei on 7/12/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "PassengerAppHybridViewController.h"
#import "AwesomeMenu.h"
#import "AwesomeMenuItem.h"

@interface PassengerAppHybridViewController () <AwesomeMenuDelegate>
{
    AwesomeMenu *_menu;
}

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
    //setup menu
    
    [self setupMenu];
}

- (void) setupMenu
{
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
    UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
    
    AwesomeMenuItem *home = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *logout = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *otherApps = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *settings = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    
    NSArray *menus = [NSArray arrayWithObjects:home, logout, otherApps, settings, nil];
    
    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg-addbutton.png"]
                                                       highlightedImage:[UIImage imageNamed:@"bg-addbutton-highlighted.png"]
                                                           ContentImage:[UIImage imageNamed:@"icon-plus.png"]
                                                highlightedContentImage:[UIImage imageNamed:@"icon-plus-highlighted.png"]];
    
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:self.view.bounds startItem:startItem optionMenus:menus];
    
    menu.delegate = self;
    
	menu.menuWholeAngle = M_PI ;
	menu.farRadius = 100.0f;
	menu.endRadius = 80.0f;
	menu.nearRadius = 70.0f;
    menu.animationDuration = 0.35f;
    menu.startPoint = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height - 35);
    menu.timeOffset = 0.036f;
    menu.rotateAngle = -M_PI_2;
    
    _menu = menu;
    
    [self.view addSubview:_menu];
    [self.view bringSubviewToFront:_menu];
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

#pragma mark - Menu Button
- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    //NSLog(@"Select the index : %d",idx);
    if(idx == 0){
        [self performSegueWithIdentifier:SEGUE_WELCOME_SCREEN sender:self];
    }
}
//- (void)awesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu {
//    NSLog(@"Menu was closed!");
//}
//- (void)awesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu {
//    NSLog(@"Menu is open!");
//}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    _menu.startPoint = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height - 35);
    [self.view setNeedsLayout];
}

@end
