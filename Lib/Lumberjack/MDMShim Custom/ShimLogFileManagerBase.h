//
//  ShimLogFileManagerBase.h
//  MDMShim
//
//  Created by Fei, Michael (Enterprise Infrastructure) on 7/25/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "DDFileLogger.h"

@interface ShimLogFileManagerBase : DDLogFileManagerDefault

- (instancetype)initWithLogsContextName:(NSString *)subDir;

@end
