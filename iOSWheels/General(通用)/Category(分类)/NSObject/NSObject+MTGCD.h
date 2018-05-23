//
//  NSObject+MTGCD.h
//  iOSWheels
//
//  Created by liyan on 2018/5/23.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MTGCD)


/**
 *  @brief  异步执行代码块
 *
 *  @param block 代码块
 */
- (void)mt_performAsynchronous:(void(^)(void))block;



/**
 *  @brief  GCD主线程执行代码块
 *
 *  @param block 代码块
 */
- (void)mt_performOnMainThread:(void(^)(void))block;



/**
 *  @brief  延迟执行代码块
 *
 *  @param seconds 延迟时间 秒
 *  @param block   代码块
 */
- (void)mt_performAfter:(NSTimeInterval)seconds block:(void(^)(void))block;


@end
