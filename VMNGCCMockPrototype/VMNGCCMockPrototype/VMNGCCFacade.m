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
    
	return _sharedObject;
}


- (void)scan {
    //setup
#ifdef MOCK
    NSLog(@"I got fake devices");
#else
    self.deviceScanner = [[GCKDeviceScanner alloc] init];
    [self.deviceScanner addListener:self];
    [self.deviceScanner startScan];
#endif
    //common code
}



- (void) connect {
    
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    self.deviceManager =
    [[GCKDeviceManager alloc] initWithDevice:self.deviceScanner.devices[0]
                           clientPackageName:[info objectForKey:@"CFBundleIdentifier"]];
    self.deviceManager.delegate = self;
    [self.deviceManager connect];
    
}



#pragma mark - GCKDeviceScannerListener
- (void)deviceDidComeOnline:(GCKDevice *)device {
    NSLog(@"listening....");
    NSLog(@"device count %d",self.deviceScanner.devices.count);
    [self connect];
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




@end
