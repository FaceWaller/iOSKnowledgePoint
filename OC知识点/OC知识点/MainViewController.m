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
@interface MainViewController ()<ChangeColor>
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
#pragma mark 代理和block回调
     /*通过代理和block回调，点击testView改变根视图背景颜色*/
    
    TestView * testView = [[TestView alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
//    testView.delegate = self;
    
    testView.changeBackgroundColor = ^(UIColor *color) {
        self.view.backgroundColor = color;
    };
    testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];
    
    

    
#pragma mark block
    BlockTestObj * blockTest = [[BlockTestObj alloc]init];
    
    
    
}

- (void)changeBackgroundColor{
    self.view.backgroundColor = [UIColor blueColor];
}


@end
