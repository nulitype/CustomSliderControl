//
//  RTZRangeSlider.m
//  RangeSlider
//
//  Created by WongEric on 16/3/1.
//  Copyright © 2016年 WongEric. All rights reserved.
//

#import "RTZRangeSlider.h"
#import <QuartzCore/QuartzCore.h>
#import "RTZRangeSliderLayer.h"
#import "RTZRangeSliderTrackLayer.h"

#define BOUND(VALUE, UPPER, LOWER)   MIN(MAX(VALUE, LOWER), UPPER)

@implementation RTZRangeSlider {
    RTZRangeSliderTrackLayer *_trackLayer;
    RTZRangeSliderLayer *_upperLayer;
    RTZRangeSliderLayer *_lowerLayer;
    
    float _rWidth;
    float _useableTrackLength;
    CGPoint _previousTouchPoint;
}

#define GENERATE_SETTER(PROPERTY, TYPE, SETTER, UPDATER) \
- (void)SETTER:(TYPE)PROPERTY { \
    if (_##PROPERTY != PROPERTY) { \
        _##PROPERTY = PROPERTY; \
        [self UPDATER]; \
    } \
}

GENERATE_SETTER(trackHighlightColor, UIColor *, setTrackHighlightColor, redrawLayers)
GENERATE_SETTER(trackColor, UIColor *, setTrackColor, redrawLayers)
GENERATE_SETTER(curvaceousness, float, setCurvaceousness, redrawLayers)
GENERATE_SETTER(rtzColor, UIColor*, setRtzColor, redrawLayers)

GENERATE_SETTER(maxinumValue, float, setMaxinumValue, setLayerFrames)

GENERATE_SETTER(mininumValue, float, setMininumValue, setLayerFrames)

GENERATE_SETTER(lowerValue, float, setLowerValue, setLayerFrames)

GENERATE_SETTER(upperValue, float, setUpperValue, setLayerFrames)


- (void)redrawLayers {
    [_upperLayer setNeedsDisplay];
    [_lowerLayer setNeedsDisplay];
    [_trackLayer setNeedsDisplay];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _maxinumValue = 10.0;
        _mininumValue = 0.0;
        _upperValue = 8.0;
        _lowerValue = 2.0;
        _trackHighlightColor = [UIColor colorWithRed:0.0 green:0.45 blue:0.94 alpha:1.0];
        _trackColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        _rtzColor = [UIColor whiteColor];
        _curvaceousness = 1.0;
        
        
        _trackLayer = [RTZRangeSliderTrackLayer layer];
        _trackLayer.slider = self;
        _trackLayer.backgroundColor = [UIColor blueColor].CGColor;
        [self.layer addSublayer:_trackLayer];
        
        _upperLayer = [RTZRangeSliderLayer layer];
        _upperLayer.slider = self;
        //_upperLayer.backgroundColor = [UIColor greenColor].CGColor;
        [self.layer addSublayer:_upperLayer];
        
        _lowerLayer = [RTZRangeSliderLayer layer];
        _lowerLayer.slider = self;
        //_lowerLayer.backgroundColor = [UIColor greenColor].CGColor;
        [self.layer addSublayer:_lowerLayer];
        
        [self setLayerFrames];
    }
    return self;
}

- (void)setLayerFrames {
    _trackLayer.frame = CGRectInset(self.bounds, 0, self.bounds.size.height / 3.5);
    [_trackLayer setNeedsDisplay];
    
    _rWidth = self.bounds.size.height;
    _useableTrackLength = self.bounds.size.width - _rWidth;
    
    float upperCenter = [self positionForValue:_upperValue];
    _upperLayer.frame = CGRectMake(upperCenter - _rWidth / 2, 0, _rWidth, _rWidth);
    
    float lowerCenter = [self positionForValue:_lowerValue];
    _lowerLayer.frame = CGRectMake(lowerCenter - _rWidth / 2, 0, _rWidth, _rWidth);
    
    [_upperLayer setNeedsDisplay];
    [_lowerLayer setNeedsDisplay];
}

- (float)positionForValue:(float)value {
    return _useableTrackLength * (value - _mininumValue) / (_maxinumValue - _mininumValue) + (_rWidth / 2);
}

#pragma mark -- Override Three key methods

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    _previousTouchPoint = [touch locationInView:self];
    
    if (CGRectContainsPoint(_lowerLayer.frame, _previousTouchPoint)) {
        _lowerLayer.highlighted = YES;
        [_lowerLayer setNeedsDisplay];
    } else if (CGRectContainsPoint(_upperLayer.frame, _previousTouchPoint)) {
        _upperLayer.highlighted = YES;
        [_upperLayer setNeedsDisplay];
    }
    return _upperLayer.highlighted || _lowerLayer.highlighted;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGPoint touchPoint = [touch locationInView:self];
    
    float delta = touchPoint.x - _previousTouchPoint.x;
    float valueDelta = (_maxinumValue - _mininumValue) * delta / _useableTrackLength;
    
    _previousTouchPoint = touchPoint;
    
    if (_lowerLayer.highlighted) {
        _lowerValue += valueDelta;
        _lowerValue = BOUND(_lowerValue, _upperValue, _mininumValue);
    }
    if (_upperLayer.highlighted) {
        _upperValue += valueDelta;
        _upperValue = BOUND(_upperValue, _maxinumValue, _lowerValue);
    }
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    [self setLayerFrames];
    
    [CATransaction commit];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    _lowerLayer.highlighted = _upperLayer.highlighted = NO;
    [_lowerLayer setNeedsDisplay];
    [_upperLayer setNeedsDisplay];
}


@end
