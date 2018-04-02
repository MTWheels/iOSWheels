//
//  NSTimer+MTExtension.h
//  iOSWheels
//
//  Created by liyan on 2018/4/2.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
    注意：
        一、每个NSTimer其实是被添加在所在线程的runloop中，而runloop对timer是一种强持有关系
 */


typedef void (^MTTimerCallBack)(NSTimer *timer);


@interface NSTimer (MTExtension)



/**
 Creates and returns a new NSTimer object initialized with the specified block object and schedules it on the current run loop in the default mode.
 
 @param interval 时间
 @param repeats 是否重复执行
 @param callback 执行回调
 @return 返回对象
 */
+ (NSTimer *)mt_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                       repeats:(BOOL)repeats
                                      callback:(MTTimerCallBack)callback;






/**
 Creates and returns a new NSTimer object initialized with the specified block object and schedules it on the current run loop in the default mode.

 @param interval 时间
 @param count 重复执行次数  小于等于0时 默认一直循环
 @param callback 执行回调
 @return 返回对象
 */
+ (NSTimer *)mt_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         count:(NSInteger)count
                                      callback:(MTTimerCallBack)callback;

/** 暂停NSTimer */
- (void)mt_pauseTimer;

/** 开始NSTimer */
- (void)mt_resumeTimer;

/** 延迟开始NSTimer */
- (void)mt_resumeTimerAfterTimeInterval:(NSTimeInterval)interval;


@end
