
//
//  ThreadViewController.m
//  OC知识点
//
//  Created by Alan on 2018/5/13.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "ThreadViewController.h"
#import "PureLayout.h"
@interface ThreadViewController ()

@end

@implementation ThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"多线程";
    [self setUpUI];
}


- (void)setUpUI{
    //NSThread
    UIButton * nsthreadBtn = [[UIButton alloc]init];
    nsthreadBtn.backgroundColor = [UIColor grayColor];
    [nsthreadBtn setTitle:@"NSThread" forState:UIControlStateNormal];
    [self.view addSubview:nsthreadBtn];
    [nsthreadBtn addTarget:self action:@selector(nsthreadAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    //GCD
    UIButton * gcdBtn = [[UIButton alloc]init];
    gcdBtn.backgroundColor = [UIColor grayColor];
    [gcdBtn setTitle:@"gcd" forState:UIControlStateNormal];
    [self.view addSubview:gcdBtn];
    [gcdBtn addTarget:self action:@selector(gcd) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    //布局
    [nsthreadBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:80];
    [nsthreadBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:20];
    [nsthreadBtn autoSetDimension:ALDimensionWidth toSize:150];
    [nsthreadBtn autoSetDimension:ALDimensionHeight toSize:50];
    
    
//    [gcdBtn autoAlignAxis:ALAxisVertical toSameAxisOfView:nsthreadBtn];
    [gcdBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:80];
    [gcdBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-20];
    [gcdBtn autoSetDimension:ALDimensionWidth toSize:150];
    [gcdBtn autoSetDimension:ALDimensionHeight toSize:50];

}

- (void)nsthreadAction{
    //NSThread 有三种创建方法
    //第一种
    //    NSThread * thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(thread1:) object:@"thread1"];
//    [thread1 start];
    
    //方法二，创建好之后自动启动
    //    [NSThread detachNewThreadSelector:@selector(thread1:) toTarget:self withObject:@"thread1"];
    
    //第三种 隐式创建，直接启动
    [self performSelectorInBackground:@selector(thread1:) withObject:@"thread1"];
    
}
- (void)thread1:(NSObject *)obj{
    [NSThread sleepForTimeInterval:3];
    NSLog(@"%@执行",obj);
}

- (void)gcd{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"gcd异步执行");
    });
    
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"gcd同步执行");
    });
    
    
    
    
}




@end
