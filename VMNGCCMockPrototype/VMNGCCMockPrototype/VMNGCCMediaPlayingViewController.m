//
//  VMNGCCMediaPlayingViewController.m
//  VMNGCCMockPrototype
//
//  Created by Weinstein, Randy - Nick.com on 6/4/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import "VMNGCCMediaPlayingViewController.h"


@interface VMNGCCMediaPlayingViewController ()

@end

@implementation VMNGCCMediaPlayingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:FALSE];
    self.rewindBtn.tintColor = [UIColor whiteColor];
    self.playBtn.tintColor = [UIColor whiteColor];
    self.ffBtn.tintColor = [UIColor whiteColor];
    self.castingMsgLabel.text = self.deviceName;
    self.videoPlayStatus.text = self.playStatus;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) setMediaPlayStatus:(NSString *)playStatusMsg {
    self.videoPlayStatus.text = playStatusMsg;
}

- (IBAction)closeView:(id)sender {
    [[self presentingViewController] dismissViewControllerAnimated:FALSE completion:^{
        [self.delegate closePlayingMainView];
    }];
}

- (IBAction)rewind:(id)sender {
}

- (IBAction)playPause:(id)sender {
    
    int playState = [self.delegate getPlayState];
    
    
    if ( playState == MEDIAPLAYING ) {
        [self.playPauseBtn
         setImage:[UIImage imageNamed:@"play_black.png"]
         forState:UIControlStateNormal
         ];
        [self.delegate pausePlayback];
    } else if (playState == MEDIAPAUSED) {
        [self.playPauseBtn
         setImage:[UIImage imageNamed:@"pause_black.png"]
         forState:UIControlStateNormal
         ];
        [self.delegate resumePlayback];
        
    }
}

- (IBAction)fastForward:(id)sender {
}

- (IBAction)rewindBtn:(id)sender {
}

- (IBAction)playBtn:(id)sender {
}

- (IBAction)ffBtn:(id)sender {
}

@end
