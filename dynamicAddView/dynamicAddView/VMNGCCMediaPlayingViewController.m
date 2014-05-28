//
//  VMNGCCMediaPlayingViewController.m
//  dynamicAddView
//
//  Created by Weinstein, Randy - Nick.com on 5/27/14.
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
    self.rewindBtn.tintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:FALSE];
    self.rewindBtn.tintColor = [UIColor whiteColor];
    self.playBtn.tintColor = [UIColor whiteColor];
    self.ffBtn.tintColor = [UIColor whiteColor];
    [[MockVideo sharedInstance] setDelegate:self];
    [[MockVideo sharedInstance] startPlayback];
    
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

- (IBAction)closeView:(id)sender {
    
    
    [[self presentingViewController] dismissViewControllerAnimated:FALSE completion:^{
        [self.delegate closePlayingMainView];
    }];
    
   
}

#pragma mark MockVideo delegate
- (void) playheadUpdate {
    
    float playHeadPosition = (float) [[MockVideo sharedInstance] timeElapsed]/[[MockVideo sharedInstance] duration];
    self.playheadPosition.value = playHeadPosition;
    
    
    
    self.durationLabel.text = [NSString stringWithFormat:@"%d",[[MockVideo sharedInstance] duration]];
    
    self.playheadLabel.text = [NSString stringWithFormat:@"%d",[[MockVideo sharedInstance] timeElapsed]];

}
@end
