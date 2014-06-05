//
//  VMNGCCFacade.m
//  VMNGCCMockPrototype
//
//  Created by Weinstein, Randy - Nick.com on 5/29/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import "VMNGCCFacade.h"

NSTimer *_mockLatency;
NSInteger _deviceIndex = -1;

@implementation VMNGCCFacade


+ (instancetype)sharedInstance {
	__strong static VMNGCCFacade *_sharedObject = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    _sharedObject = [self new];
        _sharedObject.playState = DEVICESUNDETECTED;
	});
    
   
    
    
    
	return _sharedObject;
}

#pragma mark convenience methods
- (void)scan {
    //setup
#ifdef MOCK
    self.playState = DEVICESDETECTED;
    [self.delegate devicesDetected:(NSInteger)1];
#else
    self.deviceScanner = [[GCKDeviceScanner alloc] init];
    [self.deviceScanner addListener:self];
    [self.deviceScanner startScan];
    //see deviceDidComeOnline -- the scan result delegate
#endif
    //common code
}

- (NSArray*) getDevices {
    NSMutableArray *deviceList = [[NSMutableArray alloc] init];
#ifdef MOCK
    [deviceList addObject:@"mock device"];
#else
    for (GCKDevice *device in self.deviceScanner.devices) {
        [deviceList addObject:device.friendlyName];
    }
#endif
    return (NSArray *)deviceList;
}

- (void) selectDevice:(NSInteger)deviceIndex {
#ifdef MOCK
#else
#endif
    
}




- (void) connect:(NSInteger)deviceIndex {
    NSLog(@"connecting device %d",deviceIndex);
    _deviceIndex = deviceIndex;
#ifdef MOCK
    
    _mockLatency = [NSTimer
                    scheduledTimerWithTimeInterval:1.0
                    target:self
                    selector:@selector(mockConnection)
                    userInfo:nil
                    repeats:NO];
    
#else
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    self.deviceManager =
    [[GCKDeviceManager alloc] initWithDevice:self.deviceScanner.devices[deviceIndex]
                           clientPackageName:[info objectForKey:@"CFBundleIdentifier"]];
    self.deviceManager.delegate = self;
    [self.deviceManager connect];

#endif
    
}



- (void) disconnect {
#ifdef MOCK
    self.playState = DEVICESDETECTED;
    [self.delegate deviceDisconnected:nil];
#else
    [self.deviceManager disconnect];
#endif
}

- (BOOL) sendMessage:(NSString *)theMessage {
   
    NSError *parsingError;
    
    NSDictionary *messageDict =
    [NSJSONSerialization JSONObjectWithData: [theMessage dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: &parsingError];
    
    NSString *command = [messageDict objectForKey:@"command"];
    
    if ( [command isEqual: VMNGCCMsgLoadVideo]) {
        self.playState = MEDIAPLAYING;
    }
    
    return [self.customChannel sendTextMessage:theMessage];
}






#pragma mark - GCKDeviceScannerListener
- (void)deviceDidComeOnline:(GCKDevice *)device {
    NSLog(@"listening....");
    NSLog(@"device count %lu",(unsigned long)self.deviceScanner.devices.count);
    self.playState = DEVICESDETECTED;
    [self.delegate devicesDetected:self.deviceScanner.devices.count];
}


#pragma mark - GCKDeviceManagerDelegate

- (void)deviceManagerDidConnect:(GCKDeviceManager *)deviceManager {
    [self.deviceManager launchApplication:self.appID];
}

- (void)deviceManager:(GCKDeviceManager *)deviceManager
didConnectToCastApplication:(GCKApplicationMetadata *)applicationMetadata
            sessionID:(NSString *)sessionID
  launchedApplication:(BOOL)launchedApplication {
    
    self.playState = DEVICECONNECTED;
    
    GCKDevice *device = self.deviceScanner.devices[_deviceIndex];
    self.deviceName = device.friendlyName;
    [self initializeCustomChannel];

    [self.delegate deviceConnected];
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


- (void)deviceManager:(GCKDeviceManager *)deviceManager
didDisconnectWithError:(GCKError *)error {
    NSLog(@"Received notification that device disconnected");
    
    if (error != nil) {
        //[self showError:error];
    }
    self.playState = DEVICESDETECTED;
    [self.delegate deviceDisconnected:error];
    
    
}

- (void)deviceManager:(GCKDeviceManager *)deviceManager
didReceiveStatusForApplication:(GCKApplicationMetadata *)applicationMetadata {
    self.applicationMetadata = applicationMetadata;
}

#pragma mark playState getter
- (VMNGCCPlayStates) getVMNGCCPlayState {
    return self.playState;
}



#pragma mark custom channel methods
- (void) initializeCustomChannel {
    self.customChannel = [[VMNGCCcustomChannel alloc]
                          initWithNamespace:@"urn:x-cast:com.google.cast.sample.helloworld"
                          ];
    self.customChannel.delegate = (id) self;
    [self.deviceManager addChannel:self.customChannel];
    
}

#pragma mark - custom channel delegate
- (void)customChannelMessageReceived:(NSString *)messageText {
    
    NSLog(@"received message: %@",messageText);
    NSError *parsingError;
    NSDictionary *messageDict =
    [NSJSONSerialization JSONObjectWithData: [messageText dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: &parsingError];
    
    NSString *type = [messageDict objectForKey:VMNGCCMsgKeyType];
    
    NSLog(@"message type %@",type);
    
    if ( [type isEqual:VMNGCCMsgVideoLoaded]) {
        self.playState = MEDIAPLAYING;
    }
    
   
    [self.delegate GCCAppMsgReceived:messageDict];
}


#pragma mark mock behavior methods
- (void) mockConnection {
    
    [_mockLatency invalidate];
    self.playState = DEVICECONNECTED;
    self.deviceName = @"Mock Device";
    [self.delegate deviceConnected];
    
}




@end
