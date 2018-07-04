//
//  DrawingViewController.m
//  OC知识点
//
//  Created by Alan on 2018/7/5.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "DrawingViewController.h"
#import "DrawingView.h"

@interface DrawingViewController ()

@end

@implementation DrawingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绘制";
    
    
    DrawingView * view = [[DrawingView alloc]init];
    view.frame = self.view.frame;
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
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
