//
//  NSString+YLDecimal.h
//  YLCommonKit
//
//  Created by xyanl on 2023/7/7.
//  Copyright © 2023 xyanl. All rights reserved.
//
//  Decimal 小数
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YLDecimalType) {
    /// 加
    YLDecimalTypeAdd,
    /// 减
    YLDecimalTypeSubtraction,
    /// 乘
    YLDecimalTypeMultiply,
    /// 除
    YLDecimalTypeDivision
};

@interface NSString (YLDecimal)

/// 小数运算
/// - Parameters:
///   - type: 运算类型
///   - string: 被运算的小数
- (NSString *)yl_decimalWithType:(YLDecimalType)type operatedString:(NSString *)string;

/// 加上, 求和
/// - Parameter aString: 加和
- (NSString *)yl_additionAString:(NSString *)aString;

/// 减去, 求差
/// - Parameter aString: 被减数
- (NSString *)yl_subtractionAString:(NSString *)aString;

/// 乘以, 求积
/// - Parameter aString: 被乘数
- (NSString *)yl_multiplyByAString:(NSString *)aString;

/// 除以, 求商
/// - Parameter aString: 被除数
- (NSString *)yl_dividingByAString:(NSString *)aString;

/// 乘方, n的power次幂
/// - Parameter power: 次幂
- (NSString *)yl_raisingToPower:(NSUInteger)power;

/// 小数点取舍处理方法
/// - Parameters:
///   - roundingMode: 取舍方式
///   - scale: 小数点后保留的位数
- (NSString *)yl_decimalWithRoundingMode:(NSRoundingMode)roundingMode scale:(NSInteger)scale;

/// 小数点取舍处理方法
/// @param roundingMode  舍入方式
/// @param number 需要计算的数值
/// @param scale 小数点后舍入值的位数
+ (NSString *)yl_decimalNumberWithRoundingMode:(NSRoundingMode)roundingMode number:(NSString *)number scale:(int)scale;


/// 数字格式化
/// - Parameter format: 格式 例: ,##0.00  结果 123,456,789.12
- (NSString *)yl_numberFormatWithFormat:(NSString *)format;

/// 数字格式化
/// - Parameters:
///   - number: 数字 例: 123456789.1234
///   - format: 格式 例: ,##0.00  结果 123,456,789.12
+ (NSString *)yl_numberFormatWithNumber:(NSString *)number format:(NSString *)format;

/// 在数字前面添加0
/// - Parameters:
///   - number: 数字
///   - length: 添加后的总长度 例: number = @"25" length = 5, 结果为 @"00025"
+ (NSString *)yl_beforeAddZoreWithNumber:(NSString *)number length:(NSInteger)length;

@end

NS_ASSUME_NONNULL_END
