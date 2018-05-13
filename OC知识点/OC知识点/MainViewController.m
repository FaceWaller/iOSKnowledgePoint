//
//  MainViewController.m
//  OC知识点
//
//  Created by Alan on 2018/5/12.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "MainViewController.h"
#import "TestView.h"
#import "TestObj.h"
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
    
//    TestObj * obj = [[TestObj alloc]init];;
    __block int a = 1;  //不加上__block block内部是访问不到a的
    void (^changeIntBlock)(void) = ^(void){
        a++;
    };
    NSLog(@"a = %d",a);
    changeIntBlock();
    NSLog(@"a = %d",a);
    
    
}

- (void)changeBackgroundColor{
    self.view.backgroundColor = [UIColor blueColor];
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
