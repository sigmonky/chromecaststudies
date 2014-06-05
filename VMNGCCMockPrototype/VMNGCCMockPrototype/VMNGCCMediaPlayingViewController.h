//
//  VMNGCCMediaPlayingViewController.h
//  VMNGCCMockPrototype
//
//  Created by Weinstein, Randy - Nick.com on 6/4/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VMNGCCMediaPlayingView <NSObject>

- (void) closePlayingMainView;

@end

@interface VMNGCCMediaPlayingViewController : UIViewController
    @property (nonatomic, weak) id<VMNGCCMediaPlayingView> delegate;

- (IBAction)closeView:(id)sender;
- (IBAction)rewind:(id)sender;
- (IBAction)playPause:(id)sender;
- (IBAction)fastForward:(id)sender;

@property (weak, nonatomic) IBOutlet UISlider *playheadPosition;
@property (weak, nonatomic) IBOutlet UIButton *playPauseBtn;
@property (weak, nonatomic) IBOutlet UILabel *playheadLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UIButton *rewindBtn;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *ffBtn;
@property (weak, nonatomic) IBOutlet UILabel *castingMsgLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoPlayStatus;

@property (strong,nonatomic) NSString *deviceName;
@property (strong,nonatomic) NSString *playStatus;

- (void) setMediaPlayStatus:(NSString *)playStatusMsg;
@end
