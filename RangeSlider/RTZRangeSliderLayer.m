//
//  RTZRangeSliderLayer.m
//  RangeSlider
//
//  Created by WongEric on 16/3/1.
//  Copyright © 2016年 WongEric. All rights reserved.
//

#import "RTZRangeSliderLayer.h"
#import "RTZRangeSlider.h"

@implementation RTZRangeSliderLayer

- (void)drawInContext:(CGContextRef)ctx {
    
    CGRect rtzFrame = CGRectInset(self.bounds, 2.0, 2.0);
    
    UIBezierPath *rtzPath = [UIBezierPath bezierPathWithRoundedRect:rtzFrame cornerRadius:rtzFrame.size.height * self.slider.curvaceousness / 2.0];
    
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 1), 1.0, [UIColor grayColor].CGColor);
    CGContextSetFillColorWithColor(ctx, self.slider.rtzColor.CGColor);
    CGContextAddPath(ctx, rtzPath.CGPath);
    CGContextFillPath(ctx);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor grayColor].CGColor);
    CGContextSetLineWidth(ctx, 0.5);
    CGContextAddPath(ctx, rtzPath.CGPath);
    CGContextStrokePath(ctx);
    
    CGRect rect = CGRectInset(rtzFrame, 2.0, 2.0);
    UIBezierPath *clip = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.height * self.slider.curvaceousness / 2.0];
    
    CGGradientRef myGradient;
    CGColorSpaceRef myColorspace;
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0};
    CGFloat components[8] = { 0.0, 0.0, 0.0, 0.15, 0.0, 0.0, 0.0, 0.05};
    
    myColorspace = CGColorSpaceCreateDeviceRGB();
    myGradient = CGGradientCreateWithColorComponents(myColorspace, components, locations, num_locations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    
    CGContextSaveGState(ctx);
    CGContextAddPath(ctx, clip.CGPath);
    CGContextClip(ctx);
    CGContextDrawLinearGradient(ctx, myGradient, startPoint, endPoint, 0);
    
    CGGradientRelease(myGradient);
    CGColorSpaceRelease(myColorspace);
    CGContextRestoreGState(ctx);
    
    if (self.highlighted) {
        CGContextSetFillColorWithColor(ctx, [UIColor colorWithWhite:0.0 alpha:0.1].CGColor);
        CGContextAddPath(ctx, rtzPath.CGPath);
        CGContextFillPath(ctx);
    }
    
}

@end
