//
//  CoreGraphicsViewController.m
//  OC知识点
//
//  Created by Alan on 2018/7/14.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "CoreGraphicsViewController.h"
#import "CoreGraphicsDrawView.h"
#import "PureLayout.h"

@interface CoreGraphicsViewController ()
@property(nonatomic,weak)CoreGraphicsDrawView * drawView;
@end

@implementation CoreGraphicsViewController

- (CoreGraphicsDrawView *)drawView{
    if (!_drawView) {
        CoreGraphicsDrawView * view = [[CoreGraphicsDrawView alloc]init];
        _drawView = view;
        [self.view addSubview:view];
    }
    return _drawView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"CoreGraphics"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    self.drawView.backgroundColor = [UIColor grayColor];

    
}



- (void)setupUI{
    [self.drawView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:88];
    [self.drawView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:15];
    [self.drawView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view withOffset:-15];
    [self.drawView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-15];
}



@end
