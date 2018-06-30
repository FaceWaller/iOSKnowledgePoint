//
//  MoveLayerViewController.m
//  OC知识点
//
//  Created by Alan on 2018/6/30.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "MoveLayerViewController.h"

@interface MoveLayerViewController ()
@property(nonatomic,weak)CALayer * moveColorLayer;

@end

@implementation MoveLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"MoveLayer"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CALayer * layer = [[CALayer alloc]init];
    [self.view.layer addSublayer:layer];
    layer.borderWidth = 1;
    layer.borderColor = [UIColor redColor].CGColor;
    self.moveColorLayer = layer;
    layer.frame = CGRectMake(0, 0, 100, 100);
    layer.position = self.view.center;
    layer.backgroundColor = [UIColor grayColor].CGColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject]locationInView:self.view];
    if ([self.moveColorLayer.presentationLayer hitTest:point]) {

        CGFloat red = arc4random()/(CGFloat)INT_MAX;
        CGFloat green = arc4random()/(CGFloat)INT_MAX;
        CGFloat blue = arc4random()/(CGFloat)INT_MAX;
        self.moveColorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    }else{
        [CATransaction begin];
        [CATransaction setAnimationDuration:4.0];
        self.moveColorLayer.position = point;
        [CATransaction commit];
    }
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
