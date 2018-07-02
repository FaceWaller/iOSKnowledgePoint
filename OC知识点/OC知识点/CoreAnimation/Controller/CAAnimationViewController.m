//
//  CAAnimationViewController.m
//  OC知识点
//
//  Created by Alan on 2018/6/30.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "CAAnimationViewController.h"

@interface CAAnimationViewController ()
@property(nonatomic,weak)UIButton * CABasicBtn;
@property(nonatomic,weak)UIButton * CAKeyAnimationBtn;
@property(nonatomic,weak)UIButton * BezierAnimationBtn;
@property(nonatomic,weak)CALayer * colorLayer;
@property(nonatomic,weak)CALayer * shipLayer;
@property(nonatomic,strong)UIBezierPath * bezierPath;
@end

@implementation CAAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    
    
    
    CALayer * layer = [CALayer layer];
    self.colorLayer = layer;
    layer.frame = CGRectMake(100, 150, 100, 100);
    layer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:layer];
}

- (void)setupUI{
    UIButton * CABasicBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 80, 100, 40)];
    self.CABasicBtn = CABasicBtn;
    CABasicBtn.backgroundColor = [UIColor blackColor];
    [CABasicBtn addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
    [CABasicBtn setTitle:@"属性动画" forState:UIControlStateNormal];
    [self.view addSubview:CABasicBtn];
    
    
    //关键帧动画
    UIButton * CAKeyAnimationBtn = [[UIButton alloc]initWithFrame:CGRectMake(140, 80, 100, 40)];
    self.CAKeyAnimationBtn = CAKeyAnimationBtn;
    CAKeyAnimationBtn.backgroundColor = [UIColor blackColor];
    [CAKeyAnimationBtn addTarget:self action:@selector(changeKeyColor) forControlEvents:UIControlEventTouchUpInside];
    [CAKeyAnimationBtn setTitle:@"关键帧动画" forState:UIControlStateNormal];
    [self.view addSubview:CAKeyAnimationBtn];
    
    
    //关键帧曲线动画
    UIButton * BezierAnimationBtn = [[UIButton alloc]initWithFrame:CGRectMake(260, 80, 100, 40)];
    self.BezierAnimationBtn = BezierAnimationBtn;
    BezierAnimationBtn.backgroundColor = [UIColor blackColor];
    [BezierAnimationBtn addTarget:self action:@selector(BezierAnimation) forControlEvents:UIControlEventTouchUpInside];
    [BezierAnimationBtn setTitle:@"Bezier动画" forState:UIControlStateNormal];
    [self.view addSubview:BezierAnimationBtn];
    
    
    
    //曲线路径
    UIBezierPath * bezierPath = [[UIBezierPath alloc]init];
    self.bezierPath = bezierPath;
    [bezierPath moveToPoint:CGPointMake(50, 400)];
    [bezierPath addCurveToPoint:CGPointMake(350, 400) controlPoint1:CGPointMake(125, 250) controlPoint2:CGPointMake(275, 550)];
    //draw a CAShapeLayer
    CAShapeLayer * pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.view.layer addSublayer:pathLayer];
    
    //add a ship
    CALayer * shipLayer = [CALayer layer];
    self.shipLayer = shipLayer;
    shipLayer.frame = CGRectMake(0, 0, 64, 64);
    shipLayer.position = CGPointMake(50, 400);
    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"ship.jpg"].CGImage;
    [self.view.layer addSublayer:shipLayer];
    
}

- (void)BezierAnimation{
    
    //沿曲线运动
    CAKeyframeAnimation * keyAnimation = [CAKeyframeAnimation animation];
    keyAnimation.rotationMode = kCAAnimationRotateAuto;//自动旋转
    keyAnimation.keyPath = @"position";
    keyAnimation.path = self.bezierPath.CGPath;
    keyAnimation.duration = 4.0;
    [self.shipLayer addAnimation:keyAnimation forKey:nil];
    
    
    /*
    //原地旋转
    CABasicAnimation * basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"transform.rotation";
    basicAnimation.byValue = @(M_PI*2);
//    basicAnimation.duration = 4.0;
//    [self.shipLayer addAnimation:basicAnimation forKey:nil];
    
    //组动画
    CAAnimationGroup * groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[keyAnimation,basicAnimation];
    groupAnimation.duration = 2;
    [self.shipLayer addAnimation:groupAnimation forKey:nil];
     */
}


- (void)changeKeyColor{
    
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[
                         (__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor,
                         ];
    [self.colorLayer addAnimation:animation forKey:nil];
    
}

- (void)changeColor{
    CGFloat red = arc4random()/(CGFloat)INT_MAX;
    CGFloat green = arc4random()/(CGFloat)INT_MAX;
    CGFloat blue = arc4random()/(CGFloat)INT_MAX;
    UIColor * color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.toValue = (__bridge id)color.CGColor;
    animation.delegate = self;
    [self.colorLayer addAnimation:animation forKey:nil];
}

- (void)animationDidStart:(CAAnimation *)anim{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [CATransaction begin];
    
    [CATransaction setDisableActions:YES];//禁用隐式动画
    CABasicAnimation * basicAnim = anim;
    self.colorLayer.backgroundColor = (__bridge CGColorRef)basicAnim.toValue;
    [CATransaction commit];
    
    
}


@end
