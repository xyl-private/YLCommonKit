//
//  NSDate+YLDate.m
//  YLCommonKit
//
//  Created by xyanl on 2018/6/29.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "NSDate+YLDate.h"

@implementation NSDate (YLDate)

#pragma mark - Component Properties

- (NSInteger)year {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)month {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)day {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)hour {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)minute {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)second {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)nanosecond {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] nanosecond];
}

- (NSInteger)weekday {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (NSInteger)weekdayOrdinal {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self] weekdayOrdinal];
}

- (NSInteger)weekOfMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

- (NSInteger)weekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

- (NSInteger)yearForWeekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYearForWeekOfYear fromDate:self] yearForWeekOfYear];
}

- (NSInteger)quarter {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] quarter];
}

- (BOOL)isLeapMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] isLeapMonth];
}

- (BOOL)isLeapYear {
    NSUInteger year = self.year;
    return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)));
}

- (BOOL)isToday {
    if (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24) return NO;
    return [NSDate new].day == self.day;
}

- (BOOL)isYesterday {
    NSDate *added = [self dateByAddingDays:1];
    return [added isToday];
}

- (NSDate *)dateByAddingDays:(NSInteger)days {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 86400 * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSCalendar *)yl_calendar {
    static NSCalendar *calendar;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        calendar.timeZone = [NSTimeZone localTimeZone];
    });
    return calendar;
}

+ (NSDateFormatter *)yl_dateFormatter:(NSString *)dateFormat {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = dateFormat;
    [dateFormatter setCalendar:[NSDate yl_calendar]];
    dateFormatter.timeZone = [NSDate yl_calendar].timeZone;
    return dateFormatter;
}

/// 获取当前时区与0时区的间隔秒数
+ (NSInteger)yl_secondsFromGMT{
    return [[NSTimeZone localTimeZone] secondsFromGMT];
}

/// 当前时间戳
+ (NSInteger)yl_timestampWithType:(YLTimestampType)type{
    return [NSDate yl_timestampFromDate:[NSDate date] type:type];
}

/// NSDate 转 时间戳
+ (NSInteger)yl_timestampFromDate:(NSDate *)date type:(YLTimestampType)type{
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    if (type == YLTimestampTypeMillisecond) {
        timeInterval = timeInterval*1000;
    }else if (type == YLTimestampTypeMillisecond) {
        timeInterval = timeInterval*1000*1000;
    }
    return (NSInteger)timeInterval;
}

/// 时间戳 转 NSDate
+ (NSDate *)yl_dateFromTimestamp:(NSInteger)timestamp{
    return [NSDate dateWithTimeIntervalSince1970:timestamp];
}

/// 时间戳 转 NSString
+ (NSString *)yl_stringFromTimestamp:(NSInteger)timestamp dateFormatter:(NSString *)dateFormatter {
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter * df = [self yl_dateFormatter:dateFormatter];
    return [df stringFromDate:date];
}

/// NSDate 转 NSString
+ (NSString *)yl_stringFromDate:(NSDate *)date dateFormatter:(NSString *)dateFormatter {
    return [[self yl_dateFormatter:dateFormatter] stringFromDate:date];
}

/// NSString 转 NSDate
+ (NSDate *)yl_dateFromDateString:(NSString *)dateString dateFormatter:(NSString *)dateFormatter {
    NSDateFormatter *df = [self yl_dateFormatter:dateFormatter];
    return [df dateFromString:dateString];
}

/// NSDate 转成 NSDateComponents
+ (NSDateComponents *)yl_dateComponentsFromDate:(NSDate *)date {
    NSCalendar *calendar = [NSDate yl_calendar];
    NSCalendarUnit unit = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitNanosecond | NSCalendarUnitCalendar | NSCalendarUnitTimeZone | NSCalendarUnitYearForWeekOfYear |NSCalendarUnitQuarter;
    NSDateComponents * components = [calendar components:unit fromDate:date];
    return components;
}

/// 时间格式转换
+ (NSString *)yl_stringTransDateFormatWithDateString:(NSString*)dateString oldDateFormat:(NSString *)oldDateFormat newDateFormat:(NSString *)newDateFormat{
    NSDate * date = [NSDate yl_dateFromDateString:dateString dateFormatter:oldDateFormat];
    return [NSDate yl_stringFromDate:date dateFormatter:newDateFormat];
}

/// 获取农历日期
+ (NSDateComponents *)yl_chineseCalendarWithDate:(NSDate*)date {
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSCalendarUnit unit = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitNanosecond | NSCalendarUnitCalendar | NSCalendarUnitTimeZone | NSCalendarUnitYearForWeekOfYear |NSCalendarUnitQuarter;
    NSDateComponents *localeComp = [localeCalendar components:unit fromDate:date];
    return localeComp;
}

/// 比较两个日期
/// dateStringA : 8:00  dateStringB : 9:00  return NSOrderedAscending  升序
/// dateStringA : 9:00  dateStringB : 8:00  return NSOrderedDescending 降序
/// dateStringA : 8:00  dateStringB : 8:00  return NSOrderedSame 相同
+ (NSComparisonResult)yl_compareDateWithDateStringA:(NSString *)dateStringA dateStringB:(NSString *)dateStringB dateFormatter:(NSString *)dateFormatter {
    NSDateFormatter *df = [self yl_dateFormatter:dateFormatter];
    NSDate *dateA = [df dateFromString:dateStringA];
    NSDate *dateB = [df dateFromString:dateStringB];
    NSComparisonResult result = [dateA compare:dateB];
    return result;
}

