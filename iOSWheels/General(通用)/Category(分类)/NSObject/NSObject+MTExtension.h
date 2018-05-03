//
//  NSObject+MTExtension.h
//  iOSWheels
//
//  Created by liyan on 2018/4/20.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MTExtension)

//类名
- (NSString *)mt_className;
+ (NSString *)mt_className;


//父类名
- (NSString *)mt_superClassName;
+ (NSString *)mt_superClassName;


@end
