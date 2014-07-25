//
//  MSShimContextFileLogger.h
//  MDMShim
//
//  Created by Fei, Michael (Enterprise Infrastructure) on 7/25/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "DDFileLogger.h"

@interface MSShimContextFileLogger : DDFileLogger

@property (nonatomic, copy) NSString *contextName;
@property (nonatomic, assign) int     context;

- (instancetype) initWithContextName: (NSString *) contextName context: (int) ctx;

@end
