//
//  VMNGCCFacade.h
//  VMNGCCMockPrototype
//
//  Created by Weinstein, Randy - Nick.com on 5/29/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <GoogleCast/GoogleCast.h>

@interface VMNGCCFacade : NSObject
<
    GCKDeviceScannerListener,
    GCKDeviceManagerDelegate,
    GCKMediaControlChannelDelegate,
    UIActionSheetDelegate,
    GCKCastChannelHandler
>
    + (VMNGCCFacade *)sharedInstance;
    @property GCKMediaControlChannel *mediaControlChannel;
    @property GCKApplicationMetadata *applicationMetadata;
    @property GCKDevice *selectedDevice;
    @property(nonatomic, strong) GCKDeviceScanner *deviceScanner;
    @property(nonatomic, strong) GCKDeviceManager *deviceManager;
    @property(nonatomic, readonly) GCKMediaInformation *mediaInformation;
    @property(nonatomic,strong) NSString *appID;

- (void)scan;
- (void)connect;

@end
