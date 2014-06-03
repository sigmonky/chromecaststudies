//
//  vmnViewController.h
//  VMNGCCMockPrototype
//
//  Created by Weinstein, Randy - Nick.com on 5/29/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleCast/GoogleCast.h>
#import "VMNGCCFacade.h"
#import "VMNGCCReadyViewController.h"

@interface vmnViewController : UIViewController
<
GCKDeviceScannerListener,
GCKDeviceManagerDelegate,
GCKMediaControlChannelDelegate,
UIActionSheetDelegate,
GCKCastChannelHandler,
VMNGCCFacade,
VMNGCCReadyView
>
@property (weak, nonatomic) IBOutlet UIButton *gccButton;

- (IBAction)gccButtonClicked:(id)sender;

@end
