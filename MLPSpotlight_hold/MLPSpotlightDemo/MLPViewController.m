//
//  MLPViewController.m
//  MLPSpotlightDemo
//
//  Created by Eddy Borja on 1/26/13.
//  Copyright (c) 2013 Mainloop. All rights reserved.
//

#import "MLPViewController.h"
#import "MLPSpotlight.h"

@interface MLPViewController ()

@end

@implementation MLPViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.view setAlpha:0];
    [UIView animateWithDuration:0.2
                          delay:0.25
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         [self.view setAlpha:1.0];
                     }completion:nil];
}

- (IBAction)spotlightToggle:(id)sender
{
    NSArray *existingSpotlights = [MLPSpotlight spotlightsInView:self.view];
    if(existingSpotlights.count){
        [MLPSpotlight removeSpotlightsInView:self.view];
        
    } else {
        [MLPSpotlight addSpotlightInView:self.view atPoint:self.spotlightLabel.center];
        
        MLPSpotlight *overlay = [[MLPSpotlight alloc] initWithFrame:self.callToActionLabel.frame withSpotlightAtPoint:self.callToActionLabel.center];
        
        int labelX = self.view.center.x - 87;
        int labelY = self.view.center.y - 50;
        CGRect labelFrame = CGRectMake( labelX, labelY, 175, 100 );
        UILabel* label = [[UILabel alloc] initWithFrame: labelFrame];
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        label.textAlignment = NSTextAlignmentCenter;
        [label setText: @"Touch To Play Videos on your TV"];
        [label setTextColor: [UIColor orangeColor]];
        [self.view addSubview: label];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
