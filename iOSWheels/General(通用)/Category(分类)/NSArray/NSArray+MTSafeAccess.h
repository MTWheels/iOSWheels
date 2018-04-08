//
//  NSArray+MTSafeAccess.h
//  iOSWheels
//
//  Created by liyan on 2018/4/4.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (MTSafeAccess)


/**
 @param idx 数组坐标索引
 @内部做个安全判定 防止数组越界  
 */
- (instancetype)mt_objectAtIndex:(NSUInteger)idx;


@end
