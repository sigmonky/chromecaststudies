//
//  vmnViewController.m
//  VMNGCCMockPrototype
//
//  Created by Weinstein, Randy - Nick.com on 5/29/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import "vmnViewController.h"
static NSString * kReceiverAppID;


@interface vmnViewController ()
/*@property GCKMediaControlChannel *mediaControlChannel;
@property GCKApplicationMetadata *applicationMetadata;
@property GCKDevice *selectedDevice;
@property(nonatomic, strong) GCKDeviceScanner *deviceScanner;
@property(nonatomic, strong) GCKDeviceManager *deviceManager;
@property(nonatomic, readonly) GCKMediaInformation *mediaInformation;
 */
@end

@implementation vmnViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    kReceiverAppID=@"011C45D7";
    [VMNGCCFacade sharedInstance].appID = @"011C45D7";
    [VMNGCCFacade sharedInstance].delegate = (id)self;
    
    if ( [VMNGCCFacade sharedInstance].getVMNGCCPlayState == DEVICESUNDETECTED) {
        self.gccButton.hidden = TRUE;
        [self.gccButton setTintColor:[UIColor lightGrayColor]];
        [[VMNGCCFacade sharedInstance] scan];
    }


}


#pragma mark client app methods
- (IBAction)gccButtonClicked:(id)sender {
    
    UIActionSheet *sheet;
    VMNGCCReadyViewController *controller;
    NSArray *availableDevices;
    switch ( [[VMNGCCFacade sharedInstance] getVMNGCCPlayState] ) {
        case DEVICESELECTED:
            break;
        case DEVICESDETECTED:
            //UIButton *chromecastButton = (UIButton *)self.chromeCastBtn;
            sheet =
            [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Connect to Device", nil)
                                        delegate:(id)self
                               cancelButtonTitle:nil
                          destructiveButtonTitle:nil
                               otherButtonTitles:nil];
            
            availableDevices = [[VMNGCCFacade sharedInstance] getDevices];
            for (NSString *device in availableDevices) {
                [sheet addButtonWithTitle:device];
            }
            
            [sheet addButtonWithTitle:@"cancel"];
            sheet.cancelButtonIndex = sheet.numberOfButtons-1;
            
            //show list of available devices
            [sheet showInView:self.view];
            
            
            break;
        case DEVICECONNECTED:
            controller = [self.storyboard instantiateViewControllerWithIdentifier:@"deviceConnected"];
             controller.delegate = self;
             
             [self presentViewController:controller animated:YES completion:NULL];
            controller.deviceNameLbl.text = [VMNGCCFacade sharedInstance].deviceName;
            
            break;
        case MEDIAPLAYING:
            /*
             controller = [self.storyboard instantiateViewControllerWithIdentifier:@"playOrDisconnect"];
             controller.delegate = self;
             
             [self presentViewController:controller animated:YES completion:NULL];
             
             */
            break;
        default:
            break;
            
            
    }
    
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"button clicked = %d",buttonIndex);
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        NSLog(@"connection cancelled...");
    } else {
        [[VMNGCCFacade sharedInstance] connect:buttonIndex];
        [self deviceConnectionAnimation];
        
    }
    
}

- (void) deviceConnectionAnimation {
    
    self.gccButton.imageView.animationImages =
    @[ [UIImage imageNamed:@"icon_cast_on0.png"], [UIImage imageNamed:@"icon_cast_on1.png"],
       [UIImage imageNamed:@"icon_cast_on2.png"], [UIImage imageNamed:@"icon_cast_on1.png"] ];
    self.gccButton.imageView.animationDuration = 1;
    [self.gccButton.imageView startAnimating];
    
}



/*
#pragma mark - GCKDeviceScannerListener
- (void)deviceDidComeOnline:(GCKDevice *)device {
    NSLog(@"listening....");
    NSLog(@"device count %d",self.deviceScanner.devices.count);
}

#pragma mark - GCKDeviceManagerDelegate

- (void)deviceManagerDidConnect:(GCKDeviceManager *)deviceManager {
    //[self logStatus:@"connected!!"];
    //[self updateButtonStates];
    [self.deviceManager launchApplication:kReceiverAppID];
}

- (void)deviceManager:(GCKDeviceManager *)deviceManager
didConnectToCastApplication:(GCKApplicationMetadata *)applicationMetadata
            sessionID:(NSString *)sessionID
  launchedApplication:(BOOL)launchedApplication {
    
    //[self logStatus:@"application has launched"];
    //[self initializeCustomChannel];
}

- (void)deviceManager:(GCKDeviceManager *)deviceManager
didFailToConnectToApplicationWithError:(NSError *)error {
    //[self showError:error];
    
    //[self deviceDisconnected];
    //[self updateButtonStates];
}

- (void)deviceManager:(GCKDeviceManager *)deviceManager
didFailToConnectWithError:(GCKError *)error {
    //[self showError:error];
    
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

#pragma mark - misc
- (void)showError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                    message:NSLocalizedString(error.description, nil)
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                          otherButtonTitles:nil];
    [alert show];
}
 */

#pragma mark VMNGCCFacade Delegate Methods -- Scanning
- (void) devicesDetected:(NSInteger)numDevices {
    
    if ( numDevices > 0 ) {
        self.gccButton.hidden = FALSE;
    }
}


- (void) deviceConnected {
    
    [self.gccButton.imageView stopAnimating];
    [self.gccButton setTintColor:[UIColor blueColor]];
    
}

- (void) deviceDisconnected:(NSError *)error {
    [self.gccButton setTintColor:[UIColor lightGrayColor]];
}


#pragma mark application delegate methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark VMNGCCReadyViewController Delegates
- (void) disconnectDevice {
    
    [[VMNGCCFacade sharedInstance] disconnect];
}


@end
