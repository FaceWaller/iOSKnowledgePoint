
//  CoreAnimationViewController.m
//  OC知识点
//
//  Created by Alan on 2018/6/7.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "CoreAnimationViewController.h"
#import "PureLayout.h"
#import "customDrawingView.h"
#import "MoveLayerViewController.h"
#import "CAAnimationViewController.h"
#import "ElasticBallViewController.h"
#import "DrawingViewController.h"

@interface CoreAnimationViewController ()<CALayerDelegate>
@property(nonatomic,weak)UIScrollView * scrollView;
@property(nonatomic,weak)UIView * testLayerView;
@property(nonatomic,weak)UIView * layerContentsView;
@property(nonatomic,weak)UIView * layerScaleView;
@property(nonatomic,weak)UIView * layerContentsRectView;
@property(nonatomic,weak)UIView * delegateLayerView;
@property(nonatomic,weak)UIView * anchorPointView;
@property(nonatomic,weak)UIView * visionEffectView;
@property(nonatomic,weak)UIView * affineTransformView;
@property(nonatomic,weak)UIView * transform3DView;
@property(nonatomic,weak)UIView * CAShapeLayerView;
@property(nonatomic,weak)UIView * CATextLayerView;
@property(nonatomic,weak)CALayer * colorLayer;
@property(nonatomic,weak)CALayer * actionColorLayer;
@property(nonatomic,weak)UIButton * moveColorBtn;
@property(nonatomic,weak)UIButton * showAnimationBtn;
@property(nonatomic,weak)UIView * mySelfTransitionView;
@property(nonatomic,weak)UIView * timingFunctionView;
@property(nonatomic,weak)UIButton * elasticBallBtn;//弹性球
@property(nonatomic,weak)UIButton * drawingBtn;

@property(nonatomic,weak)customDrawingView * customDrawingView;
@end

@implementation CoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CoreAnimation";
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 3000);
    self.scrollView = scrollView;
    
    
    
    //测试单独处理图层
    [self testLayer];
 
    //对图层的一些操作
    [self layerContents];
    
    //contentsScale 像素尺寸和视图大小比例
    [self layerScale];
    
    //使用图层操作只显示部分视图
    [self layerContentsRect];
    
//    contentsCenter 可控制图层可拉伸区域
    
    
    //customDrawing绘制寄宿图
    [self layerDelegate];
    
    [self customDrawing];
    
    
    //锚点
    //    锚点 anchorPoint 可以理解为钉住图层的钉子，默认在图层的（0.5，0.5）的位置，做旋转等变换的时候以它为中心
    [self anchorPoint];
    
    
    //视觉效果
    [self visionEffect];
    
    //仿射变换
    [self affineTransform];
    
    //3D变换
    [self transform3D];
    
    
    //专属图层
    
    //CAShapeLayer
    [self CAShapeLayer];
    
    //CATextLayer
    [self CATextLayer];
    
    //隐式动画
    //当改变CALayer的一个可做动画的属性，它并不能立刻在屏幕上体现出来，而是平滑的过渡，这就是隐式动画。
    [self chaneColorAnimation];
    
    //通过layer的action值来进行动画
    [self actionColorAnimation];
    
    //可以移动的图层
    [self moveColorAnimation];
    
    //显式动画
    //属性动画
    [self CAAnimation];
    
    //自定义过渡
    [self mySelfTransition];
    
    //弹性球
    [self elasticBall];
    
    //绘制页面
    [self drawing];
}

