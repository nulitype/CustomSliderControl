//
//  RTZRangeSliderLayer.h
//  RangeSlider
//
//  Created by WongEric on 16/3/1.
//  Copyright © 2016年 WongEric. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@class RTZRangeSlider;

@interface RTZRangeSliderLayer : CALayer

@property (nonatomic, assign) BOOL highlighted;
@property (nonatomic, weak) RTZRangeSlider *slider;

@end
