//
//  NSString+MTSize.h
//  iOSWheels
//
//  Created by liyan on 2018/4/3.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (MTSize)

/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)mt_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;




/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat)mt_widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;



@end
