//
//  MockVideo.h
//  dynamicAddView
//
//  Created by Weinstein, Randy - Nick.com on 5/27/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MockVideo <NSObject>

- (void) playheadUpdate;

@end

@interface MockVideo : NSObject



+ (MockVideo *)sharedInstance;

@property (nonatomic,assign) NSInteger duration;
@property (nonatomic,assign) NSInteger timeElapsed;
@property (nonatomic, weak) id<MockVideo> delegate;

- (void) startPlayback;
- (void) pausePlayback;
- (void) stopPlayback;
- (void) rewindPlayback;
- (void) ffPlayback;

@end
