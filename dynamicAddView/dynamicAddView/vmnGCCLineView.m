//
//  vmnGCCLineView.m
//  dynamicAddView
//
//  Created by Randall Weinstein on 5/26/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import "vmnGCCLineView.h"

@implementation vmnGCCLineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setCoordinates:(CGRect)coordinates {
    _coordinates = coordinates;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextSetLineWidth(context, 1.0);
    CGContextMoveToPoint(context,64, 256.0);
    CGContextAddLineToPoint(context, 256, 256.0);
    CGContextDrawPath(context, kCGPathStroke);
}


@end
