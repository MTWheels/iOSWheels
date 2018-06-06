//
//  NSString+MTValidate.m
//  iOSWheels
//
//  Created by liyan on 2018/4/3.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "NSString+MTValidate.h"

@implementation NSString (MTValidate)

#pragma mark -  手机号码验证
+ (BOOL)mt_isValidateMobile:(NSString *)mobile {
    
    NSPredicate* phonePre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"1[345678]([0-9]){9}"];
    return [phonePre evaluateWithObject:mobile];
}

#pragma mark - 邮箱验证
+ (BOOL)mt_isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
    
}


#pragma mark -   验证身份证
+ (BOOL)mt_isValidateIdentityCardNum:(NSString *)card {
    
    NSString *cardRegex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *cardTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cardRegex];
    return [cardTest evaluateWithObject:card];
}


#pragma mark - 网址有效性
+ (BOOL)mt_isValidateUrl:(NSString *)url {
    NSString *regex = @"^((http)|(https))+:[^\\s]+\\.[^\\s]*$";
    return [self isValidateByRegex:regex];
}




#pragma mark - 验证纯汉字
+ (BOOL)mt_isValidateHanzi {
    NSString *chineseRegex = @"^[\u4e00-\u9fa5]+$";
    return [self isValidateByRegex:chineseRegex];
}






#pragma mark - 正则相关
+ (BOOL)isValidateByRegex:(NSString *)regex
{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

@end
