//
//  VMNGCCVideoPlayingViewController.h
//  dynamicAddView
//
//  Created by Weinstein, Randy - Nick.com on 5/27/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MockVideo.h"

@protocol VMNGCCMediaPlayingView <NSObject>

- (void) closePlayingMainView;

@end

@interface VMNGCCMediaPlayingViewController : UIViewController <MockVideo>

@property (nonatomic, weak) id<VMNGCCMediaPlayingView> delegate;
@property (weak, nonatomic) IBOutlet UIButton *rewindBtn;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

- (IBAction)closeView:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ffBtn;
@property (weak, nonatomic) IBOutlet UISlider *playheadPosition;
@property (weak, nonatomic) IBOutlet UILabel *playheadLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@end
