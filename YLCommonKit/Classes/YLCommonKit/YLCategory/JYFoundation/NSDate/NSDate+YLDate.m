//
//  NSDate+YLDate.m
//  JYJobCalendar
//
//  Created by xyanl on 2018/6/29.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "NSDate+YLDate.h"

@implementation NSDate (YLDate)
/**
 获取当前时间
 
 @param dateFormat dateFormat description
 */
+ (NSString *) yl_stringCurrentDateWithDateFormat:(NSString *)dateFormat{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = dateFormat;
    [dateFormatter setCalendar:[NSDate yl_calendar]];
    return [dateFormatter stringFromDate:[NSDate date]];
}



+ (NSString *) yl_stringFromDate:(NSDate*)date DateFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.timeZone = [NSDate yl_calendar].timeZone;
    [dateFormatter setDateFormat:dateFormat];
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *) yl_dateFromDateString:(NSString *)dateString DateFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.timeZone = [NSDate yl_calendar].timeZone;
    [dateFormatter setDateFormat:dateFormat];
    return [dateFormatter dateFromString:dateString];
}

+ (NSDateComponents *) yl_lunarCalendarWithDate:(NSDate*)date{
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    return localeComp;
}



/**
 * 时间比较：-1：dateB比dateA小
            0：相等；
            1：dateB比dateA大；
 */
+ (NSInteger)yl_compareDateA:(NSString *)dateA DateB:(NSString *)dateB DateFormatter:(NSString *)dateFormat
{
    NSInteger aa = 0;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:dateFormat];
    
    NSDate *dta = [dateformater dateFromString:dateA];
    NSDate *dtb = [dateformater dateFromString:dateB];
    NSComparisonResult result = [dta compare:dtb];
    if (result == NSOrderedSame) {
        aa = 0;
    } else if (result == NSOrderedAscending) {
        aa = 1;
    } else if (result == NSOrderedDescending) {
        aa = -1;
    }
    return aa;
}

///比较日期是否相等
+ (BOOL)yl_isEqual:(NSDate *)dateA other:(NSDate *)dateB DateFormatter:(NSString *)dateFormat{
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.timeZone = [NSDate yl_calendar].timeZone;
    dateFormatter.dateFormat = dateFormat;
    
    return [[dateFormatter stringFromDate:dateA] isEqualToString:[dateFormatter stringFromDate:dateB]];
}

/**
 给定日期时间 判断是不是今天的当前时间

 @param date 给定日期
 */
+ (BOOL)yl_isCurrentDate:(NSDate *)date DateFormatter:(NSString *)dateFormat{
    return [NSDate yl_isEqual:[NSDate date] other:date DateFormatter:dateFormat];
}

/**
 判断给定时间是不是今天
 */
+ (BOOL)yl_isToday:(NSDate *)date{
    return [NSDate yl_isCurrentDate:date DateFormatter:@"yyyy-MM-dd"];
}

/**
 获取给定日期的月份

 @param date 给定日期
 */
+ (NSInteger)yl_monthFromDate:(NSDate *)date
{
    NSDateComponents *comps = [[NSDate yl_calendar] components:NSCalendarUnitMonth fromDate:date];
    return comps.month;
}

//获取给定日期所在周 是在当月的第几周
+ (NSInteger)yl_weekInMonthIndexWithDate:(NSDate *)date{
    NSDateComponents * components =[[NSDate yl_calendar] components:NSCalendarUnitWeekOfMonth fromDate:date];
    return components.weekOfMonth;
}

+ (NSInteger)yl_numberWeeksInMonthWithDate:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//指定日历的算法
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}
#pragma mark - 通用

+ (NSCalendar *)yl_calendar
{
    static NSCalendar *calendar;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        calendar.timeZone = [NSTimeZone localTimeZone];
    });
    return calendar;
}

+ (NSCalendar *)yl_chineseCalendar{
    static NSCalendar *calendar;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
        calendar.timeZone = [NSTimeZone localTimeZone];
    });
    return calendar;
}
@end
