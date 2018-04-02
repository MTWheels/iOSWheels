//
//  UIDevice+MTExtension.m
//  iOSWheels
//
//  Created by liyan on 2018/4/2.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "UIDevice+MTExtension.h"

@implementation UIDevice (MTExtension)


/** 系统版本号 */
+ (NSString *)mt_systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}


@end
