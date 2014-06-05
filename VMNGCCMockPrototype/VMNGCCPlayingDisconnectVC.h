//
//  VMNGCCPlayingDisconnectVC.h
//  VMNGCCMockPrototype
//
//  Created by Weinstein, Randy - Nick.com on 6/5/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VMNGCCPlayDisconnectView <NSObject>

- (void) disconnectDeviceWhilePlaying;

@end

@interface VMNGCCPlayingDisconnectVC : UIViewController
- (IBAction)doneClicked:(id)sender;

- (IBAction)disconnectDevice:(id)sender;

 @property (nonatomic, weak) id<VMNGCCPlayDisconnectView> delegate;
 


@end
