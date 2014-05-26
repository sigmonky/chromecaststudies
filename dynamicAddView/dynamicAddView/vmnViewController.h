//
//  vmnViewController.h
//  dynamicAddView
//
//  Created by Weinstein, Randy - Nick.com on 5/23/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VMNGCCReadyViewController.h"

@interface vmnViewController : UIViewController <VMNGCCReadyView>
- (IBAction)chromeCastTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *chromeCastBtn;

@end
