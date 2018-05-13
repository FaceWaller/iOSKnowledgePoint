//
//  BlockTestObj.m
//  OC知识点
//
//  Created by Alan on 2018/5/13.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "BlockTestObj.h"

@interface BlockTestObj()
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)void(^myblock)(void);
@end

@implementation BlockTestObj
- (id)init{
    if (self = [super init]) {
        
        
        __block int a = 1;  //不加上__block block内部是访问不到a的
        self.name = @"第一个名字";
        NSLog(@"myName:%@",self.name);
        
        __weak typeof(self) weakSelf = self;
        self.myblock = ^(void){
            a++;
//            self.name = @"Block修改后的名字";//会导致循环引用
            weakSelf.name = @"Block修改后的名字";
            NSLog(@"myName:%@",weakSelf.name);
        };
        NSLog(@"a = %d",a);
        self.myblock();
        NSLog(@"a = %d",a);
        
    }
    return self;
}
- (void)dealloc{
    NSLog(@"%@销毁",[self class]);
}
@end
