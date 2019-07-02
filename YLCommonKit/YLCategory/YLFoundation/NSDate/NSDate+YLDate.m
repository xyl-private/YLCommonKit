//
//  NSDate+YLDate.m
//  YLCommonKit
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
    NSDateFormatter *dateFormatter = [self yl_dateFormatter:dateFormat];
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSString *) yl_stringFromDate:(NSDate*)date DateFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [self yl_dateFormatter:dateFormat];
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *) yl_dateFromDateString:(NSString *)dateString DateFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [self yl_dateFormatter:dateFormat];
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
+ (NSInteger) yl_compareDateA:(NSString *)dateA DateB:(NSString *)dateB DateFormatter:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [self yl_dateFormatter:dateFormat];
    
    NSDate *dta = [dateFormatter dateFromString:dateA];
    NSDate *dtb = [dateFormatter dateFromString:dateB];
    NSComparisonResult result = [dta compare:dtb];
    NSInteger aa = 0;
    if (result == NSOrderedSame) {//相等
        aa = 0;
    } else if (result == NSOrderedAscending) {//上升
        aa = 1;
    } else if (result == NSOrderedDescending) {//下降
        aa = -1;
    }
    return aa;
}

///比较日期是否相等
+ (BOOL) yl_isEqual:(NSDate *)dateA other:(NSDate *)dateB DateFormatter:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [self yl_dateFormatter:dateFormat];
    return [[dateFormatter stringFromDate:dateA] isEqualToString:[dateFormatter stringFromDate:dateB]];
}

/**
 给定日期时间 判断是不是今天的当前时间

 @param date 给定日期
 */
+ (BOOL) yl_isCurrentDate:(NSDate *)date DateFormatter:(NSString *)dateFormat{
    return [NSDate yl_isEqual:[NSDate date] other:date DateFormatter:dateFormat];
}

/**
 判断给定时间是不是今天
 */
+ (BOOL) yl_isToday:(NSDate *)date{
    return [NSDate yl_isCurrentDate:date DateFormatter:@"yyyy-MM-dd"];
}

/**
 获取给定日期的月份

 @param date 给定日期
 */
+ (NSInteger) yl_monthFromDate:(NSDate *)date
{
    NSDateComponents *comps = [[NSDate yl_calendar] components:NSCalendarUnitMonth fromDate:date];
    return comps.month;
}

//获取给定日期所在周 是在当月的第几周
+ (NSInteger) yl_weekInMonthIndexWithDate:(NSDate *)date{
    NSDateComponents * components =[[NSDate yl_calendar] components:NSCalendarUnitWeekOfMonth fromDate:date];
    return components.weekOfMonth;
}

+ (NSInteger) yl_numberWeeksInMonthWithDate:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//指定日历的算法
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

/**
 a period of time from the current time
 以当前时间为起点,间隔几个时间单位的 date
 @param type 时间类型,间隔的是几年/月/日/时/分/秒/星期
 @param length 长度可以是正负数，
            正数是以当前时间为起点，向未来的时间间隔出几个时间单位。
            负数是以当前时间为起点，向过去时间间隔出几个时间单位。
 @return return value description
 */
+ (NSDate *) yl_datePeriodOfDateFromCurrentDateWithComponentsType:(YLDateComponentsType)type periodLength:(NSInteger)length{
    return [self yl_datePeriodOfDateFromStertDate:[NSDate date] componentsType:type periodLength:length];
}


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
+ (NSDate *) yl_datePeriodOfDateFromStertDate:(NSDate *)startDate componentsType:(YLDateComponentsType)type periodLength:(NSInteger)length{
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
    
    NSDate * nextData = [[self yl_calendar] dateByAddingComponents:components toDate:startDate options:NSCalendarMatchStrictly];
    return nextData;
}


+ (NSInteger) yl_weekDayStringWithDate:(NSDate *)date{
    NSCalendar * calendar = [self yl_calendar]; // 指定日历的算法
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    // 1 是周日，2是周一 3.以此类推
    return [comps weekday];
}

