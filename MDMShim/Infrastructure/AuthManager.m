//
//  AuthManager.m
//  MDMShim
//
//  Created by Fei, Michael (Enterprise Infrastructure) on 7/17/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "AuthManager.h"
static NSString *const kLastAccessDateKey = @"MSMDMShimLastActiveDate";

@interface AuthManager()
{
    NSUInteger _touchOrNetworkCount;
    NSTimer *_resetExpireTimer;
    NSTimer *_expireTimer;
}
@end


@implementation AuthManager

+ (AuthManager *)defaultManager
{
    static AuthManager *sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSingleton = [[AuthManager alloc] init];
    });
    return sharedSingleton;
}

- (void) hit
{
    _touchOrNetworkCount++;
}

- (void) startIdleTimer
{
    [self scheduleResetExpireTimer];
    [self scheduleExpireTimer];
    
    _touchOrNetworkCount = 0;
}

- (void) stopIdleTimer
{
    [_resetExpireTimer invalidate];
    _resetExpireTimer = nil;
    
    [_expireTimer invalidate];
    _expireTimer = nil;
}

- (void) dealloc
{
    [self stopIdleTimer];
}


#pragma mark - Timers
- (void) scheduleResetExpireTimer
{
    [_resetExpireTimer invalidate];
    _resetExpireTimer = nil;
    
    _resetExpireTimer = [NSTimer scheduledTimerWithTimeInterval:5 //15 seconds
                                                         target:self
                                                       selector:@selector(resetExpireCookieTimerIfNeeded)
                                                       userInfo:nil
                                                        repeats:YES];
}

- (void) scheduleExpireTimer
{
    [_expireTimer invalidate];
    _expireTimer = nil;
    
    _expireTimer = [NSTimer scheduledTimerWithTimeInterval:15 //30 minutes
                                                    target:self
                                                  selector:@selector(expireCookie)
                                                  userInfo:nil
                                                   repeats:NO];
}

- (void) resetExpireCookieTimerIfNeeded
{
    if(_touchOrNetworkCount > 0)
    {
        [[NSUserDefaults  standardUserDefaults] setObject:[NSDate date] forKey:kLastAccessDateKey];
        [[NSUserDefaults  standardUserDefaults] synchronize];
        
        [self scheduleExpireTimer];
        _touchOrNetworkCount = 0;
    }
}

- (void) expireCookie
{
#warning TODO: delete cookies when expire auth timer fired here
    
    [self scheduleExpireTimer];
}

@end
