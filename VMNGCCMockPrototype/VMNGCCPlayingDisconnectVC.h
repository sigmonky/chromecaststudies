//
//  VMNGCCPlayingDisconnectVC.h
//  VMNGCCMockPrototype
//
//  Created by Weinstein, Randy - Nick.com on 6/5/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VMNGCCPlayStates.h"

@protocol VMNGCCPlayDisconnectView <NSObject>

- (void) disconnectDeviceWhilePlaying;
- (int) getPlayDisconnectPlayState;
- (void) pausePlayDisconnectPlayback;
- (void) resumePlayDisconnectPlayback;


@end

@interface VMNGCCPlayingDisconnectVC : UIViewController
- (IBAction)doneClicked:(id)sender;

- (IBAction)disconnectDevice:(id)sender;

@property (nonatomic, weak) id<VMNGCCPlayDisconnectView> delegate;
 
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (strong,nonatomic) NSString *deviceName;
@property (strong,nonatomic) NSString *videoTitle;

@property (weak, nonatomic) IBOutlet UIButton *playPauseBtn;

- (IBAction)playPause:(id)sender;
@end
