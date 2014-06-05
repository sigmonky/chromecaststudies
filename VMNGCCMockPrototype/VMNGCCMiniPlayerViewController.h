//
//  VMNGCCMiniPlayerViewController.h
//  VMNGCCMockPrototype
//
//  Created by Weinstein, Randy - Nick.com on 6/5/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VMNGCCMiniPlayerView <NSObject>

- (void) closePlayingMiniView:(UIViewController *)childController;

@end

@interface VMNGCCMiniPlayerViewController : UIViewController
    @property (nonatomic, weak) id<VMNGCCMiniPlayerView> delegate;
- (IBAction)restoreMainPlayer:(id)sender;
@end
