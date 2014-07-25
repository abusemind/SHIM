//
//  ShimLogFileManagerBase.h
//  MDMShim
//
//  Created by Fei, Michael (Enterprise Infrastructure) on 7/25/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "DDFileLogger.h"

@interface ShimLogFileManagerBase : DDLogFileManagerDefault

- (instancetype)initWithLogsDirectory: (NSString *) directory contextName:(NSString *)contextName context: (int) context;

+ (NSString *) rootLogsDirectory;

@end
