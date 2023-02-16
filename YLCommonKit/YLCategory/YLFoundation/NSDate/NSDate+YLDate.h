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

typedef NS_ENUM(NSUInteger, YLTimestampType) {
    /// 秒    10 位
    YLTimestampTypeSecond,
    /// 毫秒 13 位
    YLTimestampTypeMillisecond,
    /// 微秒 16 位
    YLTimestampTypeMicrosecond
};

@interface NSDate (YLDate)

#pragma mark - Component Properties
///=============================================================================
/// @name Component Properties
///=============================================================================

@property (nonatomic, readonly) NSInteger year; ///< Year component
@property (nonatomic, readonly) NSInteger month; ///< Month component (1~12)
@property (nonatomic, readonly) NSInteger day; ///< Day component (1~31)
@property (nonatomic, readonly) NSInteger hour; ///< Hour component (0~23)
@property (nonatomic, readonly) NSInteger minute; ///< Minute component (0~59)
@property (nonatomic, readonly) NSInteger second; ///< Second component (0~59)
@property (nonatomic, readonly) NSInteger nanosecond; ///< Nanosecond component
@property (nonatomic, readonly) NSInteger weekday; ///< Weekday component (1~7, first day is based on user setting)
@property (nonatomic, readonly) NSInteger weekdayOrdinal; ///< WeekdayOrdinal component
@property (nonatomic, readonly) NSInteger weekOfMonth; ///< WeekOfMonth component (1~5)
@property (nonatomic, readonly) NSInteger weekOfYear; ///< WeekOfYear component (1~53)
@property (nonatomic, readonly) NSInteger yearForWeekOfYear; ///< YearForWeekOfYear component
@property (nonatomic, readonly) NSInteger quarter; ///< Quarter component
@property (nonatomic, readonly) BOOL isLeapMonth; ///< Weather the month is leap month
@property (nonatomic, readonly) BOOL isLeapYear; ///< Weather the year is leap year
@property (nonatomic, readonly) BOOL isToday; ///< Weather date is today (based on current locale)
@property (nonatomic, readonly) BOOL isYesterday; ///< Weather date is yesterday (based on current locale)

+ (NSCalendar *)yl_calendar;

+ (NSDateFormatter *)yl_dateFormatter:(NSString *)dateFormat;

/// 获取当前时区与0时区的间隔秒数
+ (NSInteger)yl_secondsFromGMT;
/// 当前时间戳
+ (NSInteger)yl_timestampWithType:(YLTimestampType)type;

/// NSDate 转 时间戳
+ (NSInteger)yl_timestampFromDate:(NSDate *)date type:(YLTimestampType)type;

/// 时间戳 转 NSDate
+ (NSDate *)yl_dateFromTimestamp:(NSInteger)timestamp;

/// 时间戳 转 NSString
+ (NSString *)yl_stringFromTimestamp:(NSInteger)timestamp dateFormatter:(NSString *)dateFormatter;

/// NSDate 转 NSString
+ (NSString *)yl_stringFromDate:(NSDate *)date dateFormatter:(NSString *)dateFormatter;

/// NSString 转 NSDate
+ (NSDate *)yl_dateFromDateString:(NSString *)dateString dateFormatter:(NSString *)dateFormatter;

/// NSDate 转成 NSDateComponents
+ (NSDateComponents *)yl_dateComponentsFromDate:(NSDate *)date;

/// 时间格式转换
+ (NSString *)yl_stringTransDateFormatWithDateString:(NSString*)dateString oldDateFormat:(NSString *)oldDateFormat newDateFormat:(NSString *)newDateFormat;

/// 获取农历日期
+ (NSDateComponents *)yl_chineseCalendarWithDate:(NSDate*)date;

/// 比较两个日期
/// dateStringA : 8:00  dateStringB : 9:00  return NSOrderedAscending  升序 顺时针
/// dateStringA : 9:00  dateStringB : 8:00  return NSOrderedDescending 降序 逆时针
/// dateStringA : 8:00  dateStringB : 8:00  return NSOrderedSame 相同
+ (NSComparisonResult)yl_compareDateWithDateStringA:(NSString *)dateStringA dateStringB:(NSString *)dateStringB dateFormatter:(NSString *)dateFormatter;

/// 比较两个日期
/// dateA : 8:00  dateB : 9:00  return NSOrderedAscending  升序  顺时针
/// dateA : 9:00  dateB : 8:00  return NSOrderedDescending 降序  逆时针
/// dateA : 8:00  dateB : 8:00  return NSOrderedSame 相同
+ (NSComparisonResult)yl_compareDateWithDateA:(NSDate *)dateA dateStringB:(NSDate *)dateB;

/// 比较两个日期,
/// @param unit 时间单位, 例:NSCalendarUnitDay|NSCalendarUnitHour,相差 1 天 5 小时
+ (NSDateComponents *)yl_components:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/// a period of time from the current time
/// 以当前时间为起点,间隔几个时间单位的 date
/// @param date 起始时间
/// @param type 时间类型,间隔的是几年/月/日/时/分/秒/星期
/// @param length 间单位长度可以是正负数，
/// 正数是以当前时间为起点，向未来的时间间隔出几个时间单位。
/// 负数是以当前时间为起点，向过去时间间隔出几个时间单位。
+ (NSDate *)yl_datePeriodOfDateFromDate:(NSDate *)date componentsType:(YLDateComponentsType)type periodLength:(NSInteger)length;

/// 判断给定日期 是周几   1-周日，2-周一 ... 7-周六
+ (NSInteger)yl_weekDayFromDate:(NSDate *)date;

///  某月中周的数量
+ (NSInteger)yl_weeksInMonthWithDate:(NSDate *)date;
/// 某年中周的数量
+ (NSInteger)yl_weeksInYearWithDate:(NSDate *)date;

/// 日期显示样式
/// @param timeStamp 时间戳 10 位 秒
+ (NSString *)yl_getDateDisplayString:(NSInteger)timeStamp;

#pragma mark - BOOL
///  是不是工作日
/// @return YES 工作日 ; NO 周末
+ (BOOL)yl_isWorkingDayWith:(NSDate *)date;


@end
