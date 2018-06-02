//
//  StudyMessageViewController.m
//  OC知识点
//
//  Created by Alan on 2018/5/23.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "StudyMessageViewController.h"
#import "StudyMessageSunObj.h"
#import "PureLayout.h"

@interface StudyMessageViewController ()
@property(nonatomic,weak)UIButton * sendMessageBtn;
@property(nonatomic,strong)StudyMessageSunObj * messageSunObj;

@end

@implementation StudyMessageViewController

- (UIButton *)sendMessageBtn{
    if (!_sendMessageBtn) {
        UIButton * btn = [[UIButton alloc]init];
        [btn setTitle:@"发送消息" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor grayColor];
        self.sendMessageBtn = btn;
        [self.view addSubview:btn];
    }
    return _sendMessageBtn;
}

- (StudyMessageSunObj *)messageSunObj{
    if (!_messageSunObj) {
        StudyMessageSunObj * messageSunObj = [[StudyMessageSunObj alloc]init];
        _messageSunObj = messageSunObj;
    }
    return _messageSunObj;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];

    }

- (void)sendMessage{
    //动态方法
    [self.messageSunObj performSelector:@selector(sendMessage) withObject:nil];
//    [self.messageSunObj performSelector:@selector(sendMessageaaa) withObject:nil];

}

- (void)setupUI{
    [self setTitle:@"StudyMessage"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.sendMessageBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:100];
    [self.sendMessageBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:20];
    [self.sendMessageBtn autoSetDimension:ALDimensionWidth toSize:100];
    [self.sendMessageBtn autoSetDimension:ALDimensionHeight toSize:50];
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
