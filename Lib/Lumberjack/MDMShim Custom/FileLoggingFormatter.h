//
//  MDMShimLoggingFormatter.h
//  MDMShim
//
//  Created by Fei, Michael (Enterprise Infrastructure) on 7/22/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDLog.h"


@interface FileLoggingFormatter : NSObject <DDLogFormatter>

@property (nonatomic, readonly) NSString *contextName;

-(instancetype) initWithContextName: (NSString *) contextName;

@end
