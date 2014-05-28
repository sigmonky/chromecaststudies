//
//  VMNGCCMiniPlayerView.h
//  dynamicAddView
//
//  Created by Weinstein, Randy - Nick.com on 5/27/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VMNGCCMiniPlayerView <NSObject>

- (void) closePlayingMiniView:(UIViewController *)childController;

@end


@interface VMNGCCMiniPlayerView : UIViewController

@property (nonatomic, weak) id<VMNGCCMiniPlayerView> delegate;

- (IBAction)restoreMainPlayer:(id)sender;

@end
