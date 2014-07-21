//
//  AuthManager.h
//  MDMShim
//
//  Created by Fei, Michael (Enterprise Infrastructure) on 7/17/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthManager : NSObject

+ (AuthManager *)defaultManager;

- (void) hit;

- (void) startIdleTimer;
- (void) stopIdleTimer;

@end
