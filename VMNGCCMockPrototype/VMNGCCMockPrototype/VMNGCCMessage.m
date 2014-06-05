//
//  VMNGCCMessage.m
//  GCCMessagingSandbox
//
//  Created by Weinstein, Randy - Nick.com on 5/22/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import "VMNGCCMessage.h"

@implementation VMNGCCMessage

+ (instancetype)sharedInstance {
	__strong static VMNGCCMessage *_sharedObject = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    _sharedObject = [self new];
	});
    
	return _sharedObject;
}


- (NSString *) VMNGCCPlayMessage:(NSNumber *)playHeadPosition
                           error:(NSError * __autoreleasing *)error {
    
    
    NSError *errorMsg;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjects:@[playHeadPosition]
                                                       forKeys:@[VMNGCCKeyPlayheadPosition]];
    
    NSString *jsonString = [self VMNGCCPackageMessage:VMNGCCMsgPlayVideo
                                               params:params
                                                error:&errorMsg];
    
    if (jsonString == nil) {
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: NSLocalizedString(@"Could not package play video message.", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Check playhead position", nil)
                                   };
        *error = [NSError errorWithDomain:@"com.mtvn.gccsdk.messaging"
                                     code:VMNGCCErrorCodePlayVideoMsg
                                 userInfo:userInfo];
        return nil;
    } else {
        return jsonString;
    }
    
}

- (NSString *) VMNGCCPauseMessage:(NSError * __autoreleasing *)error {
    
    NSError *errorMsg;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjects:@[]
                                                       forKeys:@[]];
    
    NSString *jsonString = [self VMNGCCPackageMessage:VMNGCCMsgPause
                                               params:params
                                                error:&errorMsg];
    
    if (jsonString == nil) {
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: NSLocalizedString(@"Could not package pause message.", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"", nil)
                                   };
        *error = [NSError errorWithDomain:@"com.mtvn.gccsdk.messaging"
                                     code:VMNGCCErrorCodePauseVideoMsg
                                 userInfo:userInfo];
        return nil;
    } else {
        return jsonString;
    }
}

- (NSString *) VMNGCCResumeMessage:(NSError * __autoreleasing *)error {
    
    NSError *errorMsg;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjects:@[]
                                                       forKeys:@[]];
    
    NSString *jsonString = [self VMNGCCPackageMessage:VMNGCCMsgResume
                                               params:params
                                                error:&errorMsg];
    
    if (jsonString == nil) {
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: NSLocalizedString(@"Could not package resume message.", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"", nil)
                                   };
        *error = [NSError errorWithDomain:@"com.mtvn.gccsdk.messaging"
                                     code:VMNGCCErrorCodeResumeVideoMsg
                                 userInfo:userInfo];
        return nil;
    } else {
        return jsonString;
    }
    
}

- (NSString *) VMNGCCRewindMessage:(int)state
                             error:(NSError * __autoreleasing *)error {
    NSError *errorMsg;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjects:@[]
                                                       forKeys:@[]];
    NSString *message;
    if ( state == VMNGCCStateStart ) {
        message = VMNGCCMsgRewind;
    } else {
        message = VMNGCCMsgRewindStop;
    }
    
    NSString *jsonString = [self VMNGCCPackageMessage:message
                                               params:params
                                                error:&errorMsg];
    
    if (jsonString == nil) {
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: NSLocalizedString(@"Could not package rewind message.", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"", nil)
                                   };
        *error = [NSError errorWithDomain:@"com.mtvn.gccsdk.messaging"
                                     code:VMNGCCErrorCodeRewindMsg
                                 userInfo:userInfo];
        return nil;
    } else {
        return jsonString;
    }
}

- (NSString *) VMNGCCFastForwardMessage:(int)state
                                  error:(NSError * __autoreleasing *)error {
    NSError *errorMsg;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjects:@[]
                                                       forKeys:@[]];
    NSString *message;
    if ( state == VMNGCCStateStart ) {
        message = VMNGCCMsgFastForward;
    } else {
        message = VMNGCCMsgFastForwardStop;
    }
    
    NSString *jsonString = [self VMNGCCPackageMessage:message
                                               params:params
                                                error:&errorMsg];
    
    if (jsonString == nil) {
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: NSLocalizedString(@"Could not package fast forward message.", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"", nil)
                                   };
        *error = [NSError errorWithDomain:@"com.mtvn.gccsdk.messaging"
                                     code:VMNGCCErrorCodeFastForwardMsg
                                 userInfo:userInfo];
        return nil;
    } else {
        return jsonString;
    }
    
    
}

- (NSString *) VMNGCCSeekToMessage:(NSNumber *)playHeadPosition
                             error:(NSError * __autoreleasing *)error {
    
    NSError *errorMsg;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjects:@[playHeadPosition]
                                                       forKeys:@[VMNGCCKeyPlayheadPosition]];
    
    NSString *jsonString = [self VMNGCCPackageMessage:VMNGCCMsgStop
                                               params:params
                                                error:&errorMsg];
    
    if (jsonString == nil) {
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: NSLocalizedString(@"Could not package play video message.", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Check playhead position", nil)
                                   };
        *error = [NSError errorWithDomain:@"com.mtvn.gccsdk.messaging"
                                     code:VMNGCCErrorCodeSeekToMsg
                                 userInfo:userInfo];
        return nil;
    } else {
        return jsonString;
    }
    
    
    
}

