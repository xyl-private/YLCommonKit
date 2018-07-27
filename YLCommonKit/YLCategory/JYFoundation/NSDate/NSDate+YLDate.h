//
//  NSDate+YLDate.h
//  YLCommonKit
//
//  Created by xyanl on 2018/6/29.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YLDateComponentsType) {
    YLDateComponentsTypeYear,
    YLDateComponentsTypeMonth,
    YLDateComponentsTypeDay,
    YLDateComponentsTypeHour,
    YLDateComponentsTypeMinute,
    YLDateComponentsTypeSecond,
    YLDateComponentsTypeWeekday
};

@interface NSDate (YLDate)

+ (NSCalendar *)yl_calendar;
+ (NSCalendar *)yl_chineseCalendar;
+ (NSDateFormatter *)yl_dateFormatter:(NSString *)dateFormat;
/**
 将 NSDate 转成 NSDateComponents 类型
 
 @param date 给定的 date
 */
+ (NSDateComponents *)yl_dateComponentsWithDate:(NSDate *)date;
/**
 获取当前时间

 @param dateFormat dateFormat description
 */
+ (NSString *) yl_stringCurrentDateWithDateFormat:(NSString *)dateFormat;

/**
 NSDate 转 NSString

 @param date date description
 @param dateFormat dateFormat description
 @return return value description
 */
+ (NSString *) yl_stringFromDate:(NSDate*)date DateFormat:(NSString *)dateFormat;

/**
 NSString 转 NSDate
 */
+ (NSDate *) yl_dateFromDateString:(NSString *)dateString DateFormat:(NSString *)dateFormat;
/**
 获取农历时间

 @param date 阳历时间
 */
+ (NSDateComponents *) yl_lunarCalendarWithDate:(NSDate*)date;

/**
 时间比较：-1：dateB比dateA小
 0：相等；
 1：dateB比dateA大；
 */
+ (NSInteger)yl_compareDateA:(NSString *)dateA DateB:(NSString *)dateB DateFormatter:(NSString *)dateFormatter;


/**
 比较日期是否相等
 @return return YES 相等  NO 不等
 */
+ (BOOL)yl_isEqual:(NSDate *)dateA other:(NSDate *)dateB DateFormatter:(NSString *)dateFormat;

/**
 给定日期时间 判断是不是今天的当前时间
 @param date 给定日期
 */
+ (BOOL)yl_isCurrentDate:(NSDate *)date DateFormatter:(NSString *)dateFormat;

/**
 判断给定时间是不是今天
 */
+ (BOOL)yl_isToday:(NSDate *)date;

/**
 获取给定日期的月份
 
 @param date 给定日期
 */
+ (NSInteger)yl_monthFromDate:(NSDate *)date;

/**
 获取给定日期所在周 是在当月的第几周

 @param date 给定日期
 */
+ (NSInteger)yl_weekInMonthIndexWithDate:(NSDate *)date;

/**
 获取给定日期所在月中有多少周
 
 @param date 给定日期
 */
+ (NSInteger)yl_numberWeeksInMonthWithDate:(NSDate*)date;


/**
 a period of time from the current time
 以当前时间为起点,间隔几个时间单位的 date
 @param type 时间类型,间隔的是几年/月/日/时/分/秒/星期
 @param length 长度可以是正负数，
 正数是以当前时间为起点，向未来的时间间隔出几个时间单位。
 负数是以当前时间为起点，向过去时间间隔出几个时间单位。
 @return return value description
 */
+ (NSDate *)yl_datePeriodOfDateFromCurrentDateWithComponentsType:(YLDateComponentsType)type periodLength:(NSInteger)length;

/**
 a period of time from the current time
 以当前时间为起点,间隔几个时间单位的 date
 
 @param startDate  以 startDate 为起始时间
 @param type 时间类型,间隔的是几年/月/日/时/分/秒/星期
 @param length 长度可以是正负数，
 正数是以当前时间为起点，向未来的时间间隔出几个时间单位。
 负数是以当前时间为起点，向过去时间间隔出几个时间单位。
 @return return value description
 */
+ (NSDate *)yl_datePeriodOfDateFromStertDate:(NSDate *)startDate componentsType:(YLDateComponentsType)type periodLength:(NSInteger)length;
@end
