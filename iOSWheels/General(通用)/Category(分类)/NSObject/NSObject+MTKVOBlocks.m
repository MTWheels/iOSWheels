//
//  NSObject+MTKVOBlocks.m
//  iOSWheels
//
//  Created by liyan on 2018/5/23.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "NSObject+MTKVOBlocks.h"
#import <objc/runtime.h>


@implementation NSObject (MTKVOBlocks)


-(void)mt_addObserver:(NSObject *)observer
           forKeyPath:(NSString *)keyPath
              options:(NSKeyValueObservingOptions)options
              context:(void *)context
            withBlock:(MTKVOBlock)block {
    
    objc_setAssociatedObject(observer, (__bridge const void *)(keyPath), block, OBJC_ASSOCIATION_COPY);
    [self addObserver:observer forKeyPath:keyPath options:options context:context];
}


-(void)mt_removeBlockObserver:(NSObject *)observer
                   forKeyPath:(NSString *)keyPath {
    objc_setAssociatedObject(observer, (__bridge const void *)(keyPath), nil, OBJC_ASSOCIATION_COPY);
    [self removeObserver:observer forKeyPath:keyPath];
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context {
    
    MTKVOBlock block = objc_getAssociatedObject(self, (__bridge const void *)(keyPath));
    if (block) {
        block(change, context);
    }
}

-(void)mt_addObserverForKeyPath:(NSString *)keyPath
                        options:(NSKeyValueObservingOptions)options
                        context:(void *)context
                      withBlock:(MTKVOBlock)block {
    
    [self mt_addObserver:self forKeyPath:keyPath options:options context:context withBlock:block];
}

-(void)mt_removeBlockObserverForKeyPath:(NSString *)keyPath {
    [self mt_removeBlockObserver:self forKeyPath:keyPath];
}

@end
