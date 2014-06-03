//
//  vmnCustomViewController.m
//  dynamicAddView
//
//  Created by Weinstein, Randy - Nick.com on 5/23/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import "VMNGCCReadyViewController.h"

@interface VMNGCCReadyViewController ()

@end

@implementation VMNGCCReadyViewController

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
    
    /*int lineX = self.readyLabel.frame.origin.x;
    int lineY = self.readyLabel.frame.origin.y + self.readyLabel.frame.size.height + 3;
    int lineWidth = self.readyLabel.frame.size.width;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(lineX,lineY)];
    [path addLineToPoint:CGPointMake(lineX + lineWidth, lineY)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor blackColor] CGColor];
    shapeLayer.lineWidth = 1.0;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    [self.view.layer addSublayer:shapeLayer];
     */
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


- (IBAction)disconnectBtnClicked:(id)sender {
    [self.delegate disconnectDevice];
    [[self presentingViewController] dismissViewControllerAnimated:TRUE completion:nil];

}

- (IBAction)doneBtnClicked:(id)sender {
    [[self presentingViewController] dismissViewControllerAnimated:TRUE completion:nil];
}
@end
