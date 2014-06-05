//
//  VMNGCCMessage.h
//  GCCMessagingSandbox
//
//  Created by Weinstein, Randy - Nick.com on 5/22/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import <Foundation/Foundation.h>

#define VMNGCCMsgSetup @"setup"
#define VMNGCCMsgLoadVideo @"loadVideo"
#define VMNGCCMsgPlayVideo @"playVideo"
#define VMNGCCMsgPause @"Pause"
#define VMNGCCMsgResume @"Resume"
#define VMNGCCMsgRewind @"Rewind"
#define VMNGCCMsgRewindStop @"RewindStopped"
#define VMNGCCMsgFastForward @"FastForward"
#define VMNGCCMsgFastForwardStop @"FastForwardStopped"
#define VMNGCCMsgSeekTo @"seekTo"
#define VMNGCCMsgStop @"Stop"
#define VMNGCCMsgClosedCaption @"closedCaption"
#define VMNGCCMsgVideoLoaded @"Loaded"
#define VMNGCCMsgVideoPlaying @"Playing"


#define VMNGCCMsgKeyCommand @"Command"
#define VMNGCCMsgKeyType @"type"

#define VMNGCCStateStart 1
#define VMNGCCStateStopped 0
#define VMNGCCStateOn (BOOL)1
#define VMNGCCStateOff (BOOL)0

#define VMNGCCKeyBrandConfig @"brandConfigFeedURL"
#define VMNGCCKeyMgid @"mgid"
#define VMNGCCKeyTVEToken @"TVEToken"
#define VMNGCCKeyTVEProviderMD5 @"TVEProviderMD5"
#define VMNGCCKeyPlayheadPosition @"playHeadPosition"
#define VMNGCCKeyClosedCaptionVisible @"visible"

#define VMNGCCErrorCodeSetupMsg 1
#define VMNGCCErrorCodeLoadVideoMsg 2
#define VMNGCCErrorCodePlayVideoMsg 3
#define VMNGCCErrorCodePauseVideoMsg 4
#define VMNGCCErrorCodeResumeVideoMsg 5
#define VMNGCCErrorCodeRewindMsg 6
#define VMNGCCErrorCodeFastForwardMsg 7
#define VMNGCCErrorCodeSeekToMsg 8
#define VMNGCCErrorCodeCloseCaptionMsg 9

@interface VMNGCCMessage : NSObject


- (NSString *) VMNGCCClosedCaptionMessage:(BOOL)state
                                    error:(NSError * __autoreleasing *)error;

- (NSString *) VMNGCCFastForwardMessage:(int)state
                                  error:(NSError * __autoreleasing *)error;

- (NSString *) VMNGCCLoadVideoMessage:(NSString *)mgid
                             TVEToken:(NSString *)TVEToken
                       TVEProviderMD5:(NSString*)TVEProviderMD5
                                error:(NSError * __autoreleasing *)error;

- (NSString*) VMNGCCPackageMessage:(NSString*)message
                            params:(NSDictionary *) params
                             error:(NSError * __autoreleasing *)error;


- (NSString *) VMNGCCPauseMessage:(NSError * __autoreleasing *)error;

- (NSString *) VMNGCCPlayMessage:(NSNumber *)playHeadPosition
                           error:(NSError * __autoreleasing *)error;

- (NSString *) VMNGCCResumeMessage:(NSError * __autoreleasing *)error;

- (NSString *) VMNGCCRewindMessage:(int)state
                             error:(NSError * __autoreleasing *)error;

- (NSString *) VMNGCCSeekToMessage:(NSNumber *)playHeadPosition
                             error:(NSError * __autoreleasing *)error;

- (NSString *) VMNGCCSetupMessage:(NSString *)brandConfigFeedURL
                            error:(NSError * __autoreleasing *)error;

- (NSString *) VMNGCCStopMessage:(NSError * __autoreleasing *)error;

+ (VMNGCCMessage *)sharedInstance;


@end
