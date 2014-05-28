//
//  VMNGCCPlayingDisconnectVC.h
//  dynamicAddView
//
//  Created by Weinstein, Randy - Nick.com on 5/27/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VMNGCCPlayDisconnectView <NSObject>

- (void) disconnectDeviceWhilePlaying;

@end

@interface VMNGCCPlayingDisconnectVC : UIViewController

@property (nonatomic, weak) id<VMNGCCPlayDisconnectView> delegate;

- (IBAction)doneClicked:(id)sender;

- (IBAction)disconnectDevice:(id)sender;

@end
