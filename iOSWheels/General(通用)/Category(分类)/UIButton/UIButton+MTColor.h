//
//  UIButton+MTColor.h
//  iOSWheels
//
//  Created by liyan on 2018/3/29.
//  Copyright © 2018年 liyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MTColor)


/**
 *  @brief  根据颜色生成纯色图片
 *
 *  @param color 颜色
 *
 *  @return 纯色图片
 */
+ (UIImage *)mt_imageWithColor:(UIColor *)color;


@end
