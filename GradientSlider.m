//
//  GradientSlider.m
//  ProgressView
//
//  Created by 远方 on 2017/5/15.
//  Copyright © 2017年 远方. All rights reserved.
//

#import "GradientSlider.h"

#define degreesToRadians(x) (M_PI * (x) / 180.0)


@interface GradientSlider ()

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat sideLength;
@property (nonatomic, assign) CGPoint centerPoint;
@property (nonatomic, strong) CAGradientLayer *colorLayer;
@property (nonatomic, strong) CAShapeLayer *gradientMaskLayer;
@end

@implementation GradientSlider

- (CGFloat)sideLength {
    return self.frame.size.width;
}

- (CGPoint)centerPoint {
    CGFloat wh = self.sideLength;
    return CGPointMake(wh * 0.5, wh * 0.5);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
        self.minimumValue = 0;
        self.maximumValue = 1.0;
        self.lineWidth = 12;
        self.radius = self.sideLength / 2.0 - self.lineWidth;
        
        [self setupGradientLayer];
        [self setupGradientMaskLayer];
        
        CAShapeLayer *bgMaskLayer = [self generateMaskLayer];
        self.layer.mask = bgMaskLayer;
    }
    return self;
}

/**
 *  设置渐变色
 */
- (void)setupGradientLayer {
    self.colorLayer = [CAGradientLayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, self.sideLength, self.sideLength);
    self.colorLayer.colors = @[(id)[UIColor redColor].CGColor,
                         (id)[UIColor greenColor].CGColor,
                         (id)[UIColor blueColor].CGColor];
    self.colorLayer.startPoint = CGPointMake(0, 1);
    self.colorLayer.endPoint = CGPointMake(1, 1);
    [self.layer addSublayer:self.colorLayer];
}

/**
 *  设置渐变色的遮罩
 */
- (void)setupGradientMaskLayer {
    CAShapeLayer *gradientMaskLayer = [self generateMaskLayer];
    gradientMaskLayer.lineWidth = self.lineWidth;
    self.colorLayer.mask = gradientMaskLayer;
    self.gradientMaskLayer = gradientMaskLayer;
    
}

- (void)setCurrentValue:(CGFloat)currentValue {
    _currentValue = currentValue;
    CGFloat persentage = currentValue / (self.maximumValue - self.minimumValue);
    self.gradientMaskLayer.strokeEnd = persentage;
}

/**
 生成一个圆环形遮罩层
 
 @return 环形遮罩层
 */
- (CAShapeLayer *)generateMaskLayer {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:self.radius startAngle:-M_PI_2 * 2 endAngle:M_PI_2 * 0 clockwise:YES];
    layer.lineWidth = self.lineWidth;
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.lineCap = kCALineCapRound;
    return layer;
}

@end
