//
//  VMNGCCPlayingDisconnectVC.m
//  VMNGCCMockPrototype
//
//  Created by Weinstein, Randy - Nick.com on 6/5/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import "VMNGCCPlayingDisconnectVC.h"

@interface VMNGCCPlayingDisconnectVC ()

@end

@implementation VMNGCCPlayingDisconnectVC

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

- (IBAction)doneClicked:(id)sender {
    
    [[self presentingViewController] dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)disconnectDevice:(id)sender {
    [self.delegate disconnectDeviceWhilePlaying];
    [[self presentingViewController] dismissViewControllerAnimated:TRUE completion:nil];
}
@end
