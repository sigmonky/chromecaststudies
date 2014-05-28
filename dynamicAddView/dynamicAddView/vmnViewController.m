//
//  vmnViewController.m
//  dynamicAddView
//
//  Created by Weinstein, Randy - Nick.com on 5/23/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import "vmnViewController.h"
#import "vmnCustomView.h"
#import "MLPSpotlight.h"



@interface vmnViewController ()

@end

@implementation vmnViewController

vmnCustomView *customView;
NSTimer *devConnectionTimer;
NSTimer *devDetectionTimer;
UILabel* callToActionLabel;
VMNGCCMiniPlayerView *miniPlayerController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[VMNGCCModel sharedInstance] setPlayState:DEVICESUNDETECTED];
    
    [self.chromeCastBtn setTintColor:[UIColor lightGrayColor]];
    self.chromeCastBtn.hidden = TRUE;
    self.playBtn.hidden = TRUE;
    
}

- (void) viewDidAppear:(BOOL)animated {
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    switch ([[VMNGCCModel sharedInstance] playState]) {
        case DEVICESDETECTED:
            self.chromeCastBtn.hidden = FALSE;
            [self callToAction];
            break;
        case DEVICESUNDETECTED:
            devDetectionTimer = [NSTimer
             scheduledTimerWithTimeInterval:4.0
             target:self
             selector:@selector(mockDevicesDetected)
             userInfo:nil
             repeats:NO];
            
            break;
        case DEVICEDISCONNECTED:
            break;
            
        default:
            break;
    }
    
    
    
   
    

}




- (IBAction)chromeCastTapped:(id)sender {
    
    [self removeCallToAction];
    
    VMNGCCReadyViewController *controller;
    UIActionSheet *sheet;
    
    switch ([[VMNGCCModel sharedInstance] playState]) {
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
            
            
            [sheet addButtonWithTitle:@"the device"];
            [sheet addButtonWithTitle:@"cancel"];
            sheet.cancelButtonIndex = sheet.numberOfButtons-1;
            
            //show device selection
            [sheet showInView:self.view];
                    

            break;
        case DEVICECONNECTED:
            controller = [self.storyboard instantiateViewControllerWithIdentifier:@"deviceConnected"];
            controller.delegate = self;

            [self presentViewController:controller animated:YES completion:NULL];
            break;
        case MEDIAPLAYING:
            controller = [self.storyboard instantiateViewControllerWithIdentifier:@"playOrDisconnect"];
            controller.delegate = self;
            
            [self presentViewController:controller animated:YES completion:NULL];
            break;
            
        
        default:
            break;
    }
}


#pragma mark Device Connection View Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
        if (buttonIndex == actionSheet.cancelButtonIndex) {  //Disconnect button
            [[VMNGCCModel sharedInstance] setPlayState:DEVICESDETECTED];
        } else {
            // connect to current device
            self.chromeCastBtn.tintColor = [UIColor whiteColor];
            self.chromeCastBtn.imageView.animationImages =
            @[ [UIImage imageNamed:@"icon_cast_on0.png"], [UIImage imageNamed:@"icon_cast_on1.png"],
               [UIImage imageNamed:@"icon_cast_on2.png"], [UIImage imageNamed:@"icon_cast_on1.png"] ];
            self.chromeCastBtn.imageView.animationDuration = 1;
            [self.chromeCastBtn.imageView startAnimating];
            
            devDetectionTimer = [NSTimer
                         scheduledTimerWithTimeInterval:4.0
                         target:self
                         selector:@selector(stopChromecastBtnAnimation)
                         userInfo:nil
                         repeats:NO];
            [[VMNGCCModel sharedInstance] setPlayState:DEVICESELECTED];
        }
}



#pragma mark ReadyView delegates
- (void) disconnectDevice {
    self.playBtn.hidden = TRUE;
    [self.chromeCastBtn setTintColor:[UIColor lightGrayColor]];
    [[VMNGCCModel sharedInstance] setPlayState:DEVICESDETECTED];
}


#pragma mark MediaPlayingViewController delegates
- (void) closePlayingMainView {
    miniPlayerController = [self.storyboard instantiateViewControllerWithIdentifier:@"mediaPlayingMin"];
    
    miniPlayerController.delegate = self;
    
    [self addChildViewController: miniPlayerController];
    miniPlayerController.view.frame = CGRectMake(0, 380, 320, 100);
    [self.view addSubview: miniPlayerController.view];
    [miniPlayerController didMoveToParentViewController:self];

}

#pragma mark MediaMiniPlayer delegates
- (void) closePlayingMiniView:(UIViewController *)childController {
   
    [childController willMoveToParentViewController:nil];
    [childController.view removeFromSuperview];
    [childController removeFromParentViewController];
    [self launchMainPlayer];
}


