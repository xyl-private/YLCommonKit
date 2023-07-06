//
//  NSString+YLDecimalNumber.h
//  YLCommonKit
//
//  Created by xyanl on 2023/6/26.
//
// 数字处理

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YLDecimalNumber)

/// 加上, 求和
/// - Parameter aString: 加和
- (NSString *)yl_additionAString:(NSString *)aString;

/// 求两个数的和(加法: a+b)
/// - Parameters:
///   - aString: 数字a
///   - bString: 数字b
+ (NSString *)yl_additionWithAString:(NSString *)aString bString:(NSString *)bString;

/// 减去, 求差
/// - Parameter aString: 被减数
- (NSString *)yl_subtractionAString:(NSString *)aString;

/// 求两个数的差(减法: a-b)
/// - Parameters:
///   - aString: 数字a
///   - bString: 数字b
+ (NSString *)yl_subtractionWithAString:(NSString *)aString bString:(NSString *)bString;

/// 乘以, 求积
/// - Parameter aString: 被乘数
- (NSString *)yl_multiplyByAString:(NSString *)aString;

/// 求两个数的积(乘法: a*b)
/// - Parameters:
///   - aString: 数字a
///   - bString: 数字b
+ (NSString *)yl_multiplyByWithAString:(NSString *)aString bString:(NSString *)bString;

/// 除以, 求商
/// - Parameter aString: 被除数
- (NSString *)yl_dividingByAString:(NSString *)aString;

/// 求两个数的商(除法: a÷b)
/// - Parameters:
///   - aString: 数字a
///   - bString: 数字b
+ (NSString *)yl_dividingByWithAString:(NSString *)aString bString:(NSString *)bString;

/// 乘方, n的power次幂
/// - Parameter power: 次幂
- (NSString *)yl_raisingToPower:(NSUInteger)power;

/// 求一个数的乘方(乘方: a的power次幂)
/// - Parameters:
///   - aString: 数字a
///   - power: 次幂数
+ (NSString *)yl_raisingToPowerWithAString:(NSString *)aString power:(NSUInteger)power;


/// 小数点取舍处理方法
/// - Parameters:
///   - roundingMode: 取舍方式
///   - scale: 小数点后舍入值的位数
- (NSString *)yl_roundingMode:(NSRoundingMode)roundingMode scale:(NSInteger)scale;

/// 小数点取舍处理方法
/// - Parameters:
///   - aString: 需要计算的数值
///   - roundingMode: 取舍方式
///   - scale: 小数点后保留的位数
+ (NSString *)yl_roundingModeWithAString:(NSString *)aString roundingMode:(NSRoundingMode)roundingMode scale:(NSInteger)scale;

@end

NS_ASSUME_NONNULL_END
