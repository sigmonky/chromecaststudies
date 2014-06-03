//
//  VMNGCCFacade.h
//  VMNGCCMockPrototype
//
//  Created by Weinstein, Randy - Nick.com on 5/29/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleCast/GoogleCast.h>


@protocol VMNGCCFacade <NSObject>

- (void) devicesDetected:(NSInteger)numDevices;
- (void) deviceConnected;
- (void) deviceDisconnected:(NSError *)error;
@end


typedef enum {
    DEVICESUNDETECTED,
    DEVICESDETECTED,
    DEVICESELECTED,
    DEVICECONNECTED,
    DEVICEDISCONNECTED,
    MEDIAPAUSED,
    MEDIAPLAYING,
    MEDIABUFFERING,
    MEDIASTOPPED
} VMNGCCPlayStates;



@interface VMNGCCFacade : NSObject
<
    GCKDeviceScannerListener,
    GCKDeviceManagerDelegate,
    GCKMediaControlChannelDelegate,
    UIActionSheetDelegate,
    GCKCastChannelHandler
>
    + (VMNGCCFacade *)sharedInstance;
    @property (nonatomic,assign) VMNGCCPlayStates playState;
    @property id <VMNGCCFacade> delegate;
    @property GCKMediaControlChannel *mediaControlChannel;
    @property GCKApplicationMetadata *applicationMetadata;
    @property GCKDevice *selectedDevice;

    @property(nonatomic,assign) VMNGCCPlayStates currentPlayState;
    @property(nonatomic, strong) GCKDeviceScanner *deviceScanner;
    @property(nonatomic, strong) GCKDeviceManager *deviceManager;
    @property(nonatomic, readonly) GCKMediaInformation *mediaInformation;
    @property(nonatomic,strong) NSString *appID;
    @property(nonatomic,strong) NSString *deviceName;


- (void)scan;
- (NSArray *) getDevices;
- (void)select:(NSInteger)deviceIndex;
- (void)connect:(NSInteger)deviceIndex;
- (void)disconnect;
- (VMNGCCPlayStates) getVMNGCCPlayState;

@end
