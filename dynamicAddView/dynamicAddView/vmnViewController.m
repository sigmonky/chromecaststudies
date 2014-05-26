//
//  vmnViewController.m
//  dynamicAddView
//
//  Created by Weinstein, Randy - Nick.com on 5/23/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import "vmnViewController.h"
#import "vmnCustomView.h"
#import "MLPSpotlight.h"

@interface vmnViewController ()

@end

@implementation vmnViewController

vmnCustomView *customView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void) viewDidAppear:(BOOL)animated {
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"callToActionSeen"] == nil ) {
        
        [MLPSpotlight addSpotlightInView:self.view atPoint:self.chromeCastBtn.center];
        
        MLPSpotlight *overlay = [[MLPSpotlight alloc] initWithFrame:self.chromeCastBtn.frame withSpotlightAtPoint:self.chromeCastBtn.center];
        
        int labelX = self.view.center.x - 87;
        int labelY = self.view.center.y - 50;
        CGRect labelFrame = CGRectMake( labelX, labelY, 175, 100 );
        UILabel* label = [[UILabel alloc] initWithFrame: labelFrame];
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        label.textAlignment = NSTextAlignmentCenter;
        [label setText: @"Touch To Play Videos on your TV"];
        [label setTextColor: [UIColor whiteColor]];
        [self.view addSubview: label];
        
    }
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)chromeCastTapped:(id)sender {
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"callToActionSeen"] == nil ) {
         NSArray *existingSpotlights = [MLPSpotlight spotlightsInView:self.view];
        if(existingSpotlights.count){
            [MLPSpotlight removeSpotlightsInView:self.view];
        }
        [defaults setObject:@1 forKey:@"callToActionSeen"];
        [defaults synchronize];

    } else {
        VMNGCCReadyViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"testVC"];
        controller.delegate = self;
        
        [self presentViewController:controller animated:YES completion:NULL];   
    }
    
    

    
    /*if ( customView == nil) {
        customView = [vmnCustomView customView];
        customView.frame = CGRectMake( 10, 500, customView.frame.size.width,customView.frame.size.height );
        
        CALayer * l1 = [customView layer];
        [l1 setMasksToBounds:YES];
        //[l1 setCornerRadius:5.0];
        
        // Add a border
        [l1 setBorderWidth:1.0];
        [l1 setBorderColor:[[UIColor lightGrayColor] CGColor]];
        
        // Add a shadow
        [l1 setShadowColor:[[UIColor darkGrayColor] CGColor]];
        [l1 setShadowOpacity:1.0];
        
        
        [self.view addSubview:customView];
        customView.label.text = @"Teen Wolf";
    }
    
    [sender setEnabled:NO];
    NSLog(@"custom view transform %f",customView.transform.ty);
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (customView.transform.ty == 0) {
            [customView setTransform:CGAffineTransformMakeTranslation(0, -400)];
        }else{
            [customView setTransform:CGAffineTransformMakeTranslation(0, 0)];
        }
    }completion:^(BOOL done){
        [sender setEnabled:YES];
    }];*/



    
}
#pragma mark ReadyView delegates
- (void) disconnectDevice {
    NSLog(@"disconnecting...");
}
@end
