//
//  ShimLogFileManagerBase.m
//  MDMShim
//
//  Created by Fei, Michael (Enterprise Infrastructure) on 7/25/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "ShimLogFileManagerBase.h"

@interface ShimLogFileManagerBase()
@property (nonatomic, copy)   NSString *contextName;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation ShimLogFileManagerBase

- (instancetype)initWithLogsContextName:(NSString *)subDir
{
    if(self = [super init]){
        _contextName = [subDir copy];
        _defaultFileProtectionLevel = NSFileProtectionComplete;
    }
    
    return self;
}

//Override - the parent folder of all logs are fully controlled internally
- (NSString *)defaultLogsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *baseDir = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *bundleVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*) kCFBundleVersionKey];
    NSString *logsDirectory = [[baseDir stringByAppendingPathComponent:@"Logs"] stringByAppendingPathComponent:bundleVersion];
    return logsDirectory;
}

//Override - change the default log file name
- (NSString *)newLogFileName
{
    return [NSString stringWithFormat:@"%@ %@.log", self.contextName, [self.dateFormatter stringFromDate:[NSDate date]]];
}

//Override
- (BOOL)isLogFile:(NSString *)fileName
{
    BOOL hasProperPrefix = [fileName hasPrefix:self.contextName];
    BOOL hasProperSuffix = [fileName hasSuffix:@".log"];
    return hasProperSuffix && hasProperPrefix;
}

- (NSDateFormatter *) dateFormatter
{
    if(_dateFormatter == nil){
        NSString *dateFormat = @"yy'-'MM'-'dd'-'HH'-'mm'";
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:dateFormat];
    }
    
    return _dateFormatter;
}

@end
