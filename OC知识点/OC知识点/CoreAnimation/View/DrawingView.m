//
//  DrawingView.m
//  OC知识点
//
//  Created by Alan on 2018/7/4.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "DrawingView.h"

@interface DrawingView()
@property(nonatomic,strong)UIBezierPath * path;
@end

@implementation DrawingView

- (instancetype)init{
    if (self = [super init]) {
        self.path = [[UIBezierPath alloc]init];
        
        CAShapeLayer * shapeLayer = (CAShapeLayer *)self.layer;
        shapeLayer.strokeColor = [UIColor redColor].CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.lineWidth = 5;
    }
    return self;
}

+(Class)layerClass{
    return [CAShapeLayer class];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    
    [self.path moveToPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    
    [self.path addLineToPoint:point];
    
    ((CAShapeLayer *)self.layer).path = self.path.CGPath;
}



@end
