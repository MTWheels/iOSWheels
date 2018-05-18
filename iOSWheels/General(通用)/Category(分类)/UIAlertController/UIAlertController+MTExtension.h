//
//  UIAlertController+MTExtension.h
//  iOSWheels
//
//  Created by liyan on 2018/5/18.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (MTExtension)

/// 统一按钮样式 不写系统默认的蓝色
@property (nonatomic , readwrite, strong) UIColor *tintColor;
/// 标题的颜色
@property (nonatomic , readwrite, strong) UIColor *titleColor;
/// 信息的颜色
@property (nonatomic , readwrite, strong) UIColor *messageColor;

@end



@interface UIAlertAction (MTColor)

/**< 按钮title字体颜色 */
@property (nonatomic , readwrite, strong) UIColor *textColor;

@end
