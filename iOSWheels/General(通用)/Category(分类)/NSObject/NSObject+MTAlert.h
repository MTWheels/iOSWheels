//
//  NSObject+MTAlert.h
//  iOSWheels
//
//  Created by liyan on 2018/5/18.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MTAlert)


/**
 弹出alertController，并且有两个个action按钮，分别有处理事件
 
 @param title title
 @param message Message
 @param confirmTitle 右边按钮的title
 @param cancelTitle 左边按钮的title
 @param confirmAction 右边按钮的点击事件
 @param cancelAction 左边按钮的点击事件
 */
+ (void)mt_showAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                 confirmTitle:(NSString *)confirmTitle
                  cancleTitle:(NSString *)cancelTitle
                confirmAction:(void(^)(void))confirmAction
                 cancleAction:(void(^)(void))cancelAction;

@end
