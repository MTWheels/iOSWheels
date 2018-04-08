//
//  NSArray+MTSafeAccess.m
//  iOSWheels
//
//  Created by liyan on 2018/4/4.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "NSArray+MTSafeAccess.h"

@implementation NSArray (MTSafeAccess)

/**
 @内部做个安全判定 防止数组越界
 */
- (instancetype)mt_objectAtIndex:(NSUInteger)idx {
    if (idx < self.count) {
        return [self objectAtIndex:idx];
    } else
        return nil;
}

@end
