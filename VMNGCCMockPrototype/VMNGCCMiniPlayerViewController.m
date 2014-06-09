//
//  VMNGCCMiniPlayerViewController.m
//  VMNGCCMockPrototype
//
//  Created by Weinstein, Randy - Nick.com on 6/5/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import "VMNGCCMiniPlayerViewController.h"

@interface VMNGCCMiniPlayerViewController ()

@end

@implementation VMNGCCMiniPlayerViewController

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
    int playState = [self.delegate getMiniPlayState];

    if ( playState == MEDIAPLAYING ) {
        [self.playPauseBtn
         setImage:[UIImage imageNamed:@"pause_black.png"]
         forState:UIControlStateNormal
         ];
        
    } else if (playState == MEDIAPAUSED) {
        [self.playPauseBtn
         setImage:[UIImage imageNamed:@"play_black.png"]
         forState:UIControlStateNormal
         ];
        
    }
    
    self.castingMsgLbl.text = self.deviceName;
    self.videoTitleLbl.text = self.videoTitle;

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

- (IBAction)restoreMainPlayer:(id)sender {
    [[self delegate] closePlayingMiniView:self];
}
- (IBAction)playPause:(id)sender {
    int playState = [self.delegate getMiniPlayState];
    
    
    if ( playState == MEDIAPLAYING ) {
        [self.playPauseBtn
         setImage:[UIImage imageNamed:@"play_black.png"]
         forState:UIControlStateNormal
         ];
        [self.delegate pauseMiniPlayback];
    } else if (playState == MEDIAPAUSED) {
        [self.playPauseBtn
         setImage:[UIImage imageNamed:@"pause_black.png"]
         forState:UIControlStateNormal
         ];
        [self.delegate resumeMiniPlayback];
        
    }
}
@end
