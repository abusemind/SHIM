//
//  MSPasteboardSharedLogger.h
//  MDMShim
//
//  Created by Michael Fei on 7/11/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSPasteboardSharedLogger : NSObject

//start redirect NSLog to file and synced with pastebaord
+ (void)enable;

@end