- (void)toDrawVC{
    DrawingViewController * vc = [[DrawingViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)drawing{
    UIButton * btn = [[UIButton alloc]init];
    self.drawingBtn = btn;
    btn.backgroundColor = [UIColor blackColor];
    [btn setTitle:@"绘制" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toDrawVC) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:btn];
    
    
    
    [btn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.elasticBallBtn withOffset:20];
    [btn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.elasticBallBtn];
    [btn autoSetDimension:ALDimensionWidth toSize:100];
    [btn autoSetDimension:ALDimensionHeight toSize:40];

}

- (void)toElasticBall{
    ElasticBallViewController * vc = [[ElasticBallViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)elasticBall{
    
    UIButton * btn = [[UIButton alloc]init];
    self.elasticBallBtn = btn;
    btn.backgroundColor = [UIColor blackColor];
    [btn setTitle:@"弹性球" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toElasticBall) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:btn];
    
    
    
    [btn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.showAnimationBtn withOffset:250];
    [btn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.showAnimationBtn];
    [btn autoSetDimension:ALDimensionWidth toSize:100];
    [btn autoSetDimension:ALDimensionHeight toSize:40];
}



- (void)performTransition{
    
    UIGraphicsBeginImageContext(CGSizeMake(200, 200));
    [self.mySelfTransitionView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * coverImage = UIGraphicsGetImageFromCurrentImageContext();
    UIView * converView = [[UIImageView alloc]initWithImage:coverImage];
    [self.mySelfTransitionView addSubview:converView];

    converView.frame = CGRectMake(0, 0, 200, 200);
    
    
    CGFloat red = arc4random()/(CGFloat)INT_MAX;
    CGFloat green = arc4random()/(CGFloat)INT_MAX;
    CGFloat blue = arc4random()/(CGFloat)INT_MAX;
    self.mySelfTransitionView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    [UIView animateWithDuration:1.0 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        converView.transform = transform;
        converView.alpha = 0.0;
    }completion:^(BOOL finished) {
        [converView removeFromSuperview];
    }];
    
    
}

- (void)mySelfTransition{
    UIView * view = [[UIView alloc]init];
    self.mySelfTransitionView = view;
    view.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view];
    
    UIButton * btn = [[UIButton alloc]init];
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitle:@"自定义过渡" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(performTransition) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:btn];
    
    //布局
    [view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.showAnimationBtn withOffset:15];
    [view autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.showAnimationBtn withOffset:-35];
    [view autoSetDimension:ALDimensionWidth toSize:200];
    [view autoSetDimension:ALDimensionHeight toSize:200];
    
    [btn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.mySelfTransitionView];
    [btn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.mySelfTransitionView withOffset:30];
    [btn autoSetDimension:ALDimensionWidth toSize:100];
    [btn autoSetDimension:ALDimensionHeight toSize:40];
    
}

