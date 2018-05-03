//
//  Student.m
//  iOSWheels
//
//  Created by liyan on 2018/4/8.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "Student.h"

@implementation Student

+ (NSArray* _Nonnull)mt_uniqueKeys{
    return @[@"contentID"];
}

+ (NSArray* _Nonnull)mt_ignoreKeys {
    return @[@"dateIndex"];
}

@end
