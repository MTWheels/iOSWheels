//
//  UIColor+MTExtension.m
//  iOSWheels
//
//  Created by liyan on 2018/3/29.
//  Copyright © 2018年 liyan. All rights reserved.
//

#import "UIColor+MTExtension.h"

@implementation UIColor (MTExtension)



/**
 * 使用16进制数字创建颜色
 */
+ (UIColor *)mt_colorWithHex:(uint32_t)hex {
    uint8_t r = (hex & 0xff0000) >> 16;
    uint8_t g = (hex & 0x00ff00) >> 8;
    uint8_t b = hex & 0x0000ff;
    return [self colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}


/** 十六制颜色*/
+ (UIColor *)mt_colorWithHexString:(NSString *)hexColorString {
    return [self mt_colorWithHexString:hexColorString alpha:1.0];
}



//   十六进制颜色:含alpha
+ (UIColor *)mt_colorWithHexString:(NSString *)hexColorString
                             alpha:(CGFloat)alpha {
    //删除字符串中的空格
    NSString *cString = [[hexColorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}



/**
 随机颜色
 */
+ (UIColor *)mt_randomColor {
    return [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
}





+ (UIColor *)mt_gradientFromColor:(UIColor *)fromColor
                          toColor:(UIColor *)toColor
                        fromPoint:(CGPoint)fromPoint
                          toPoint:(CGPoint)toPoint {
    
    return nil;
}





@end
