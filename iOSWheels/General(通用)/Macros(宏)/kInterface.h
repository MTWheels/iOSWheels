//
//  kInterface.h
//  iOSWheels
//
//  Created by liyan on 2018/4/8.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#ifndef kInterface_h
#define kInterface_h




/// 手机类型相关




/// 应用名称
#define APP_NAME    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])
/// 应用版本号
#define APP_VERSION ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
/// 应用build
#define APP_BUILD   ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])


#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]



/// 屏幕尺寸相关
#define kScreenWith  ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight ([[UIScreen mainScreen] bounds].size.height)
#define kScreenBounds ([[UIScreen mainScreen] bounds])



/// 手机类型相关
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4_OR_LESS  (IS_IPHONE && kScreenHeight  < 568.0)
#define IS_IPHONE_5          (IS_IPHONE && kScreenHeight == 568.0)
#define IS_IPHONE_6          (IS_IPHONE && kScreenHeight == 667.0)
#define IS_IPHONE_6P         (IS_IPHONE && kScreenHeight == 736.0)
#define IS_IPHONE_X          (IS_IPHONE && kScreenHeight == 812.0)


#define iOS7_VERSTION_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
#define iOS8_VERSTION_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
#define iOS9_VERSTION_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 9.0)
#define iOS10_VERSTION_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)



//判断字符串是否为空
#define IFISNIL(v)                                 (v = (v != nil) ? v : @"")

/// 导航条高度
#define kTopHeight (IS_IPHONE_X ? 88 : 64)
#define kStatusHeight (IS_IPHONE_X ? 44 : 20)
#define kNavigationBarHeight 44

#define kBottomHeight (IS_IPHONE_X ? 83 : 49)
#define kTabbarHeight 49
#define kBottomSpaceHeight (IS_IPHONE_X ? 34 : 0)




// 输出日志 (格式: [时间] [哪个方法] [哪行] [输出内容])
#ifdef DEBUG
#define NSLog(format, ...)  printf("\n[%s] %s [第%d行] 💕 %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);
#else

#define NSLog(format, ...)

#endif



///其他常量配置
#import "kConstEnum.h"


#endif /* kInterface_h */
