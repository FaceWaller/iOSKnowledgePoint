//
//  MainViewController.m
//  OC知识点
//
//  Created by Alan on 2018/5/12.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "MainViewController.h"
#import "PureLayout.h"
#import "TestView.h"
#import "BlockTestObj.h"
#import "ThreadViewController.h"
@interface MainViewController ()<ChangeColor>
@property(nonatomic,weak)TestView * testView;
@property(nonatomic,weak)UIButton * threadBtn;
@property(nonatomic,weak)UIButton * timerBtn;
@end

@implementation MainViewController

- (TestView *)testView{
    if (!_testView) {
        
        TestView * testView = [[TestView alloc]init];
        testView.text = @"回调";
        testView.textAlignment = NSTextAlignmentCenter;
        //    testView.delegate = self;
        
        testView.changeBackgroundColor = ^(UIColor *color) {
            self.view.backgroundColor = color;
        };
        testView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:testView];
        _testView = testView;
    }
    return _testView;
}

- (UIButton *)threadBtn{
    if (!_threadBtn) {
        
        #pragma mark 多线程
        UIButton * btn = [[UIButton alloc]init];
        [btn setTitle:@"多线程" forState:UIControlStateNormal];
        [self.view addSubview:btn];
        btn.backgroundColor = [UIColor grayColor];
        [btn addTarget:self action:@selector(testThread) forControlEvents:UIControlEventTouchUpInside];
        _threadBtn = btn;
    }
    return _threadBtn;
}

- (UIButton *)timerBtn{
    if (!_timerBtn) {
        UIButton * btn = [[UIButton alloc]init];
        [btn setTitle:@"NSTimer" forState:UIControlStateNormal];
        [self.view addSubview:btn];
        btn.backgroundColor = [UIColor grayColor];
        [btn addTarget:self action:@selector(timer) forControlEvents:UIControlEventTouchUpInside];
        _timerBtn = btn;
    }
    return _timerBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = @"iOS知识点";
    
    [self setupUI];
    
    
    
#pragma mark block
    BlockTestObj * blockTest = [[BlockTestObj alloc]init];
    
    
    NSRunLoop * loop = [[NSRunLoop alloc]init];
}

- (void)setupUI{
    //布局
    [self.testView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:80];
    [self.testView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:20];
    [self.testView autoSetDimension:ALDimensionWidth toSize:150];
    [self.testView autoSetDimension:ALDimensionHeight toSize:50];
    
    [self.threadBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.testView];
    [self.threadBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-20];
    [self.threadBtn autoSetDimension:ALDimensionWidth toSize:150];
    [self.threadBtn autoSetDimension:ALDimensionHeight toSize:50];
    
    
    [self.timerBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.testView withOffset:50];
    [self.timerBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.testView];
    [self.timerBtn autoSetDimension:ALDimensionWidth toSize:150];
    [self.timerBtn autoSetDimension:ALDimensionHeight toSize:50];
    
}

- (void)testThread{
    ThreadViewController * thread = [[ThreadViewController alloc]init];
    [self.navigationController pushViewController:thread animated:YES];
}



- (void)changeBackgroundColor{
    self.view.backgroundColor = [UIColor blueColor];
}


- (void)timer{
    
    //线程繁忙的时候，NSTimer会不准
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(logTime) userInfo:nil repeats:YES];

}
- (void)logTime{
    int count = 0;
    for (int i = 0; i < 1000000000; i++) {
        count += i;
    }
    NSLog(@"time test");
}

@end