- (void)CAAnimation{

    UIButton * btn = [[UIButton alloc]init];
    self.showAnimationBtn = btn;
    btn.backgroundColor = [UIColor blackColor];
    [btn setTitle:@"显式动画" forState:UIControlStateNormal];
    [self.scrollView addSubview:btn];
    [btn addTarget:self action:@selector(toCAAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    //布局
    [btn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.moveColorBtn withOffset:15];
    [btn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.moveColorBtn withOffset:0];
    [btn autoSetDimension:ALDimensionWidth toSize:100];
    [btn autoSetDimension:ALDimensionHeight toSize:40];
    
}

- (void)toCAAnimation{
    CAAnimationViewController * vc = [[CAAnimationViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)moveColorAnimation{
    UIButton * btn = [[UIButton alloc]init];
    self.moveColorBtn = btn;
    btn.backgroundColor = [UIColor blackColor];
    [btn setTitle:@"移动图层" forState:UIControlStateNormal];
    [self.scrollView addSubview:btn];
    [btn addTarget:self action:@selector(toMoveLayerController) forControlEvents:UIControlEventTouchUpInside];
    
    //布局
    [btn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.CATextLayerView withOffset:480];
    [btn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.CATextLayerView withOffset:10];
    [btn autoSetDimension:ALDimensionWidth toSize:100];
    [btn autoSetDimension:ALDimensionHeight toSize:40];
}

- (void)toMoveLayerController{
    MoveLayerViewController * vc = [[MoveLayerViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)actionColorAnimation{
    
    CALayer * colorLayer = [CALayer layer];
    self.actionColorLayer = colorLayer;
    colorLayer.frame = CGRectMake(20, 1920, 200, 200);
    [self.scrollView.layer addSublayer:colorLayer];
    colorLayer.backgroundColor = [UIColor whiteColor].CGColor;
    //add a custom action
    CATransition * transition = [CATransition animation];
//    transition.type = kCATransitionPush;
    transition.type = kCATransitionReveal;
    
    transition.subtype = kCATransitionFromLeft;
    colorLayer.actions = @{@"backgroundColor":transition};
    
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(250, 1920, 100, 40)];
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitle:@"改变颜色" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(actionChangeColor) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:btn];
}

- (void)actionChangeColor{
    CGFloat red = arc4random()/(CGFloat)INT_MAX;
    CGFloat green = arc4random()/(CGFloat)INT_MAX;
    CGFloat blue = arc4random()/(CGFloat)INT_MAX;
    self.actionColorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
}

- (void)chaneColorAnimation{
    CALayer * colorLayer = [CALayer layer];
    self.colorLayer = colorLayer;
    colorLayer.frame = CGRectMake(20, 1700, 200, 200);
    [self.scrollView.layer addSublayer:colorLayer];
    colorLayer.backgroundColor = [UIColor whiteColor].CGColor;
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(250, 1700, 100, 40)];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"改变颜色" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:btn];
}

- (void)changeColor{
    
    [CATransaction begin]; //动画入栈
    [CATransaction setAnimationDuration:1.0]; //设置动画时间
    //完成块
//    [CATransaction setCompletionBlock:^{
        //动画完成时调用
//        [self changeColor];
//    }];
    
    CGFloat red = arc4random()/(CGFloat)INT_MAX;
    CGFloat green = arc4random()/(CGFloat)INT_MAX;
    CGFloat blue = arc4random()/(CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    [CATransaction commit];
}



- (void)CATextLayer{
    UIView * view = [[UIView alloc]init];
    self.CATextLayerView = view;
    [self.scrollView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    
    //绘制文字
    CATextLayer * textLayer = [CATextLayer layer];
    textLayer.backgroundColor = [UIColor grayColor].CGColor;
    textLayer.frame = CGRectMake(10, 10, 300, 300);
    [view.layer addSublayer:textLayer];
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.wrapped = YES;
    
    //设置分辨率
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    
    
    UIFont * font = [UIFont systemFontOfSize:15];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    NSString * text = @"Hello World,哈哈哈哈哈";
    textLayer.string = text;
    
    
    
    //布局
    [view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.CAShapeLayerView withOffset:15];
    [view autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.visionEffectView withOffset:10];
    [view autoSetDimension:ALDimensionWidth toSize:330];
    [view autoSetDimension:ALDimensionHeight toSize:330];
    
    
    
}

- (void)CAShapeLayer{
    
    UIView * view = [[UIView alloc]init];
    self.CAShapeLayerView = view;
    [self.scrollView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    
  
    
    //画个圆角矩形
    CGRect rect = CGRectMake(200, 100, 150, 150);
    CGSize radii = CGSizeMake(20, 20);
    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    
    
    //画个小人
//    UIBezierPath *path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(150, 100)];
    [path addArcWithCenter:CGPointMake(125, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(125, 125)];
    [path addLineToPoint:CGPointMake(125, 175)];
    [path moveToPoint:CGPointMake(100, 225)];
    [path addLineToPoint:CGPointMake(125, 175)];
    [path addLineToPoint:CGPointMake(150, 225)];
    [path moveToPoint:CGPointMake(75, 150)];
    [path addLineToPoint:CGPointMake(175, 150)];
    
    
    CAShapeLayer * shapeLayer= [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
//    shapeLayer.path = rectPath.CGPath;
    
    [view.layer addSublayer:shapeLayer];
    
    
    
    //布局
    [view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.transform3DView withOffset:100];
    [view autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.visionEffectView withOffset:-20];
    [view autoSetDimension:ALDimensionWidth toSize:360];
    [view autoSetDimension:ALDimensionHeight toSize:360];
    
}



- (void)transform3D{

    UIView * view = [[UIView alloc]init];
    self.transform3DView = view;
    [self.scrollView addSubview:view];
    view.backgroundColor = [UIColor blueColor];
    view.layer.contents = (__bridge id)[UIImage imageNamed:@"mask"].CGImage;
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    view.layer.transform = transform;

    
    //布局
    [view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.visionEffectView withOffset:50];
    [view autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.visionEffectView withOffset:10];
    [view autoSetDimension:ALDimensionWidth toSize:100];
    [view autoSetDimension:ALDimensionHeight toSize:100];
    
}

- (void)affineTransform{
    UIView * view = [[UIView alloc]init];
    self.affineTransformView = view;
    [self.scrollView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    //比例变为0.8
    transform = CGAffineTransformScale(transform, 0.8, 0.8);
    
    //旋转30度
    transform = CGAffineTransformRotate(transform, M_PI/180.0*20.0);
    
    //平移100
    transform = CGAffineTransformTranslate(transform, 100, 0);
    
    view.layer.affineTransform = transform;
    

    
    
    
    //布局
    [view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.anchorPointView withOffset:70];
    [view autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.anchorPointView withOffset:50];
    [view autoSetDimension:ALDimensionWidth toSize:140];
    [view autoSetDimension:ALDimensionHeight toSize:140];
}

- (void)visionEffect{
    UIView * view = [[UIView alloc]init];
    self.visionEffectView = view;
    [self.scrollView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    //布局
    [view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.delegateLayerView withOffset:70];
    [view autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.delegateLayerView withOffset:15];
    [view autoSetDimension:ALDimensionWidth toSize:100];
    [view autoSetDimension:ALDimensionHeight toSize:100];
    
    
    //圆角
    view.layer.cornerRadius = 10;
    
    //图层边框
    view.layer.borderWidth = 2;
    view.layer.borderColor = [UIColor redColor].CGColor;
    
    //阴影
    view.layer.shadowOpacity = 0.8f;
    view.layer.shadowColor = [UIColor yellowColor].CGColor;
//    view.layer.shadowOffset = CGSizeMake(-5, -5);
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowRadius = 5;
    
    //阴影形状
//    CGMutablePathRef squarePath = CGPathCreateMutable();
//    CGPathAddRect(squarePath, NULL, CGRectMake(-25, -25, 150, 150));
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddEllipseInRect(circlePath, NULL, CGRectMake(-25, -25, 150, 150));
//    view.layer.shadowPath = squarePath;
//    CGPathRelease(squarePath);
    view.layer.shadowPath = circlePath;
    CGPathRelease(circlePath);
    
    //蒙版
    CALayer * maskLayer = [CALayer layer];
    maskLayer.frame = CGRectMake(-25, -25, 150, 150);
    maskLayer.contents = (__bridge id)[UIImage imageNamed:@"mask"].CGImage;
    view.layer.mask = maskLayer;
    
    //拉伸过滤 有三种拉伸方式
    //    kCAFilterLinear
    //    kCAFilterNearest
    //    kCAFilterTrilinear
    view.layer.contentsGravity = kCAFilterLinear;

    
    //裁剪从图层多出的内容  也会切掉阴影
//    view.layer.masksToBounds = YES;
    
    
}

- (void)anchorPoint{
    UIView * view = [[UIView alloc]init];
    self.anchorPointView = view;
    [self.scrollView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    
    UIView * pointView = [[UIView alloc]init];
    pointView.backgroundColor = [UIColor redColor];
    pointView.frame = CGRectMake(95, 75, 10, 150);
    pointView.transform = CGAffineTransformMakeRotation(M_PI*0.3);
    //设置锚点  范围（0，0）到（1，1） 设置的锚点会成为中心点
    pointView.layer.anchorPoint = CGPointMake(0.5, 1);
    [view addSubview:pointView];
    
    
    [view autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.delegateLayerView withOffset:5];
    [view autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.delegateLayerView withOffset:25];
    [view autoSetDimension:ALDimensionWidth toSize:200];
    [view autoSetDimension:ALDimensionHeight toSize:150];
}

- (void)customDrawing{
//    customDrawingView * view = [[customDrawingView alloc]init];
//    self.customDrawingView = view;
//    [self.scrollView addSubview:view];
//    view.backgroundColor = [UIColor yellowColor];
//
//
//    [view autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.delegateLayerView withOffset:5];
//    [view autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.delegateLayerView withOffset:25];
//    [view autoSetDimension:ALDimensionWidth toSize:200];
//    [view autoSetDimension:ALDimensionHeight toSize:150];
}


#pragma mark CALayerDelegate
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
    
}

- (void)layerDelegate{
    UIView * view = [[UIView alloc]init];
    self.delegateLayerView = view;
    view.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view];

    CALayer * layer = [CALayer layer];
    layer.frame = CGRectMake(20, 20, 60, 60);
    layer.backgroundColor = [UIColor blueColor].CGColor;
    layer.delegate = self;
    layer.contentsScale = [UIScreen mainScreen].scale;
    [view.layer addSublayer:layer];
    [layer display];
    
    
    
    [view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.layerScaleView withOffset:15];
    [view autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.scrollView withOffset:25];
    [view autoSetDimension:ALDimensionWidth toSize:100];
    [view autoSetDimension:ALDimensionHeight toSize:100];
    
}

- (void)layerContentsRect{
    UIImage * image = [UIImage imageNamed:@"contentsRect"];
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view];
    view.layer.contents = (__bridge id)image.CGImage;

    view.layer.contentsRect = CGRectMake(0.5, 0, 0.5, 0.5);
    
    
    self.layerContentsRectView = view;
    [view autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.layerScaleView withOffset:25];
    [view autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.layerScaleView withOffset:25];
    [view autoSetDimension:ALDimensionWidth toSize:150];
    [view autoSetDimension:ALDimensionHeight toSize:150];
}




- (void)layerScale{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view];
    
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"data:image/jpeg;base64,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"]];
    UIImage * image = [UIImage imageWithData:data];
    view.layer.contents = (__bridge id)image.CGImage;

    //匹配当前屏幕
    view.layer.contentsScale = [UIScreen mainScreen].scale;
  
    self.layerScaleView = view;
    [view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.testLayerView withOffset:40];
    [view autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.testLayerView];
    [view autoSetDimension:ALDimensionWidth toSize:180];
    [view autoSetDimension:ALDimensionHeight toSize:180];
}

- (void)layerContents{
    
    UIView * view = [[UIView alloc]init];
    self.layerContentsView = view;
    view.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view];
    
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://pic.qqtn.com/up/2017-11/15106514268869200.jpg"]];
    UIImage * image = [UIImage imageWithData:data];
    //给图层加一个图片
    view.layer.contents = (__bridge id)image.CGImage;
    //设置图层拉伸模式
    view.layer.contentsGravity = kCAGravityResizeAspect;
    
    

    
    [view autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.testLayerView];
    [view autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.testLayerView withOffset:30];
    [view autoSetDimension:ALDimensionWidth toSize:100];
    [view autoSetDimension:ALDimensionHeight toSize:140];
}
   

- (void)testLayer{
    
    UIView * view = [[UIView alloc]init];
    self.testLayerView = view;
    view.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view];
    
    
    //图层覆盖  单独处理图层
    CALayer * blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(0, 0, 50,50);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    [view.layer addSublayer:blueLayer];
    
    
    
    [view autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.scrollView withOffset:99];
    [view autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.scrollView withOffset:15];
    [view autoSetDimension:ALDimensionWidth toSize:150];
    [view autoSetDimension:ALDimensionHeight toSize:100];
}


@end
