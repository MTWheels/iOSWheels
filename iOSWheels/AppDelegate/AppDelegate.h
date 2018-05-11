//
//  AppDelegate.h
//  iOSWheels
//
//  Created by 方新俊 on 2018/3/29.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/// 获取AppDelegate
+ (AppDelegate *)sharedDelegate;

@end

