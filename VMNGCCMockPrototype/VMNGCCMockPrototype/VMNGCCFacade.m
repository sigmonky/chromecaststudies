//
//  VMNGCCFacade.m
//  VMNGCCMockPrototype
//
//  Created by Weinstein, Randy - Nick.com on 5/29/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import "VMNGCCFacade.h"

@implementation VMNGCCFacade

+ (instancetype)sharedInstance {
	__strong static VMNGCCFacade *_sharedObject = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    _sharedObject = [self new];
	});
    
    _sharedObject.vmnGCCModel = [VMNGCCModel sharedInstance];
    
    _sharedObject.vmnGCCModel.playState = DEVICESUNDETECTED;
    
	return _sharedObject;
}


- (void)scan {
    //setup
#ifdef MOCK
    [self.delegate devicesDetected:(NSInteger)3];
#else
    self.deviceScanner = [[GCKDeviceScanner alloc] init];
    [self.deviceScanner addListener:self];
    [self.deviceScanner startScan];
#endif
    //common code
}

- (NSArray*) getDevices {
    NSMutableArray *deviceList;
#ifdef MOCK
    [NSMutableArray arrayWithCapacity:1];
    [deviceList addObject:@"mock device"];
#else
     deviceList = [NSMutableArray arrayWithCapacity:self.deviceScanner.devices.count];
    for (GCKDevice *device in self.deviceScanner.devices) {
        [deviceList addObject:device.friendlyName];
    }
#endif
    return (NSArray *)deviceList;
}

- (void) selectDevice:(NSInteger)deviceIndex {
    
    
}

- (void) connect {

#ifdef MOCK
#else
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    self.deviceManager =
    [[GCKDeviceManager alloc] initWithDevice:self.deviceScanner.devices[0]
                           clientPackageName:[info objectForKey:@"CFBundleIdentifier"]];
    self.deviceManager.delegate = self;
    [self.deviceManager connect];

#endif
    
}



#pragma mark - GCKDeviceScannerListener
- (void)deviceDidComeOnline:(GCKDevice *)device {
    NSLog(@"listening....");
    NSLog(@"device count %d",self.deviceScanner.devices.count);
    //[self connect];
    self.vmnGCCModel.playState = DEVICESDETECTED;
    [self.delegate devicesDetected:self.deviceScanner.devices.count];
}


#pragma mark - GCKDeviceManagerDelegate

- (void)deviceManagerDidConnect:(GCKDeviceManager *)deviceManager {
    //[self logStatus:@"connected!!"];
    //[self updateButtonStates];
    [self.deviceManager launchApplication:self.appID];
}

- (void)deviceManager:(GCKDeviceManager *)deviceManager
didConnectToCastApplication:(GCKApplicationMetadata *)applicationMetadata
            sessionID:(NSString *)sessionID
  launchedApplication:(BOOL)launchedApplication {
    NSLog(@"connected to app...%d",launchedApplication);
    //[self logStatus:@"application has launched"];
    //[self initializeCustomChannel];
}

- (void)deviceManager:(GCKDeviceManager *)deviceManager
didFailToConnectToApplicationWithError:(NSError *)error {
    //[self showError:error];
     NSLog(@"failed to connect to app...");
    //[self deviceDisconnected];
    //[self updateButtonStates];
}

- (void)deviceManager:(GCKDeviceManager *)deviceManager
didFailToConnectWithError:(GCKError *)error {
    //[self showError:error];
     NSLog(@"failed to connect to device...");
    //[self deviceDisconnected];
    //[self updateButtonStates];
}

- (void)deviceManager:(GCKDeviceManager *)deviceManager didDisconnectWithError:(GCKError *)error {
    NSLog(@"Received notification that device disconnected");
    
    if (error != nil) {
        //[self showError:error];
    }
    
    //[self deviceDisconnected];
    //[self updateButtonStates];
    
}

- (void)deviceManager:(GCKDeviceManager *)deviceManager
didReceiveStatusForApplication:(GCKApplicationMetadata *)applicationMetadata {
    self.applicationMetadata = applicationMetadata;
}

#pragma mark playState getter
- (VMNGCCPlayStates) getVMNGCCPlayState {
    return [VMNGCCModel sharedInstance].playState;
}


@end