- (NSString *) VMNGCCStopMessage:(NSError * __autoreleasing *)error {
    
    NSError *errorMsg;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjects:@[]
                                                       forKeys:@[]];
    
    NSString *jsonString = [self VMNGCCPackageMessage:VMNGCCMsgStop
                                               params:params
                                                error:&errorMsg];
    
    if (jsonString == nil) {
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: NSLocalizedString(@"Could not package pause message.", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"", nil)
                                   };
        *error = [NSError errorWithDomain:@"com.mtvn.gccsdk.messaging"
                                     code:VMNGCCErrorCodePauseVideoMsg
                                 userInfo:userInfo];
        return nil;
    } else {
        return jsonString;
    }
    
    
}

- (NSString *) VMNGCCClosedCaptionMessage:(BOOL)state
                                    error:(NSError * __autoreleasing *)error {
    
    NSError *errorMsg;
    
    NSString *captionVisible = @"false";
    
    if (state) {
        captionVisible = @"true" ;
    }
    
    
    
    NSDictionary *params = [NSDictionary dictionaryWithObjects:@[captionVisible]
                                                       forKeys:@[VMNGCCKeyClosedCaptionVisible]];
    NSString *message;
    if ( state == VMNGCCStateOn ) {
        message = VMNGCCMsgFastForward;
    } else {
        message = VMNGCCMsgFastForwardStop;
    }
    
    NSString *jsonString = [self VMNGCCPackageMessage:VMNGCCMsgClosedCaption
                                               params:params
                                                error:&errorMsg];
    
    if (jsonString == nil) {
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: NSLocalizedString(@"Could not package resume message.", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"", nil)
                                   };
        *error = [NSError errorWithDomain:@"com.mtvn.gccsdk.messaging"
                                     code:VMNGCCErrorCodeCloseCaptionMsg
                                 userInfo:userInfo];
        return nil;
    } else {
        return jsonString;
    }
    
    
}








- (NSString *) VMNGCCLoadVideoMessage:(NSString *)mgid
                             TVEToken:(NSString *)TVEToken
                       TVEProviderMD5:(NSString*)TVEProviderMD5
                                error:(NSError * __autoreleasing *)error {
    
    NSError *errorMsg;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjects:@[mgid,
                                                                 TVEToken,
                                                                 TVEProviderMD5
                                                                 ]
                                                       forKeys:@[VMNGCCKeyMgid,
                                                                 VMNGCCKeyTVEToken,
                                                                 VMNGCCKeyTVEProviderMD5
                                                                 ]];
    
    NSString *jsonString = [self VMNGCCPackageMessage:VMNGCCMsgLoadVideo
                                               params:params
                                                error:&errorMsg];
    
    if (jsonString == nil) {
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: NSLocalizedString(@"Could not package load video message.", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"Invalid parameters.", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Check mgid, TVE token, and TVE Provider MD5 parameters.", nil)
                                   };
        *error = [NSError errorWithDomain:@"com.mtvn.gccsdk.messaging"
                                     code:VMNGCCErrorCodeLoadVideoMsg
                                 userInfo:userInfo];
        return nil;
    } else {
        return jsonString;
    }
}


- (NSString *) VMNGCCSetupMessage:(NSString *)brandConfigFeedURL
                            error:(NSError * __autoreleasing *)error {
    
    NSError *errorMsg;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjects:@[brandConfigFeedURL]
                                                       forKeys:@[VMNGCCKeyBrandConfig]];
    
    NSString *jsonString = [self VMNGCCPackageMessage:VMNGCCMsgSetup
                                               params:params
                                                error:&errorMsg];
    
    if (jsonString == nil) {
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: NSLocalizedString(@"Could not package send message.", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"Invalid URL format.", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Validate the provided URL.", nil)
                                   };
        *error = [NSError errorWithDomain:@"com.mtvn.gccsdk.messaging"
                                     code:VMNGCCErrorCodeSetupMsg
                                 userInfo:userInfo];
        return nil;
    } else {
        return jsonString;
    }
    
}

- (NSString*) VMNGCCPackageMessage:(NSString*)message
                            params:(NSDictionary *) params
                             error:(NSError * __autoreleasing *)error{
    
    
    NSString *jsonString;
    
    
    
    // Formatter configuration
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss:SS"];
    // Date to string
    NSDate *now = [NSDate date];
    NSString *timeStamp = [formatter stringFromDate:now];
    
    if (params == nil) {
        params = [NSDictionary new];
    }
    
    NSDictionary *dictionary =
    @{
      @"command" : message,
      @"params" : params,
      @"timestamp" :timeStamp
      };
    
    NSError *jsonBuildError = nil;
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:dictionary
                        options:NSJSONWritingPrettyPrinted
                        error:&jsonBuildError];
    
    if ([jsonData length] > 0 && jsonBuildError == nil){
        
        NSLog(@"Successfully serialized the dictionary into data.");
        jsonString =
        [[NSString alloc] initWithData:jsonData
                              encoding:NSUTF8StringEncoding];
        
    }
    else if ([jsonData length] == 0 && error == nil){
        NSLog(@"No data was returned after serialization.");
    }
    else if (jsonBuildError != nil){
        NSLog(@"An error happened = %@", jsonBuildError);
    }
    
    return jsonString;
    
    
}

@end
