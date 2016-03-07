//
//  RTZViewController.m
//  RangeSlider
//
//  Created by WongEric on 16/3/1.
//  Copyright © 2016年 WongEric. All rights reserved.
//

#import "RTZViewController.h"
#import "RTZRangeSlider.h"

@interface RTZViewController ()

@end

@implementation RTZViewController {
    RTZRangeSlider *_rangeSlider;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSUInteger margin = 20;
    CGRect sliderFrame = CGRectMake(margin, margin, self.view.frame.size.width - margin * 2, 30);
    _rangeSlider = [[RTZRangeSlider alloc] initWithFrame:sliderFrame];
    //_rangeSlider.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_rangeSlider];
    
    [_rangeSlider addTarget:self action:@selector(slideValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self performSelector:@selector(updateState) withObject:nil afterDelay:1.0f];
}

- (void)updateState {
    _rangeSlider.trackHighlightColor = [UIColor redColor];
    _rangeSlider.curvaceousness = 0.0;
}

- (void)slideValueChanged:(id)control {
    NSLog(@"Slider value changed: (%.2f, %.2f)", _rangeSlider.lowerValue, _rangeSlider.upperValue);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
