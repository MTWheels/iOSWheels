//
//  NSObject+MTKVOBlocks.h
//  iOSWheels
//
//  Created by liyan on 2018/5/23.
//  Copyright © 2018年 方新俊. All rights reserved.
//



/*
 UIViewController *observer = self;
 if (self.observersOn) {
 // This is where the magic happens
 [self.user mt_addObserver:observer forKeyPath:@"email" options:0 context:nil withBlock:^(NSDictionary *change, void *context) {
 NSLog(@"Changed email");
 }];
 
 [self.user mt_addObserver:observer forKeyPath:@"username" options:0 context:nil withBlock:^(NSDictionary *change, void *context) {
 NSLog(@"Changed username");
 }];
 } else {
 [self.user mt_removeBlockObserver:observer forKeyPath:@"username"];
 [self.user mt_removeBlockObserver:observer forKeyPath:@"email"];
 }
 */



#import <Foundation/Foundation.h>

typedef void (^MTKVOBlock)(NSDictionary *change, void *context);

@interface NSObject (MTKVOBlocks)


/**
 添加观察者与监听属性
 
 @param observer 观察者,一般为其他对象(谁想监听)
 @param keyPath 监听的属性
 @param options 监听模式
 @param context context
 @param block  监听回调
 */
- (void)mt_addObserver:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
               context:(void *)context
             withBlock:(MTKVOBlock)block;


/**
 移除观察者对属性的监听
 
 @param observer 观察者,一般为其他对象(谁想监听)
 @param keyPath 监听的属性
 */
-(void)mt_removeBlockObserver:(NSObject *)observer
                   forKeyPath:(NSString *)keyPath;



/**
 对象本身作为观察者
 
 @param keyPath 监听的属性
 @param options 监听模式
 @param context context
 @param block 监听回调
 */
-(void)mt_addObserverForKeyPath:(NSString *)keyPath
                        options:(NSKeyValueObservingOptions)options
                        context:(void *)context
                      withBlock:(MTKVOBlock)block;




/**
 移除观察者对属性的监听
 
 @param keyPath 监听的属性
 */
-(void)mt_removeBlockObserverForKeyPath:(NSString *)keyPath;



@end
