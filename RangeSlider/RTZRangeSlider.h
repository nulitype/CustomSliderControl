//
//  RTZRangeSlider.h
//  RangeSlider
//
//  Created by WongEric on 16/3/1.
//  Copyright © 2016年 WongEric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTZRangeSlider : UIControl

@property (nonatomic, assign) float maxinumValue;
@property (nonatomic, assign) float mininumValue;
@property (nonatomic, assign) float upperValue;
@property (nonatomic, assign) float lowerValue;

@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic, strong) UIColor *trackHighlightColor;
@property (nonatomic, strong) UIColor *rtzColor;
@property (nonatomic, assign) float curvaceousness;

- (float)positionForValue:(float)value;

@end
