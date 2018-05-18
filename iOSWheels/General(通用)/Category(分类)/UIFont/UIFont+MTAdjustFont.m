//
//  UIFont+MTAdjustFont.m
//  iOSWheels
//
//  Created by liyan on 2018/5/17.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "UIFont+MTAdjustFont.h"
#import <objc/runtime.h>

@implementation UIFont (MTAdjustFont)


+ (void)load {
    //获取替换后的类方法
    Method newMethod = class_getClassMethod([self class], @selector(adjustFont:));
    //获取需要替换的类方法
    Method method = class_getClassMethod([self class], @selector(systemFontOfSize:));
    //交换方法
    method_exchangeImplementations(newMethod, method);
}


+ (UIFont *)adjustFont:(CGFloat)fontSize{
    return [UIFont adjustFont:fontSize * kWIDTHBASE];
}


@end
