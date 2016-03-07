//
//  RTZRangeSliderTrackLayer.m
//  RangeSlider
//
//  Created by WongEric on 16/3/1.
//  Copyright © 2016年 WongEric. All rights reserved.
//

#import "RTZRangeSliderTrackLayer.h"
#import "RTZRangeSlider.h"

@implementation RTZRangeSliderTrackLayer

- (void)drawInContext:(CGContextRef)ctx {
    
    float cornerRadius = self.bounds.size.height * self.slider.curvaceousness / 2.0;
    UIBezierPath *switchOutline = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    
    CGContextAddPath(ctx, switchOutline.CGPath);
    CGContextClip(ctx);
    
    CGContextSetFillColorWithColor(ctx, self.slider.trackColor.CGColor);
    CGContextAddPath(ctx, switchOutline.CGPath);
    CGContextFillPath(ctx);
    
    CGContextSetFillColorWithColor(ctx, self.slider.trackHighlightColor.CGColor);
    float lower = [self.slider positionForValue:self.slider.lowerValue];
    float upper = [self.slider positionForValue:self.slider.upperValue];
    CGContextFillRect(ctx, CGRectMake(lower, 0, upper - lower, self.bounds.size.height));
    
    CGRect highlight = CGRectMake(cornerRadius / 2, self.bounds.size.height / 2, self.bounds.size.width - cornerRadius, self.bounds.size.height / 2);
    UIBezierPath *highlightPath = [UIBezierPath bezierPathWithRoundedRect:highlight cornerRadius:highlight.size.height * self.slider.curvaceousness / 2.0];
    CGContextAddPath(ctx, highlightPath.CGPath);
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithWhite:1.0 alpha:0.4].CGColor);
    CGContextFillPath(ctx);
    
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 2.0), 3.0, [UIColor grayColor].CGColor);
    CGContextAddPath(ctx, switchOutline.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor grayColor].CGColor);
    CGContextStrokePath(ctx);
    
    CGContextAddPath(ctx, switchOutline.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(ctx, 0.3);
    CGContextStrokePath(ctx);
}

@end
