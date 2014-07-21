//
//  CustomSegue
//
//
//  Created by Michael Fei on 7/10/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "CustomUnwindSegue.h"

@implementation CustomUnwindSegue

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
    // Add view to super view temporarily
    [sourceViewController.view.superview insertSubview:destinationViewController.view atIndex:0];
    
    [UIView animateWithDuration:0.35
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         // Shrink!
                         sourceViewController.view.transform = CGAffineTransformMakeScale(0.02, 0.02);
                         sourceViewController.view.center = self.targetPoint;
                     }
                     completion:^(BOOL finished){
                         [destinationViewController.view removeFromSuperview]; // remove from temp super view
                         [sourceViewController dismissViewControllerAnimated:NO completion:NULL]; // dismiss VC
                     }];
}

@end
