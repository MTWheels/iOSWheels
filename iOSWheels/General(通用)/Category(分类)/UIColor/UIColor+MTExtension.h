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


@end
