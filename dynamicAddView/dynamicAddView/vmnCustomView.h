//
//  vmnCustomView.h
//  dynamicAddView
//
//  Created by Weinstein, Randy - Nick.com on 5/23/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface vmnCustomView : UIView
+ (id) customView;
@property (weak, nonatomic) IBOutlet UILabel *label;
- (IBAction)playbackAction:(id)sender;

@end
