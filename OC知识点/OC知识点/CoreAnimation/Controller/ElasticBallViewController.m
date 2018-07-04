//
//  ElasticBallViewController.m
//  OC知识点
//
//  Created by Alan on 2018/7/2.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "ElasticBallViewController.h"

@interface ElasticBallViewController ()

@property(nonatomic,weak)UIView * ballView;
@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,assign)NSTimeInterval duration;
@property(nonatomic,assign)NSTimeInterval timeOffset;
@property(nonatomic,strong)id fromValue;
@property(nonatomic,strong)id toValue;

@end

@implementation ElasticBallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView * ballView = [[UIView alloc]initWithFrame:CGRectMake(80, 80, 40, 40)];
    self.ballView = ballView;
    ballView.backgroundColor = [UIColor redColor];
    ballView.layer.cornerRadius = 20;
    [self.view addSubview:ballView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self animate];
}

float interpolate(float from,float to, float time){
    return (to - from)*time + from;
}

- (id)interpolateFromValue:(id)fromValue toValue:(id)toValue time:(float)time{
    if ([fromValue isKindOfClass:[NSValue class]]) {
        const char * type = [(NSValue *)fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interpolate(from.x,to.x,time), interpolate(from.y,to.y,time));
            return [NSValue valueWithCGPoint:result];
        }
    }
    return (time<0.5)?fromValue:toValue;
}

float bounceEaseOut(float t){
    if (t < 4/11.0) {
        return (121 * t * t)/16.0;
    } else if (t < 811.0){
        return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
    } else if (t < 9/10.0){
        return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
    }
    return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
}

- (void)animate{
    self.ballView.center = CGPointMake(150, 32);
    self.duration = 2.0;
    self.timeOffset = 0.0;
    self.fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 32)];
    self.toValue = [NSValue valueWithCGPoint:CGPointMake(150, 600)];
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1/60.0 target:self selector:@selector(step) userInfo:nil repeats:YES];
    
    
}

- (void)step{
    self.timeOffset = MIN(self.timeOffset+1/60.0, self.duration);
    float time = self.timeOffset/self.duration;
    time = bounceEaseOut(time);
    id position = [self interpolateFromValue:self.fromValue toValue:self.toValue time:time];
    self.ballView.center = [position CGPointValue];
    if (self.timeOffset >= self.duration) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


@end
