//
//  UIApplication+TouchIdleTimer.m
//  MDMShim
//
//  Created by Fei, Michael (Enterprise Infrastructure) on 7/16/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "UIApplication+TouchIdleTimer.h"

#import <objc/runtime.h>
#import "AuthManager.h"

@implementation UIApplication (TouchIdleTimer)

//method swizzling
+ (void) load
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        Class myClass = [self class];
        
        SEL originalSel = @selector(sendEvent:);
        SEL swizzledSel = @selector(tit_sendEvent:);
        
        Method originalMethod = class_getInstanceMethod(myClass, originalSel);
        Method swizzledMethod = class_getInstanceMethod(myClass, swizzledSel);
        
        BOOL didAddMethod = class_addMethod(myClass, originalSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if(didAddMethod){
            class_replaceMethod(myClass, swizzledSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else{
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)tit_sendEvent:(UIEvent *)event
{
    [self tit_sendEvent:event];//call original
    
    NSSet *allTouches = [event allTouches];
    if ([allTouches count] > 0) {
        UITouchPhase phase = ((UITouch *)[allTouches anyObject]).phase;
        if (phase == UITouchPhaseBegan) {
            [[AuthManager defaultManager] hit];
		}
    }
}

@end
