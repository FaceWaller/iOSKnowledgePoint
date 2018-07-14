//
//  StudyMessageSonObj.m
//  OC知识点
//
//  Created by Alan on 2018/5/24.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "StudyMessageSonObj.h"
#import "StudyMessageTar.h"

@interface StudyMessageSonObj()
@property(nonatomic,strong)StudyMessageTar * tar;
@end

@implementation StudyMessageSonObj

- (StudyMessageTar *)tar{
    if (!_tar) {
        _tar = [[StudyMessageTar alloc]init];
    }
    return _tar;
}


//判断本类是否能够处理sel方法，能处理就返回yes
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    return YES;
}




//转发方法  让转发到的对象执行aSelector
- (id)forwardingTargetForSelector:(SEL)aSelector{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if (aSelector == @selector(sendMessage)) {
        return self.tar;
    }else{
        return [super forwardingTargetForSelector:aSelector];
    }
}

-(void)forwardInvocation:(NSInvocation *)anInvocation{
    if ([self.tar respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:self.tar];
    }else{
        [super forwardInvocation:anInvocation];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    return [StudyMessageTar instanceMethodSignatureForSelector:aSelector];
//    if(aSelector == @selector(sendMessageaaa))
//    {
//        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//    }
    return nil ;
}


@end
