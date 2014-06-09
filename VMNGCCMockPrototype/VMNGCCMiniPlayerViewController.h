//
//  VMNGCCMiniPlayerViewController.h
//  VMNGCCMockPrototype
//
//  Created by Weinstein, Randy - Nick.com on 6/5/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VMNGCCPlayStates.h"

@protocol VMNGCCMiniPlayerView <NSObject>

- (void) closePlayingMiniView:(UIViewController *)childController;
- (int) getMiniPlayState;
- (void) pauseMiniPlayback;
- (void) resumeMiniPlayback;

@end

@interface VMNGCCMiniPlayerViewController : UIViewController
    @property (nonatomic, weak) id<VMNGCCMiniPlayerView> delegate;
    - (IBAction)restoreMainPlayer:(id)sender;
    @property (weak, nonatomic) IBOutlet UIButton *playPauseBtn;
    - (IBAction)playPause:(id)sender;

    @property (weak, nonatomic) IBOutlet UILabel *videoTitleLbl;

    @property (weak, nonatomic) IBOutlet UILabel *castingMsgLbl;

    @property (strong,nonatomic) NSString *deviceName;
    @property (strong,nonatomic) NSString *videoTitle;

@end
