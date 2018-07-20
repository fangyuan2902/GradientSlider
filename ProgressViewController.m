//
//  ProgressViewController.m
//  AllKinds
//
//  Created by 远方 on 2017/6/23.
//  Copyright © 2017年 远方. All rights reserved.
//

#import "ProgressViewController.h"
#import "GradientSlider.h"

@interface ProgressViewController ()
@property (strong, nonatomic) GradientSlider *gradientSlider;
@property (strong, nonatomic) UISlider *slider;

@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GradientSlider *gradientSlider = [[GradientSlider alloc] initWithFrame:CGRectMake(10, 100, 300, 160)];
    self.gradientSlider = gradientSlider;
    CGPoint sliderCenter = gradientSlider.center;
    sliderCenter.x = self.view.center.x;
    gradientSlider.center = sliderCenter;
    gradientSlider.minimumValue = 0;
    gradientSlider.maximumValue = 100.0;
    gradientSlider.currentValue = 60.6;
    [self.view addSubview:gradientSlider];
    
    UISlider *slider1 = [[UISlider alloc] initWithFrame:CGRectMake(20, 400, 300, 20)];
    self.slider = slider1;
    slider1.minimumValue = gradientSlider.minimumValue;
    slider1.maximumValue = gradientSlider.maximumValue;
    slider1.value = gradientSlider.currentValue;
    [slider1 addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider1];
    
}

- (void)sliderValueChanged:(UISlider *)slider {
    self.gradientSlider.currentValue = slider.value;
    NSLog(@" %f", slider.value);
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
