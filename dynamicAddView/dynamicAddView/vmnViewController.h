//
//  vmnViewController.h
//  dynamicAddView
//
//  Created by Weinstein, Randy - Nick.com on 5/23/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VMNGCCReadyViewController.h"
#import "VMNGCCMediaPlayingViewController.h"
#import "VMNGCCMiniPlayerView.h"
#import "VMNGCCModel.h"
#import "VMNGCCPlayingDisconnectVC.h"

@interface vmnViewController : UIViewController <
    VMNGCCReadyView,
    VMNGCCMediaPlayingView,
    VMNGCCMiniPlayerView,
    VMNGCCPlayDisconnectView
>
- (IBAction)chromeCastTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *chromeCastBtn;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
- (IBAction)playVideo:(id)sender;

@end
