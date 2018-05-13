
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
    
    //死锁
    UIButton * badlockBtn = [[UIButton alloc]init];
    badlockBtn.backgroundColor = [UIColor grayColor];
    [badlockBtn setTitle:@"死锁" forState:UIControlStateNormal];
    [self.view addSubview:badlockBtn];
    [badlockBtn addTarget:self action:@selector(badlock) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    //布局
    [nsthreadBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:80];
    [nsthreadBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:20];
    [nsthreadBtn autoSetDimension:ALDimensionWidth toSize:150];
    [nsthreadBtn autoSetDimension:ALDimensionHeight toSize:50];
    
    
    [gcdBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:nsthreadBtn];
    [gcdBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-20];
    [gcdBtn autoSetDimension:ALDimensionWidth toSize:150];
    [gcdBtn autoSetDimension:ALDimensionHeight toSize:50];

    [badlockBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:nsthreadBtn withOffset:40];
    [badlockBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:nsthreadBtn];
    [badlockBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:nsthreadBtn];
    [badlockBtn autoSetDimension:ALDimensionHeight toSize:50];
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
    
    //快速迭代
    dispatch_apply(7, dispatch_get_global_queue(0, 0), ^(size_t index) {
        NSLog(@"dispatch_apply：%zd======%@",index, [NSThread currentThread]);
    });
    
    //队列组
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"组内第一个操作");
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"组内第二个操作");
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"组内第三个操作");
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"组内第四个操作");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"其他组内任务都已经完成了。");
    });
}

- (void)badlock{
    dispatch_sync(dispatch_get_main_queue(), ^(void){
        NSLog(@"这里死锁了");
    });
}




@end
