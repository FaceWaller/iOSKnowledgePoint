//
//  RunLoopViewController.m
//  OC知识点
//
//  Created by Alan on 2018/5/15.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "RunLoopViewController.h"

@interface RunLoopViewController ()

@end

@implementation RunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RunLoop";
    
    
//    NSRunLoop 是基于 CFRunLoopRef的封装;
    
#pragma mark   RunLoop 与线程的关系？
//    pthread_t
//    CFRunLoopGetMain();
//    CFRunLoopGetCurrent();
//    static CFMutableDictionaryRef loopsDic;
    
    dispatch_async(dispatch_queue_create(0, 0), ^{
        //保证这个线程不退出
        [[NSThread currentThread] setName:@"线程保活"];
        NSRunLoop * runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    });
    
    
    
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
