//
//  HGCVCustomChannel.h
//  HelloVideoGoogleCast
//
//  Created by Weinstein, Randy - Nick.com on 5/9/14.
//  Copyright (c) 2014 Google Inc. All rights reserved.
//

#import <GoogleCast/GoogleCast.h>


@protocol VMNGCCcustomChannelDelegate <NSObject>
- (void)customChannelMessageReceived:(NSString *)messageText;
@end



@interface VMNGCCcustomChannel : GCKCastChannel
    @property (nonatomic, strong) id<VMNGCCcustomChannelDelegate> delegate;
@end
