//
//  NetWorkingViewController.m
//  OC知识点
//
//  Created by Alan on 2018/7/10.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "NetWorkingViewController.h"
#import "PureLayout.h"
#import "AFNetworking.h"

@interface NetWorkingViewController ()
@property(nonatomic,weak)UIButton * connectionBtn;
@property(nonatomic,weak)UIButton * sessionBtn;
@property(nonatomic,weak)UIButton * afnetBtn;
@end

@implementation NetWorkingViewController

- (UIButton *)connectionBtn{
    if (!_connectionBtn) {
        UIButton * btn = [[UIButton alloc]init];
        [btn setTitle:@"connection" forState:UIControlStateNormal];
        [self.view addSubview:btn];
        btn.backgroundColor = [UIColor grayColor];
        [btn addTarget:self action:@selector(connection) forControlEvents:UIControlEventTouchUpInside];
        _connectionBtn = btn;
    }
    return _connectionBtn;
}

- (UIButton *)sessionBtn{
    if (!_sessionBtn) {
        UIButton * btn = [[UIButton alloc]init];
        [btn setTitle:@"sessionBtn" forState:UIControlStateNormal];
        [self.view addSubview:btn];
        btn.backgroundColor = [UIColor grayColor];
        [btn addTarget:self action:@selector(session) forControlEvents:UIControlEventTouchUpInside];
        _sessionBtn = btn;
    }
    return _sessionBtn;
}
- (UIButton *)afnetBtn{
    if (!_afnetBtn) {
        UIButton * btn = [[UIButton alloc]init];
        [btn setTitle:@"afnetBtn" forState:UIControlStateNormal];
        [self.view addSubview:btn];
        btn.backgroundColor = [UIColor grayColor];
        [btn addTarget:self action:@selector(afnet) forControlEvents:UIControlEventTouchUpInside];
        _afnetBtn = btn;
    }
    return _afnetBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"networking";
    [self setupUI];
}

- (void)setupUI{
    [self.connectionBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:88];
    [self.connectionBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:15];
    [self.connectionBtn autoSetDimension:ALDimensionWidth toSize:150];
    [self.connectionBtn autoSetDimension:ALDimensionHeight toSize:50];
    
    [self.sessionBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:88];
    [self.sessionBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-15];
    [self.sessionBtn autoSetDimension:ALDimensionWidth toSize:150];
    [self.sessionBtn autoSetDimension:ALDimensionHeight toSize:50];
    
    [self.afnetBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.connectionBtn withOffset:30];
    [self.afnetBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.connectionBtn];
    [self.afnetBtn autoSetDimension:ALDimensionWidth toSize:150];
    [self.afnetBtn autoSetDimension:ALDimensionHeight toSize:50];

}

- (void)connection{
    
    //已弃用的方式
    
    NSURL * url = [NSURL URLWithString:@"http://img4.imgtn.bdimg.com/it/u=1910514605,2172291467&fm=27&gp=0.jpg"];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:10];
    
    
    //NSURLConnection 可进行同步或异步请求，同步请求会阻碍线程，等请求执行完再执行后面的操作
    
    //同步
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(@"%@",data);
    
    
    
    //异步
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"%@",data);
    }];
    
    //用协议代理方式，可以进行下载进度条的实现，这里不写了
}

- (void)session{
    
    NSURL * url = [NSURL URLWithString:@"http://img4.imgtn.bdimg.com/it/u=1910514605,2172291467&fm=27&gp=0.jpg"];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:10];
    
    NSURLSession * session = [NSURLSession sharedSession];
    
    
    //请求
    NSURLSessionDataTask * dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",data);
    }];
    [dataTask resume];
    
    //也可以通过代理获取实时的下载情况
}

- (void)afnet{
    NSURL * url = [NSURL URLWithString:@"http://img4.imgtn.bdimg.com/it/u=1910514605,2172291467&fm=27&gp=0.jpg"];
    AFHTTPSessionManager * httpManager = [[AFHTTPSessionManager alloc]initWithBaseURL:url sessionConfiguration:nil];
    
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer]requestWithMethod:@"GET" URLString:@"http://img4.imgtn.bdimg.com/it/u=1910514605,2172291467&fm=27&gp=0.jpg" parameters:nil error:nil];
    
    
    
}


@end
