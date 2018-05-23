//
//  NSObject+MTGCD.m
//  iOSWheels
//
//  Created by liyan on 2018/5/23.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "NSObject+MTGCD.h"

@implementation NSObject (MTGCD)

/**
 *  @brief  异步执行代码块
 *
 *  @param block 代码块
 */
- (void)mt_performAsynchronous:(void(^)(void))block {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, block);
}


/**
 *  @brief  GCD主线程执行代码块
 *
 *  @param block 代码块
 */
- (void)mt_performOnMainThread:(void(^)(void))block {
    // Asynchronous
    dispatch_async(dispatch_get_main_queue(), block);
}



/**
 *  @brief  延迟执行代码块
 *
 *  @param seconds 延迟时间 秒
 *  @param block   代码块
 */
- (void)mt_performAfter:(NSTimeInterval)seconds block:(void(^)(void))block {
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), block);
    
}



@end