/// 比较两个日期
/// dateA : 8:00  dateB : 9:00  return NSOrderedAscending  升序
/// dateA : 9:00  dateB : 8:00  return NSOrderedDescending 降序
/// dateA : 8:00  dateB : 8:00  return NSOrderedSame 相同
+ (NSComparisonResult)yl_compareDateWithDateA:(NSDate *)dateA dateStringB:(NSDate *)dateB{
    return [dateA compare:dateB];
}

/// 比较两个日期,
/// @param unit 时间单位, 例:NSCalendarUnitDay|NSCalendarUnitHour,相差 1 天 5 小时
+ (NSDateComponents *)yl_components:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    //比较的结果是NSDateComponents类对象
    NSDateComponents *delta = [[NSCalendar currentCalendar] components:unit fromDate:fromDate toDate:toDate options:NSCalendarMatchStrictly];
    return delta;
}

/// a period of time from the current time
/// 以当前时间为起点,间隔几个时间单位的 date
/// @param date 起始时间
/// @param type 时间类型,间隔的是几年/月/日/时/分/秒/星期
/// @param length 间单位长度可以是正负数，
/// 正数是以当前时间为起点，向未来的时间间隔出几个时间单位。
/// 负数是以当前时间为起点，向过去时间间隔出几个时间单位。
+ (NSDate *)yl_datePeriodOfDateFromDate:(NSDate *)date componentsType:(YLDateComponentsType)type periodLength:(NSInteger)length{
    NSDateComponents * components = [[NSDateComponents alloc] init];
    switch (type) {
        case YLDateComponentsTypeYear:
            components.year = length;
            break;
        case YLDateComponentsTypeMonth:
            components.month = length;
            break;
        case YLDateComponentsTypeDay:
            components.day = length;
            break;
        case YLDateComponentsTypeHour:
            components.hour = length;
            break;
        case YLDateComponentsTypeMinute:
            components.minute = length;
            break;
        case YLDateComponentsTypeSecond:
            components.second = length;
            break;
        case YLDateComponentsTypeWeekday:
            components.weekday = length;
            break;
        default:
            break;
    }
    return [[self yl_calendar] dateByAddingComponents:components toDate:date options:NSCalendarMatchStrictly];
}

/// 判断给定日期 是周几   1-周日，2-周一 ... 7-周六
+ (NSInteger)yl_weekDayFromDate:(NSDate *)date{
    NSDateComponents *comps = [[self yl_calendar] components:NSCalendarUnitWeekday fromDate:date];
    // 1 是周日，2是周一 3.以此类推
    return [comps weekday];
}

///  某月中周的数量
+ (NSInteger)yl_weeksInMonthWithDate:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}
/// 某年中周的数量
+ (NSInteger)yl_weeksInYearWithDate:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitWeekOfYear inUnit:NSCalendarUnitYear forDate:date];
    return range.length;
}


/// 日期显示样式
/// @param timeStamp 时间戳 10 位 秒
+ (NSString *)yl_getDateDisplayString:(NSInteger)timeStamp {
    // 输入日期
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSDate *nowDate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *nowCmps = [calendar components:unit fromDate:nowDate];
    NSDateComponents *myCmps = [calendar components:unit fromDate:myDate];
    
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    
    if (nowCmps.year != myCmps.year) {
        // 不是同一年
        dateFmt.dateFormat = @"yyyy-MM-dd";
    }else {
        if (nowCmps.month != myCmps.month) {
            // 不是同一月
            dateFmt.dateFormat = @"MM-dd";
        }else{
            if (nowCmps.day == myCmps.day) {
                // 当天
                if (nowCmps.hour != myCmps.hour) {
                    dateFmt.dateFormat = @"HH:mm";
                }else{
                    // 一小时内
                    if (nowCmps.minute != myCmps.minute) {
                        return [NSString stringWithFormat:@"%ld分钟前",nowCmps.minute - myCmps.minute];
                    }else{
                        return [NSString stringWithFormat:@"%ld秒",nowCmps.second - myCmps.second];
                    }
                }
            } else if((nowCmps.day-myCmps.day)==1) {
                dateFmt.dateFormat = @"昨天";
            } else {
                if ((nowCmps.day-myCmps.day) <=9) {
                    return [NSString stringWithFormat:@"%ld天前",(nowCmps.day-myCmps.day)];
                }else {
                    dateFmt.dateFormat = @"MM-dd";
                }
            }
        }
    }
    return [dateFmt stringFromDate:myDate];
}

#pragma mark - BOOL
///  是不是工作日
/// @return YES 工作日 ; NO 周末
+ (BOOL)yl_isWorkingDayWith:(NSDate *)date {
    NSInteger index = [self yl_weekDayFromDate:date];
    if (index == 1 || index == 7) {
        return NO;
    }
    return YES;
}

@end
