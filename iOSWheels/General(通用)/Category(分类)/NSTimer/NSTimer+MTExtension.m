//
//  NSTimer+MTExtension.m
//  iOSWheels
//
//  Created by liyan on 2018/4/2.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "NSTimer+MTExtension.h"
#import <objc/runtime.h>

static const void *mt_hyb_private_currentCountTime = "mt_hyb_private_currentCountTime";


@implementation NSTimer (MTExtension)


- (NSNumber *)hyb_private_currentCountTime {
    NSNumber *obj = objc_getAssociatedObject(self, mt_hyb_private_currentCountTime);
    
    if (obj == nil) {
        obj = @(0);
        
        [self setHyb_private_currentCountTime:obj];
    }
    
    return obj;
}


- (void)setHyb_private_currentCountTime:(NSNumber *)time {
    objc_setAssociatedObject(self,
                             mt_hyb_private_currentCountTime,
                             time, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



+ (NSTimer *)mt_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         count:(NSInteger)count
                                      callback:(MTTimerCallBack)callback {
    if (count <= 0) {
        return [self mt_scheduledTimerWithTimeInterval:interval
                                               repeats:YES
                                              callback:callback];
    }
    
    NSDictionary *userInfo = @{@"callback"     : callback,
                               @"count"        : @(count)};
    return [NSTimer scheduledTimerWithTimeInterval:interval
                                            target:self
                                          selector:@selector(hyb_onTimerUpdateCountBlock:)
                                          userInfo:userInfo
                                           repeats:YES];
}





+ (NSTimer *)mt_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                       repeats:(BOOL)repeats
                                      callback:(MTTimerCallBack)callback {
    return [NSTimer scheduledTimerWithTimeInterval:interval
                                            target:self
                                          selector:@selector(hyb_onTimerUpdateBlock:)
                                          userInfo:callback
                                           repeats:repeats];
}






- (void)hyb_fireTimer {
    [self setFireDate:[NSDate distantPast]];
}

- (void)hyb_unfireTimer {
    [self setFireDate:[NSDate distantFuture]];
}

- (void)hyb_invalidate {
    if (self.isValid) {
        [self invalidate];
        
    }
}






#pragma mark - Private
+ (void)hyb_onTimerUpdateBlock:(NSTimer *)timer {
    MTTimerCallBack block = timer.userInfo;
    
    if (block) {
        block(timer);
    }
}

+ (void)hyb_onTimerUpdateCountBlock:(NSTimer *)timer {
    NSInteger currentCount = [[timer hyb_private_currentCountTime] integerValue];
    
    NSDictionary *userInfo = timer.userInfo;
    MTTimerCallBack callback = userInfo[@"callback"];
    NSNumber *count = userInfo[@"count"];
    
    if (currentCount < count.integerValue) {
        currentCount++;
        [timer setHyb_private_currentCountTime:@(currentCount)];
        
        if (callback) {
            callback(timer);
        }
    } else {
        currentCount = 0;
        [timer setHyb_private_currentCountTime:@(currentCount)];
        
        [timer hyb_unfireTimer];
        [timer hyb_invalidate];
    }
}

-(void)mt_pauseTimer
{
    if (![self isValid])
    {
        return ;
    }
    
    [self setFireDate:[NSDate distantFuture]];
}

-(void)mt_resumeTimer
{
    if (![self isValid])
    {
        return ;
    }
    
    [self setFireDate:[NSDate date]];
}

- (void)mt_resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid])
    {
        return ;
    }
    
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}



- (void)dealloc {
    NSLog(@"✅dealloc  %@  '%@'",self.class, NSStringFromSelector(_cmd));
}

@end