+ (BOOL) yl_isWorkingDayWith:(NSDate *)date{
    NSInteger index = [self yl_weekDayStringWithDate:date];
    if (index == 1 || index == 7) {
        return NO;
    }
    return YES;
}



#pragma mark - 通用

+ (NSCalendar *) yl_calendar{
    static NSCalendar *calendar;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        calendar.timeZone = [NSTimeZone localTimeZone];
    });
    return calendar;
}

+ (NSCalendar *) yl_chineseCalendar{
    static NSCalendar *calendar;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
        calendar.timeZone = [NSTimeZone localTimeZone];
    });
    return calendar;
}

+ (NSDateFormatter *) yl_dateFormatter:(NSString *)dateFormat{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = dateFormat;
    [dateFormatter setCalendar:[NSDate yl_calendar]];
    dateFormatter.timeZone = [NSDate yl_calendar].timeZone;
    return dateFormatter;
}

/**
 将 NSDate 转成 NSDateComponents 类型
 
 @param date 给定的 date
 */
+ (NSDateComponents *) yl_dateComponentsWithDate:(NSDate *)date{
    
    NSCalendar *calendar = [NSDate yl_calendar];//当前用户的calendar
    
    NSDateComponents * components = [calendar components:
                                     NSCalendarUnitEra |
                                     NSCalendarUnitYear |
                                     NSCalendarUnitMonth |
                                     NSCalendarUnitDay |
                                     NSCalendarUnitHour |
                                     NSCalendarUnitMinute |
                                     NSCalendarUnitSecond |
                                     NSCalendarUnitWeekday |
                                     NSCalendarUnitWeekdayOrdinal |
                                     NSCalendarUnitWeekOfMonth |
                                     NSCalendarUnitWeekOfYear |
                                     NSCalendarUnitNanosecond |
                                     NSCalendarUnitCalendar |
                                     NSCalendarUnitTimeZone |
                                     NSCalendarUnitYearForWeekOfYear |
                                     NSCalendarUnitQuarter
                                                fromDate:date];
    return components;
}


- (NSString *)yl_getDateDisplayString:(NSDate *)date{
    NSCalendar *calendar = [ NSCalendar currentCalendar ];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear ;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[ NSDate date ]];
    NSDateComponents *myCmps = [calendar components:unit fromDate:date];
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc ] init ];
    
    NSDateComponents *comp =  [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:date];
    
    if (nowCmps.year != myCmps.year) {
        dateFmt.dateFormat = @"yyyy/MM/dd";
    }
    else{
        if (nowCmps.day==myCmps.day) {
            dateFmt.AMSymbol = @"上午";
            dateFmt.PMSymbol = @"下午";
            dateFmt.dateFormat = @"aaa hh:mm";
        } else if((nowCmps.day-myCmps.day)==1) {
            dateFmt.AMSymbol = @"上午";
            dateFmt.PMSymbol = @"下午";
            dateFmt.dateFormat = @"昨天";
        } else {
            if ((nowCmps.day-myCmps.day) <=7) {
                switch (comp.weekday) {
                    case 1:
                        dateFmt.dateFormat = @"星期日";
                        break;
                    case 2:
                        dateFmt.dateFormat = @"星期一";
                        break;
                    case 3:
                        dateFmt.dateFormat = @"星期二";
                        break;
                    case 4:
                        dateFmt.dateFormat = @"星期三";
                        break;
                    case 5:
                        dateFmt.dateFormat = @"星期四";
                        break;
                    case 6:
                        dateFmt.dateFormat = @"星期五";
                        break;
                    case 7:
                        dateFmt.dateFormat = @"星期六";
                        break;
                    default:
                        break;
                }
            }else {
                dateFmt.dateFormat = @"yyyy/MM/dd";
            }
        }
    }
    return [dateFmt stringFromDate:date];
}
@end
