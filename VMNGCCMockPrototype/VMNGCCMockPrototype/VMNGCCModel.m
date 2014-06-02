//
//  VMNGCCModel.m
//  dynamicAddView
//
//  Created by Randall Weinstein on 5/25/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import "VMNGCCModel.h"

@implementation VMNGCCModel
+ (instancetype)sharedInstance {
	__strong static VMNGCCModel *_sharedObject = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    _sharedObject = [self new];
	});
    
	return _sharedObject;
}
@end
