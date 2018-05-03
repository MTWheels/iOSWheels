//
//  NSObject+MTExtension.m
//  iOSWheels
//
//  Created by liyan on 2018/4/20.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "NSObject+MTExtension.h"

@implementation NSObject (MTExtension)

//类名
- (NSString *)mt_className {
    return NSStringFromClass([self class]);
}
+ (NSString *)mt_className {
    return NSStringFromClass([self class]);
}


//父类名
- (NSString *)mt_superClassName {
    return NSStringFromClass([self superclass]);
}
+ (NSString *)mt_superClassName {
    return NSStringFromClass([self superclass]);
}

@end
