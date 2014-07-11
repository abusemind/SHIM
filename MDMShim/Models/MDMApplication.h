//
//  MDMApplication.h
//  MDMShim
//
//  Created by Michael Fei on 7/11/14.
//  Copyright (c) 2014 Morgan Stanley. All rights reserved.
//

#import "JSONModel.h"

@interface MDMApplication : JSONModel

@property (nonatomic, assign) int id;
@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *description;

@end
