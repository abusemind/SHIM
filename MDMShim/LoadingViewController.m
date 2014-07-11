//
//  ViewController.m
//  MDMShim
//
//  Created by Michael Fei on 7/11/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "LoadingViewController.h"
#import "MSCycleProgressView.h"

@interface LoadingViewController ()
{
    MSCycleProgressView *_progressView;
}
@end

@implementation LoadingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _progressView = [[MSCycleProgressView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    [self.view addSubview:_progressView];
    _progressView.center = self.view.center;
}

- (void) viewDidAppear:(BOOL)animated
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _progressView.progress = 0.5;
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _progressView.progress = 0.7;
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _progressView.progress = 1.0;
        
        [self gotoWelcomeScreen];
    });
}

- (void) gotoWelcomeScreen
{
    [self performSegueWithIdentifier:SEGUE_WELCOME_SCREEN sender:self];
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    _progressView.center = self.view.center;
}

@end
