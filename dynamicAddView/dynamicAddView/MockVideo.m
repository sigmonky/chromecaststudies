//
//  MockVideo.m
//  dynamicAddView
//
//  Created by Weinstein, Randy - Nick.com on 5/27/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import "MockVideo.h"

NSTimer *videoPlayback;
NSInteger multiple = 1;

@implementation MockVideo
+ (instancetype)sharedInstance {
	__strong static MockVideo *_sharedObject = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    _sharedObject = [self new];
	});
    
	return _sharedObject;
}

- (void) updatePlayhead {
    self.timeElapsed++;
    [self.delegate playheadUpdate];
    
}

- (void) startPlayback {
    
    if ( self.timeElapsed == 0 ) {
    self.timeElapsed = 0;
    self.duration = 300;
    videoPlayback = [NSTimer
                     scheduledTimerWithTimeInterval:1.0
                     target:self
                     selector:@selector(updatePlayhead)
                     userInfo:nil
                     repeats:YES];
    }
}
- (void) pausePlayback {
    
}
- (void) stopPlayback {
    [videoPlayback invalidate];
    self.timeElapsed = 0;
}
- (void) rewindPlayback {
    
}
- (void) ffPlayback {
    
}



@end
