//
//  CustomSegue
//
//
//  Created by Michael Fei on 7/10/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "CustomSegue.h"

@implementation CustomSegue

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
    [sourceViewController presentViewController:destinationViewController animated:NO completion:NULL]; // present VC
    
    /*// Add the destination view as a subview, temporarily
    [sourceViewController.view addSubview:destinationViewController.view];
    
    // Transformation start scale
    destinationViewController.view.transform = CGAffineTransformMakeScale(0.05, 0.05);
    
    // Store original centre point of the destination view
    CGPoint originalCenter = destinationViewController.view.center;
    // Set center to start point of the button
    destinationViewController.view.center = self.originatingPoint;
    
    [UIView animateWithDuration:0.6
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         // Grow!
                         destinationViewController.view.transform = CGAffineTransformMakeScale(1., 1.);
                         destinationViewController.view.center = originalCenter;
                     }
                     completion:^(BOOL finished){
                         
                         [destinationViewController.view removeFromSuperview]; // remove from temp super view
                         [sourceViewController presentViewController:destinationViewController animated:NO completion:NULL]; // present VC
                     }];
    */
}

@end
