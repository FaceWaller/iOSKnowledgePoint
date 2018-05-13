//
//  TestView.h
//  OC知识点
//
//  Created by Alan on 2018/5/12.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^changeColor)(UIColor * color);

@protocol ChangeColor
- (void)changeBackgroundColor;
@end

@interface TestView : UIView
@property(nonatomic,weak)id<ChangeColor> delegate;

/*block两种写法*/
//@property(nonatomic,copy)changeColor changeBackgroundColor;
@property(nonatomic,copy)void (^changeBackgroundColor)(UIColor * color);
@end
