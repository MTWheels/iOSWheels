//
//  NSCache+MTCache.m
//  iOSWheels
//
//  Created by liyan on 2018/4/8.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "NSCache+MTCache.h"

static NSCache* keyCaches;
@implementation NSCache (MTCache)

+ (instancetype)mt_cache{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        keyCaches = [[NSCache alloc] init];
    });
    return keyCaches;
}

@end
