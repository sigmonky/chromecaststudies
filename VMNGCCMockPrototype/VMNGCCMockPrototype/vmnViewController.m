//
//  vmnViewController.m
//  VMNGCCMockPrototype
//
//  Created by Weinstein, Randy - Nick.com on 5/29/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import "vmnViewController.h"

static NSString * kReceiverAppID;
VMNGCCMiniPlayerViewController *miniPlayerController;
VMNGCCMediaPlayingViewController *mainPlayerController;


@interface vmnViewController ()
@end

@implementation vmnViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

   
    [VMNGCCFacade sharedInstance].appID = @"011C45D7";
    [VMNGCCFacade sharedInstance].delegate = (id)self;
    
    self.videoMGID.text = @"mgid:uma:videolist:mtv.com:1726895";
    
    if ( [VMNGCCFacade sharedInstance].getVMNGCCPlayState == DEVICESUNDETECTED) {
        self.gccButton.hidden = TRUE;
        [self.gccButton setTintColor:[UIColor lightGrayColor]];
        self.playVideoBtn.hidden = TRUE;
        [[VMNGCCFacade sharedInstance] scan];
    }


}


#pragma mark client app methods -- Device Connection Management
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

- (void) deviceDisonnect {
    if (miniPlayerController.isViewLoaded ) {
        [miniPlayerController willMoveToParentViewController:nil];
        [miniPlayerController.view removeFromSuperview];
        [miniPlayerController removeFromParentViewController];
        
    }
    
    [[VMNGCCFacade sharedInstance] disconnect];
    
}




#pragma mark client app methods -- Chromecast State Management
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
        
             controller = [self.storyboard instantiateViewControllerWithIdentifier:@"playOrDisconnect"];
             controller.delegate = self;
             
             [self presentViewController:controller animated:YES completion:NULL];
            
            controller.deviceNameLbl.text = [VMNGCCFacade sharedInstance].deviceName;
            
            break;
        default:
            break;
            
            
    }
    
    
}


#pragma mark client app methods -- Playback Management
- (IBAction)playVideoBtnClicked:(id)sender {
    NSError *error;
    NSString *jsonString;
    
    jsonString = [[VMNGCCMessage sharedInstance]VMNGCCLoadVideoMessage:self.videoMGID.text
        TVEToken:@"tveToken"
        TVEProviderMD5:@"TVEProviderMD5"
        error:&error];
    
    BOOL success = [[VMNGCCFacade sharedInstance] sendMessage:jsonString];
    
    if (success) {
        [self launchMainPlayer];
        self.playVideoBtn.hidden = TRUE;
    } else {
        //TODO: handle playback init failure here
    }

}

- (void) launchMainPlayer {
    
    mainPlayerController = [self.storyboard instantiateViewControllerWithIdentifier:@"mediaPlayingMain"];
    mainPlayerController.delegate = (id)self;
    mainPlayerController.deviceName = [NSString
                             stringWithFormat:@"Now casting to %@",[VMNGCCFacade sharedInstance].deviceName];
    
    mainPlayerController.playStatus = @"loading....";
    [self presentViewController:mainPlayerController animated:YES completion:NULL];
       
    
}



#pragma mark VMNGCCMediaPlayingController delegate methods
- (void) closePlayingMainView {
    NSLog(@"closed main player view");
    
     miniPlayerController = [self.storyboard instantiateViewControllerWithIdentifier:@"mediaPlayingMin"];
     
     miniPlayerController.delegate = (id)self;
    miniPlayerController.deviceName = [NSString
                                       stringWithFormat:@"Now casting to %@",[VMNGCCFacade  sharedInstance].deviceName];
    miniPlayerController.videoTitle = @"xxxxxxx";

    
     [self addChildViewController: miniPlayerController];
     miniPlayerController.view.frame = CGRectMake(0, 380, 320, 100);
     [self.view addSubview: miniPlayerController.view];
     [miniPlayerController didMoveToParentViewController:self];
    
}

- (int) getPlayState {
    
    return [[VMNGCCFacade sharedInstance] playState];
}




- (void) pausePlayback {
    NSString *jsonString;
    NSError *error;
    
    jsonString = [[VMNGCCMessage sharedInstance]VMNGCCPauseMessage:&error];
    
    BOOL success = [[VMNGCCFacade sharedInstance] sendMessage:jsonString];
    
    [[VMNGCCFacade sharedInstance] setPlayState:MEDIAPAUSED];
    mainPlayerController.playStatus = @"paused....";
    
}

- (void) resumePlayback {
    
    NSString *jsonString;
    NSError *error;
    
    jsonString = [[VMNGCCMessage sharedInstance]VMNGCCResumeMessage:&error];
    
    BOOL success = [[VMNGCCFacade sharedInstance] sendMessage:jsonString];
    
    [[VMNGCCFacade sharedInstance] setPlayState:MEDIAPLAYING];
     mainPlayerController.playStatus = @"playing....";
}


#pragma mark VMNGCCMiniPlayerViewController delegate methods
- (void) closePlayingMiniView:(UIViewController *)childController {
    
    [childController willMoveToParentViewController:nil];
    [childController.view removeFromSuperview];
    [childController removeFromParentViewController];
    [self launchMainPlayer];
}

