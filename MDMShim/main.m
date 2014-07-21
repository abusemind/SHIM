//
//  main.m
//  MDMShim
//
//  Created by Michael Fei on 7/11/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIApplication+TouchIdleTimer.h"

#import "AppConnect.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        int retVal = UIApplicationMain(argc, argv, kACUIApplicationClassName, @"AppDelegate");
        return retVal;
    }
}
