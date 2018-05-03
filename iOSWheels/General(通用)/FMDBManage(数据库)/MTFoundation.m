//
//  MTFoundation.m
//  iOSWheels
//
//  Created by liyan on 2018/4/8.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "MTFoundation.h"
#import <CoreData/CoreData.h>

static NSSet *mtFoundationClasses_;

@implementation MTFoundation

+ (NSSet *)foundationClasses
{
    if (mtFoundationClasses_ == nil) {
        // 集合中没有NSObject，因为几乎所有的类都是继承自NSObject，具体是不是NSObject需要特殊判断
        mtFoundationClasses_ = [NSSet setWithObjects:
                                [NSURL class],
                                [NSDate class],
                                [NSValue class],
                                [NSData class],
                                [NSError class],
                                [NSArray class],
                                [NSDictionary class],
                                [NSString class],
                                [NSAttributedString class], nil];
    }
    return mtFoundationClasses_;
}


+ (BOOL)isClassFromFoundation:(Class)c
{
    if (c == [NSObject class] || c == [NSManagedObject class]) return YES;
    __block BOOL result = NO;
    [[self foundationClasses] enumerateObjectsUsingBlock:^(Class foundationClass, BOOL *stop) {
        if ([c isSubclassOfClass:foundationClass]) {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}


@end
