//
//  NSDate+MTExtension.h
//  iOSWheels
//
//  Created by liyan on 2018/4/2.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MTExtension)


//内存优化 单例
+ (NSDateFormatter *)mt_formatter;



/**
 * 获取日、月、年、小时、分钟、秒
 */

- (NSUInteger)mt_day;
- (NSUInteger)mt_month;
- (NSUInteger)mt_year;
- (NSUInteger)mt_hour;
- (NSUInteger)mt_minute;
- (NSUInteger)mt_second;
+ (NSUInteger)mt_day:(NSDate *)date;
+ (NSUInteger)mt_month:(NSDate *)date;
+ (NSUInteger)mt_year:(NSDate *)date;
+ (NSUInteger)mt_hour:(NSDate *)date;
+ (NSUInteger)mt_minute:(NSDate *)date;
+ (NSUInteger)mt_second:(NSDate *)date;



/**
 * 获取当前月份的天数
 */
- (NSUInteger)mt_daysInMonth;


/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)mt_isLeapYear;
+ (BOOL)mt_isLeapYear:(NSDate *)date;



/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)mt_timeInfoWithDate:(NSDate *)date;




/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)mt_dayFromWeekday;
+ (NSString *)mt_dayFromWeekday:(NSDate *)date;





@end
