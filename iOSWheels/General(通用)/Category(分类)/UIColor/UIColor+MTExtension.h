//
//  UIColor+MTExtension.h
//  iOSWheels
//
//  Created by liyan on 2018/3/29.
//  Copyright © 2018年 liyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MTExtension)



/**
 * 使用16进制数字创建颜色
 */
+ (UIColor *)mt_colorWithHex:(uint32_t)hex;


/**
 十六制颜色
 */
+ (UIColor *)mt_colorWithHexString:(NSString *)hexColorString;


/**
   十六进制颜色:含alpha

 @param hexColorString 16进制字符串
 @param alpha alpha
 @return UIColor
 */
+ (UIColor *)mt_colorWithHexString:(NSString *)hexColorString
                             alpha:(CGFloat)alpha;



/**
    随机颜色
 */
+ (UIColor *)mt_randomColor;



+ (UIColor *)mt_gradientFromColor:(UIColor *)fromColor
                          toColor:(UIColor *)toColor
                        fromPoint:(CGPoint)fromPoint
                          toPoint:(CGPoint)toPoint;


@end
