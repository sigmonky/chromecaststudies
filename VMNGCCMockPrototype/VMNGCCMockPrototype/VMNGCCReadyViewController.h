//
//  vmnCustomViewController.h
//  dynamicAddView
//
//  Created by Weinstein, Randy - Nick.com on 5/23/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "vmnGCCLineView.h"

@protocol VMNGCCReadyView <NSObject>

- (void) disconnectDevice;

@end

@interface VMNGCCReadyViewController : UIViewController

@property (nonatomic, weak) id<VMNGCCReadyView> delegate;
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLbl;
- (IBAction)disconnectBtnClicked:(id)sender;

- (IBAction)doneBtnClicked:(id)sender;

@end
