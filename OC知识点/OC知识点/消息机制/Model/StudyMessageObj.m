//
//  StudyMessageObj.m
//  OC知识点
//
//  Created by Alan on 2018/5/23.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "StudyMessageObj.h"
#import <objc/runtime.h>

@implementation StudyMessageObj

void myMethod(id self,SEL _cmd){
    NSLog(@"This is added dynamic");
}



//判断本类是否能够处理sel方法，能处理就返回yes
+ (BOOL)resolveInstanceMethod:(SEL)sel{

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if (sel == @selector(sendMessage)) {
        
        /** 动态添加方法
         *  class_addMethod  对应的参数如下：
         *  cls 想要添加的类
         *  name 添加后的方法selector名字
         *  imp 具体的方法实现
         *  types 方法参数的编码 详见：https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1
         *
         */
        class_addMethod([self class], sel, (IMP)myMethod, "v@:");
        return YES;
    }else{
        return [super resolveInstanceMethod:sel];
    }
}

@end
