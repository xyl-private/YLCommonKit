//
//  NSString+YLDecimalNumber.m
//  YLCommonKit
//
//  Created by xyanl on 2023/6/26.
//

#import "NSString+YLDecimalNumber.h"

@implementation NSString (YLDecimalNumber)


/// 加上, 求和
/// - Parameter aString: 加和
- (NSString *)yl_additionAString:(NSString *)aString {
    NSDecimalNumber *selfNumber = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:aString];
    return [selfNumber decimalNumberByAdding:aNumber].stringValue;
}

/// 求两个数的和(加法: a+b)
/// - Parameters:
///   - aString: 数字a
///   - bString: 数字b
+ (NSString *)yl_additionWithAString:(NSString *)aString bString:(NSString *)bString {
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:aString];
    NSDecimalNumber *bNumber = [NSDecimalNumber decimalNumberWithString:bString];
    return [aNumber decimalNumberByAdding:bNumber].stringValue;
}

/// 减去, 求差
/// - Parameter aString: 被减数
- (NSString *)yl_subtractionAString:(NSString *)aString {
    NSDecimalNumber *selfNumber = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:aString];
    return [selfNumber decimalNumberBySubtracting:aNumber].stringValue;
}

/// 求两个数的差(减法: a-b)
/// - Parameters:
///   - aString: 数字a
///   - bString: 数字b
+ (NSString *)yl_subtractionWithAString:(NSString *)aString bString:(NSString *)bString {
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:aString];
    NSDecimalNumber *bNumber = [NSDecimalNumber decimalNumberWithString:bString];
    return [aNumber decimalNumberBySubtracting:bNumber].stringValue;
}

/// 乘以, 求积
/// - Parameter aString: 被乘数
- (NSString *)yl_multiplyByAString:(NSString *)aString {
    NSDecimalNumber *selfNumber = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:aString];
    return [selfNumber decimalNumberByMultiplyingBy:aNumber].stringValue;
}

/// 求两个数的积(乘法: a*b)
/// - Parameters:
///   - aString: 数字a
///   - bString: 数字b
+ (NSString *)yl_multiplyByWithAString:(NSString *)aString bString:(NSString *)bString {
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:aString];
    NSDecimalNumber *bNumber = [NSDecimalNumber decimalNumberWithString:bString];
    return [aNumber decimalNumberByMultiplyingBy:bNumber].stringValue;
}

/// 除以, 求商
/// - Parameter aString: 被除数
- (NSString *)yl_dividingByAString:(NSString *)aString {
    NSDecimalNumber *selfNumber = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:aString];
    return [selfNumber decimalNumberByDividingBy:aNumber].stringValue;
}

/// 求两个数的商(除法: a÷b)
/// - Parameters:
///   - aString: 数字a
///   - bString: 数字b
+ (NSString *)yl_dividingByWithAString:(NSString *)aString bString:(NSString *)bString {
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:aString];
    NSDecimalNumber *bNumber = [NSDecimalNumber decimalNumberWithString:bString];
    return [aNumber decimalNumberByDividingBy:bNumber].stringValue;
}

/// 乘方, n的power次幂
/// - Parameter power: 次幂
- (NSString *)yl_raisingToPower:(NSUInteger)power {
    NSDecimalNumber *selfNumber = [NSDecimalNumber decimalNumberWithString:self];
    return [selfNumber decimalNumberByRaisingToPower:power].stringValue;
}

/// 求一个数的乘方(乘方: a的power次幂)
/// - Parameters:
///   - aString: 数字a
///   - power: 次幂数
+ (NSString *)yl_raisingToPowerWithAString:(NSString *)aString power:(NSUInteger)power {
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:aString];
    return [aNumber decimalNumberByRaisingToPower:power].stringValue;
}


/// 小数点取舍处理方法
/// - Parameters:
///   - roundingMode: 取舍方式
///   - scale: 小数点后保留的位数
- (NSString *)yl_roundingMode:(NSRoundingMode)roundingMode scale:(NSInteger)scale {
    return [NSString yl_roundingModeWithAString:self roundingMode:roundingMode scale:scale];    
}

/// 小数点取舍处理方法
/// - Parameters:
///   - aString: 需要计算的数值
///   - roundingMode: 取舍方式
///   - scale: 小数点后保留的位数
+ (NSString *)yl_roundingModeWithAString:(NSString *)aString roundingMode:(NSRoundingMode)roundingMode scale:(NSInteger)scale {
    /**
     * NSRoundPlain: 四舍五入 
     * NSRoundDown: 向下取整 
     * NSRoundUp: 向上取整
     * NSRoundBankers: 特殊的四舍五入，碰到保留位数后一位的数字为5时，根据前一位数字的奇偶性决定向下还是向上取整，为偶时向下取整，为奇数时向上取整。 如：1.25保留1位小数。5之前的数字是2，2是偶数则向下取整1.2； 1.35保留1位小数时，5之前的数字是3, 3是奇数则向上取整1.4
     * scale:精确到几位小数
     * raiseOnExactness: 发生精确错误时是否抛出异常，一般为NO
     * raiseOnOverflow: 发生溢出错误时是否抛出异常，一般为NO
     * raiseOnUnderflow: 发生不足错误时是否抛出异常，一般为NO
     * raiseOnDivideByZero: 被0除时是否抛出异常，一般为YES
     */
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundingMode scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber * ouncesDecimal = [NSDecimalNumber decimalNumberWithString:aString];
    ouncesDecimal = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return ouncesDecimal.stringValue;
}



@end