#pragma mark PlayDisconnect delegates 
- (void) disconnectDeviceWhilePlaying {
    [miniPlayerController willMoveToParentViewController:nil];
    [miniPlayerController.view removeFromSuperview];
    [miniPlayerController removeFromParentViewController];
    self.playBtn.hidden = TRUE;
    [[VMNGCCModel sharedInstance] setPlayState:DEVICESDETECTED];
    [self.chromeCastBtn setTintColor:[UIColor lightGrayColor]];
    [[MockVideo sharedInstance] stopPlayback];
}




#pragma mark main app control handlers
- (IBAction)playVideo:(id)sender {
    
    [[VMNGCCModel sharedInstance] setPlayState:MEDIAPLAYING];
    [self launchMainPlayer];
    
}

#pragma mark utility routines

- (void) launchMainPlayer {
    VMNGCCMediaPlayingViewController *controller;
    controller = [self.storyboard instantiateViewControllerWithIdentifier:@"mediaPlayingMain"];
    controller.delegate = self;
    
    [self presentViewController:controller animated:YES completion:NULL];
    
}

- (void) callToAction {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"callToActionSeen"] == nil ) {
        
        [MLPSpotlight addSpotlightInView:self.view atPoint:self.chromeCastBtn.center];
        
        MLPSpotlight *overlay = [[MLPSpotlight alloc] initWithFrame:self.chromeCastBtn.frame withSpotlightAtPoint:self.chromeCastBtn.center];
        
        int labelX = self.view.center.x - 87;
        int labelY = self.view.center.y - 50;
        CGRect labelFrame = CGRectMake( labelX, labelY, 175, 100 );
        callToActionLabel = [[UILabel alloc] initWithFrame: labelFrame];
        callToActionLabel.numberOfLines = 0;
        callToActionLabel.lineBreakMode = NSLineBreakByWordWrapping;
        callToActionLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        callToActionLabel.textAlignment = NSTextAlignmentCenter;
        [callToActionLabel setText: @"Touch To Play Videos on your TV"];
        [callToActionLabel setTextColor: [UIColor whiteColor]];
        [self.view addSubview: callToActionLabel];
        
    }
    
}

- (void) removeCallToAction {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"callToActionSeen"] == nil ) {
        NSArray *existingSpotlights = [MLPSpotlight spotlightsInView:self.view];
        if(existingSpotlights.count){
            [MLPSpotlight removeSpotlightsInView:self.view];
        }
        [callToActionLabel removeFromSuperview];
        [defaults setObject:@1 forKey:@"callToActionSeen"];
        [defaults synchronize];
        
    }
}



#pragma mark timer interval handlers (mocks)
- (void) stopChromecastBtnAnimation {
    [devDetectionTimer invalidate];
    UIButton *chromecastButton = (UIButton *)self.chromeCastBtn;
    [chromecastButton.imageView stopAnimating];
    
    [[VMNGCCModel sharedInstance] setPlayState:DEVICECONNECTED];
    [self.chromeCastBtn setTintColor:[UIColor blueColor]];
    self.playBtn.hidden = FALSE;
}

- (void) mockDevicesDetected {
    self.chromeCastBtn.hidden = FALSE;
    
    [self callToAction];
    [[VMNGCCModel sharedInstance] setPlayState:DEVICESDETECTED];
    [devDetectionTimer invalidate];
    
}


#pragma mark  app delegates
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*if ( customView == nil) {
 customView = [vmnCustomView customView];
 customView.frame = CGRectMake( 10, 500, customView.frame.size.width,customView.frame.size.height );
 
 CALayer * l1 = [customView layer];
 [l1 setMasksToBounds:YES];
 //[l1 setCornerRadius:5.0];
 
 // Add a border
 [l1 setBorderWidth:1.0];
 [l1 setBorderColor:[[UIColor lightGrayColor] CGColor]];
 
 // Add a shadow
 [l1 setShadowColor:[[UIColor darkGrayColor] CGColor]];
 [l1 setShadowOpacity:1.0];
 
 
 [self.view addSubview:customView];
 customView.label.text = @"Teen Wolf";
 }
 
 [sender setEnabled:NO];
 NSLog(@"custom view transform %f",customView.transform.ty);
 [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
 if (customView.transform.ty == 0) {
 [customView setTransform:CGAffineTransformMakeTranslation(0, -400)];
 }else{
 [customView setTransform:CGAffineTransformMakeTranslation(0, 0)];
 }
 }completion:^(BOOL done){
 [sender setEnabled:YES];
 }];*/


@end
