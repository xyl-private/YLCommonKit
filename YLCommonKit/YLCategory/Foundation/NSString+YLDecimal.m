//
//  NSString+YLDecimal.m
//  YLCommonKit
//
//  Created by xyanl on 2023/7/7.
//  Copyright © 2023 xyanl. All rights reserved.
//

#import "NSString+YLDecimal.h"

@implementation NSString (YLDecimal)

/// 小数运算
/// - Parameters:
///   - type: 运算类型
///   - string: 被运算的小数
- (NSString *)yl_decimalWithType:(YLDecimalType)type operatedString:(NSString *)string {
    
    NSString *aString = @"0";
    NSString *bString = @"0";
    
    if (self.length > 0) {
        aString = self;
    }
    if (string.length > 0) {
        bString = string;
    }
    
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:aString];
    NSDecimalNumber *bNumber = [NSDecimalNumber decimalNumberWithString:bString];
    
    switch (type) {
        case YLDecimalTypeAdd: {
            return [[aNumber decimalNumberByAdding:bNumber] stringValue];
        } break;
        case YLDecimalTypeSubtraction: {
            return [[aNumber decimalNumberBySubtracting:bNumber] stringValue];
        } break;
        case YLDecimalTypeMultiply: {
            return [[aNumber decimalNumberByMultiplyingBy:bNumber] stringValue];
        } break;
        case YLDecimalTypeDivision: {
            return [[aNumber decimalNumberByDividingBy:bNumber] stringValue];
        } break;
    }
    return @"";
}

/// 加上, 求和
/// - Parameter aString: 加和
- (NSString *)yl_additionAString:(NSString *)aString {
    return [self yl_decimalWithType:YLDecimalTypeAdd operatedString:aString];
}

/// 减去, 求差
/// - Parameter aString: 被减数
- (NSString *)yl_subtractionAString:(NSString *)aString {
    return [self yl_decimalWithType:YLDecimalTypeSubtraction operatedString:aString];
}

/// 乘以, 求积
/// - Parameter aString: 被乘数
- (NSString *)yl_multiplyByAString:(NSString *)aString {
    return [self yl_decimalWithType:YLDecimalTypeMultiply operatedString:aString];
}

/// 除以, 求商
/// - Parameter aString: 被除数
- (NSString *)yl_dividingByAString:(NSString *)aString {
    return [self yl_decimalWithType:YLDecimalTypeDivision operatedString:aString];
}

/// 乘方, n的power次幂
/// - Parameter power: 次幂
- (NSString *)yl_raisingToPower:(NSUInteger)power {
    NSDecimalNumber *selfNumber = [NSDecimalNumber decimalNumberWithString:self];
    return [selfNumber decimalNumberByRaisingToPower:power].stringValue;
}

/// 小数点取舍处理方法
/// - Parameters:
///   - roundingMode: 取舍方式
///   - scale: 小数点后保留的位数
- (NSString *)yl_decimalWithRoundingMode:(NSRoundingMode)roundingMode scale:(NSInteger)scale {
    
    NSString *aString = self;
    if (aString.length == 0) {
        aString = @"0";
    }
    /**
     * NSRoundPlain: 四舍五入 
     * NSRoundDown: 向下取整 
     * NSRoundUp: 向上取整
     * NSRoundBankers: 特殊的四舍五入， 碰到保留位数后一位的数字为5时， 根据前一位数字的奇偶性决定向下还是向上取整， 为偶时向下取整， 为奇数时向上取整。  如：1.25保留1位小数。 5之前的数字是2， 2是偶数则向下取整1.2； 1.35保留1位小数时， 5之前的数字是3,  3是奇数则向上取整1.4。
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

/// 小数点取舍处理方法
/// @param roundingMode  舍入方式
/// @param number 需要计算的数值
/// @param scale 小数点后舍入值的位数
+ (NSString *)yl_decimalNumberWithRoundingMode:(NSRoundingMode)roundingMode number:(NSString *)number scale:(int)scale {
    return [number yl_decimalWithRoundingMode:roundingMode scale:scale];
}


/// 数字格式化
/// 小数点后，位数不足的用0补位，位数多出的部分四舍五入
/// - Parameter format: 格式 例: ,##0.00  结果 123,456,789.12
- (NSString *)yl_numberFormatWithFormat:(NSString *)format {
    return [NSString yl_numberFormatWithNumber:self format:format];
}

/// 数字格式化
/// - Parameters:
///   - number: 数字 例: 123456789.1234
///   - format: 格式 例: ,##0.00  结果 123,456,789.12
+ (NSString *)yl_numberFormatWithNumber:(NSString *)number format:(NSString *)format {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:format];
    return [numberFormatter stringFromNumber:@(number.doubleValue)];
}

/// 在数字前面添加0
/// - Parameters:
///   - number: 数字
///   - length: 添加后的总长度 例: number = @"25" length = 5, 结果为 @"00025"
+ (NSString *)yl_beforeAddZoreWithNumber:(NSString *)number length:(NSInteger)length {
    if (number.length > length) {
        return number;
    }
    NSInteger index = 1;
    for (NSInteger i = 0; i < length; i ++) {
        index = index * 10; 
    }
    index += number.integerValue;
    
    return [@(index).stringValue substringFromIndex:1];
}
@end
