//
//  CoreGraphicsDrawView.m
//  OC知识点
//
//  Created by Alan on 2018/7/14.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "CoreGraphicsDrawView.h"

@implementation CoreGraphicsDrawView

- (void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
    [self progressBar];
   
//    [self waterAnimation];
}

- (void)waterAnimation{
    CAShapeLayer * topWaterLayer = [CAShapeLayer layer];
    topWaterLayer.frame = CGRectMake(0, 0, 400, 400);
    topWaterLayer.fillColor = [UIColor whiteColor].CGColor;
    topWaterLayer.strokeColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:topWaterLayer];


    UIView * topWaterDrop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    topWaterDrop.backgroundColor = [UIColor whiteColor];
    topWaterDrop.layer.cornerRadius = 5;
    topWaterDrop.clipsToBounds = YES;
    topWaterDrop.center = CGPointMake(self.frame.size.width/2, -5);
    [self addSubview:topWaterDrop];
    
    
    
}


- (void)progressBar{
    CAShapeLayer * ovalShapeLayer = [CAShapeLayer layer];
    ovalShapeLayer.strokeColor = [UIColor redColor].CGColor;
    ovalShapeLayer.fillColor = [UIColor clearColor].CGColor;
    ovalShapeLayer.lineWidth = 2.0f;
    ovalShapeLayer.lineDashPattern = @[@16,@8];;
    ovalShapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 100) cornerRadius:50].CGPath;
    ovalShapeLayer.position = CGPointMake(60, 60);
    [self.layer addSublayer:ovalShapeLayer];
    
    
    
    CABasicAnimation * strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @(-1);
    strokeStartAnimation.toValue = @(1);
    
    CABasicAnimation * strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0);
    strokeEndAnimation.toValue = @(1.0);
    
    
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[strokeStartAnimation,strokeEndAnimation];
    animationGroup.duration = 2.0;
    animationGroup.repeatCount = CGFLOAT_MAX;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    [ovalShapeLayer addAnimation:animationGroup forKey:nil];
    
}














@end
