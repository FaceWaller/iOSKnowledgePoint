//
//  TestView.m
//  OC知识点
//
//  Created by Alan on 2018/5/12.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "TestView.h"

@implementation TestView


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
//    [self.delegate changeBackgroundColor]; //代理方法
    self.changeBackgroundColor([UIColor yellowColor]); //block方法
}




@end