- (void) pauseMiniPlayback {
    NSString *jsonString;
    NSError *error;
    
    jsonString = [[VMNGCCMessage sharedInstance]VMNGCCPauseMessage:&error];
    
    BOOL success = [[VMNGCCFacade sharedInstance] sendMessage:jsonString];
    
    [[VMNGCCFacade sharedInstance] setPlayState:MEDIAPAUSED];
    mainPlayerController.playStatus = @"paused....";

    
}

- (void) resumeMiniPlayback {
    NSString *jsonString;
    NSError *error;
    
    jsonString = [[VMNGCCMessage sharedInstance]VMNGCCResumeMessage:&error];
    
    BOOL success = [[VMNGCCFacade sharedInstance] sendMessage:jsonString];
    
    [[VMNGCCFacade sharedInstance] setPlayState:MEDIAPLAYING];
    mainPlayerController.playStatus = @"playing....";

    
}

- (int) getMiniPlayState {
    
    return [[VMNGCCFacade sharedInstance] playState];
}





#pragma mark VMNGCCFacade Delegate Methods -- Scanning
- (void) devicesDetected:(NSInteger)numDevices {
    
    if ( numDevices > 0 ) {
        self.gccButton.hidden = FALSE;
    }
}

#pragma mark VMNGCCFacade Delegate Methods -- Connectivity
- (void) deviceConnected {
    
    [self.gccButton.imageView stopAnimating];
    [self.gccButton setTintColor:[UIColor blueColor]];
    self.playVideoBtn.hidden = FALSE;
   
    
}

- (void) deviceDisconnected:(NSError *)error {
    [self.gccButton setTintColor:[UIColor lightGrayColor]];
    self.playVideoBtn.hidden = TRUE;
}

#pragma mark VMNGCCFacade Delegate Methods -- Messaging

- (void) GCCAppMsgReceived:(NSDictionary *)msgDictionary {
    NSLog(@"GCCAppMsgReceived %@",msgDictionary);
    NSString *type = [msgDictionary objectForKey:VMNGCCMsgKeyType];
    static int duration;
    NSLog(@"message type %@",type);
    
    if ( [type isEqual:VMNGCCMsgVideoLoaded]) {
       [mainPlayerController setMediaPlayStatus:@"loaded....."];
        
        NSDictionary *message = [msgDictionary objectForKey:@"message"];
        
        duration = [[message objectForKey:@"duration"] intValue];
        int minutes = (int)floor((double)duration/60);
        int seconds = duration % 60;
        
        mainPlayerController.durationLabel.text = [NSString stringWithFormat:@"%@:%@",
                                                   [self timeFormatter:minutes],
                                                   [self timeFormatter:seconds]];
    } else if ([type isEqual:VMNGCCMsgVideoPlaying]) {
        [mainPlayerController setMediaPlayStatus:@"playing....."];
        
        NSString *playheadStr = [msgDictionary objectForKey:@"message"];
        
        int playheadPosition = (int)ceil([playheadStr floatValue]);
        int minutes = (int)floor((double)playheadPosition/60);
        int seconds = playheadPosition % 60;
        
        mainPlayerController.playheadLabel.text = [NSString stringWithFormat:@"%@:%@",
                                                    [self timeFormatter:minutes],
                                                    [self timeFormatter:seconds]];
        
        float pctPlayed = [playheadStr floatValue]/(float)duration;
        mainPlayerController.playheadPosition.value = pctPlayed;
        
    }
    
    
}

- (NSString *) timeFormatter:(int)timeValue {
    NSString *formattedValue;
    if ( timeValue < 10) {
        formattedValue = [NSString stringWithFormat:@"0%d",timeValue];
    } else {
        formattedValue = [NSString stringWithFormat:@"%d",timeValue];
    }
    return formattedValue;
}

#pragma mark standard application delegate methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark VMNGCCReadyViewController Delegates
- (void) disconnectDevice {
    
    [self deviceDisonnect];
}

#pragma mark VMNGCCPlayingDisconnectVC Delegates 

- (void) disconnectDeviceWhilePlaying {
    [self deviceDisonnect];
}

- (int) getPlayDisconnectPlayState {
    
    return [[VMNGCCFacade sharedInstance] playState];
}

- (void) pausePlayDisconnectPlayback {
    
    NSString *jsonString;
    NSError *error;
    
    jsonString = [[VMNGCCMessage sharedInstance]VMNGCCPauseMessage:&error];
    
    BOOL success = [[VMNGCCFacade sharedInstance] sendMessage:jsonString];
    
    [[VMNGCCFacade sharedInstance] setPlayState:MEDIAPAUSED];
    
}

- (void) resumePlayDisconnectPlayback {
    
    NSString *jsonString;
    NSError *error;
    
    jsonString = [[VMNGCCMessage sharedInstance]VMNGCCResumeMessage:&error];
    
    BOOL success = [[VMNGCCFacade sharedInstance] sendMessage:jsonString];
    
    [[VMNGCCFacade sharedInstance] setPlayState:MEDIAPLAYING];
    
}


@end
