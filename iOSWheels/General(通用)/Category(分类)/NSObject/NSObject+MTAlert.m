//
//  NSObject+MTAlert.m
//  iOSWheels
//
//  Created by liyan on 2018/5/18.
//  Copyright © 2018年 方新俊. All rights reserved.
//  

#import "NSObject+MTAlert.h"

@implementation NSObject (MTAlert)

+ (void)mt_showAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                 confirmTitle:(NSString *)confirmTitle
                  cancleTitle:(NSString *)cancelTitle
                confirmAction:(void(^)(void))confirmAction
                 cancleAction:(void(^)(void))cancelAction {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    /// 配置alertController
    alertController.titleColor = [UIColor mt_colorWithHexString:@"#3C3E44"];
    alertController.messageColor = [UIColor mt_colorWithHexString:@"#9A9A9C"];
    
    /// 左边按钮
    if(cancelTitle.length > 0){
        UIAlertAction *cancel= [UIAlertAction actionWithTitle:cancelTitle?cancelTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { !cancelAction?:cancelAction(); }];
        cancel.textColor = [UIColor mt_colorWithHexString:@"#8E929D"];
        [alertController addAction:cancel];
    }
    
    
    if (confirmTitle.length > 0) {
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:confirmTitle?confirmTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { !confirmAction?:confirmAction();}];
        confirm.textColor = [UIColor colorWithRed:(10 / 255.0) green:(193 / 255.0) blue:(42 / 255.0) alpha:1];
        [alertController addAction:confirm];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIViewController mt_currentViewController] presentViewController:alertController animated:YES completion:NULL];
    });
}

@end
