//
//  HGCVCustomChannel.m
//  HelloVideoGoogleCast
//
//  Created by Weinstein, Randy - Nick.com on 5/9/14.
//  Copyright (c) 2014 Google Inc. All rights reserved.
//

#import "VMNGCCcustomChannel.h"


@implementation VMNGCCcustomChannel

- (void)didReceiveTextMessage:(NSString*)message {
    NSLog(@"received message: %@",message);
    [_delegate customChannelMessageReceived:message];
}



@end
