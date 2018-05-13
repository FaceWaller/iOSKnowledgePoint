//
//  MainViewController.m
//  OC知识点
//
//  Created by Alan on 2018/5/12.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "MainViewController.h"
#import "TestView.h"
#import "BlockTestObj.h"
#import "ThreadViewController.h"
@interface MainViewController ()<ChangeColor>
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = @"iOS知识点";
    
#pragma mark 代理和block回调
     /*通过代理和block回调，点击testView改变根视图背景颜色*/
    
    TestView * testView = [[TestView alloc]initWithFrame:CGRectMake(50, 100, 50, 50)];
//    testView.delegate = self;
    
    testView.changeBackgroundColor = ^(UIColor *color) {
        self.view.backgroundColor = color;
    };
    testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];
    
    

    
#pragma mark block
    BlockTestObj * blockTest = [[BlockTestObj alloc]init];
    
    
    

#pragma mark 多线程
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(150, 100, 100, 50)];
    [btn setTitle:@"多线程" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(testThread) forControlEvents:UIControlEventTouchUpInside];

}

- (void)testThread{
    ThreadViewController * thread = [[ThreadViewController alloc]init];
    [self.navigationController pushViewController:thread animated:YES];
}



- (void)changeBackgroundColor{
    self.view.backgroundColor = [UIColor blueColor];
}


@end
