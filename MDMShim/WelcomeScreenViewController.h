//
//  WelcomeScreenViewController.h
//  MDMShim
//
//  Created by Michael Fei on 7/11/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MDMApplication.h"

@interface WelcomeScreenViewController : UIViewController
    <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) MDMApplication *passengerAppToOpen;
@property (nonatomic, strong) NSMutableArray *applications;
@property (nonatomic, assign) BOOL bouncingImmediately;

@end
