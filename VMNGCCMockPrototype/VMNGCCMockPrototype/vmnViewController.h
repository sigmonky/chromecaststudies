//
//  vmnViewController.h
//  VMNGCCMockPrototype
//
//  Created by Weinstein, Randy - Nick.com on 5/29/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <GoogleCast/GoogleCast.h>
#import "VMNGCCFacade.h"
#import "VMNGCCReadyViewController.h"
#import "VMNGCCPlayingDisconnectVC.h"
#import "VMNGCCMediaPlayingViewController.h"
#import "VMNGCCMiniPlayerViewController.h"


@interface vmnViewController : UIViewController
<
UIActionSheetDelegate,
VMNGCCFacade,
VMNGCCReadyView,
VMNGCCPlayDisconnectView,
VMNGCCMediaPlayingView,
VMNGCCMiniPlayerView

>
@property (weak, nonatomic) IBOutlet UIButton *gccButton;
@property (weak, nonatomic) IBOutlet UIButton *playVideoBtn;
@property (weak, nonatomic) IBOutlet UITextField *videoMGID;

- (IBAction)gccButtonClicked:(id)sender;

- (IBAction)playVideoBtnClicked:(id)sender;

@end
