
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
@property(nonatomic,assign)int tickets;
@property(nonatomic,strong)NSLock * mutexLock;
@end

@implementation ThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"多线程";
    self.mutexLock = [[NSLock alloc]init];
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
    
    //线程锁
    UIButton * threadLockBtn = [[UIButton alloc]init];
    threadLockBtn.backgroundColor = [UIColor grayColor];
    [threadLockBtn setTitle:@"线程锁" forState:UIControlStateNormal];
    [self.view addSubview:threadLockBtn];
    [threadLockBtn addTarget:self action:@selector(threadLock) forControlEvents:UIControlEventTouchUpInside];
    
    //线程依赖
    UIButton * threadRelyBtn = [[UIButton alloc]init];
    threadRelyBtn.backgroundColor = [UIColor grayColor];
    [threadRelyBtn setTitle:@"线程依赖" forState:UIControlStateNormal];
    [self.view addSubview:threadRelyBtn];
    [threadRelyBtn addTarget:self action:@selector(threadRely) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
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
    
    
    [threadLockBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:badlockBtn];
    [threadLockBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:badlockBtn];
    [threadLockBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:gcdBtn];
    [threadLockBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:gcdBtn];
    
    [threadRelyBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:badlockBtn withOffset:40];
    [threadRelyBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:badlockBtn];
    [threadRelyBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:badlockBtn];
    [threadRelyBtn autoSetDimension:ALDimensionHeight toSize:50];
    
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

- (void)threadLock{
    _tickets = 10;
    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    //        [self saleTickets];
    //    });
    //
    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    //        [self saleTickets];
    //    });
    
    NSThread * threadOne = [[NSThread alloc] initWithTarget:self selector:@selector(sellTicket) object:nil];
    //设置线程名称
    threadOne.name = @"售票员1";
    
    //创建售票员2
    NSThread * threadTwo = [[NSThread alloc] initWithTarget:self selector:@selector(sellTicket) object:nil];
    threadTwo.name = @"售票员2";
    
    //启动线程
    [threadOne start];
    [threadTwo start];
    
}



//售票方法
-(void)sellTicket{
    //获取当前线程
    NSThread * currentThread = [NSThread currentThread];
    
    //一直卖票,直到票数为0
    while(1){
//        @synchronized(self){  //第一种加锁
        [_mutexLock lock];  //第二种加锁
            int total = self.tickets;
            if(self.tickets > 0){
                //让当前线程睡眠0.1秒
                [NSThread sleepForTimeInterval:0.1];
                //打印卖票日志
                NSLog(@"%@卖出一张票,票号为%d",currentThread,self.tickets);
                //票数减一
                self.tickets = --total;
            }else{
                NSLog(@"票卖完了.%@",currentThread);
                break;
            }
        [_mutexLock unlock];
//        }
    }
}


//线程依赖
- (void)threadRely{
    
    NSOperationQueue * queue = [[NSOperationQueue alloc]init];
    
    //创建三个操作
    NSOperation * a = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"打印a");
    }];
    NSOperation * b = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"打印b");
    }];
    NSOperation * c = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"打印c");
    }];
    
    //添加依赖
    [a addDependency:b];
    [b addDependency:c];
    
    [queue addOperation:a];
    [queue addOperation:b];
    [queue addOperation:c];
    
}


@end
