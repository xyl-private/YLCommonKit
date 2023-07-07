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

/// 乘方, n的power次幂
/// - Parameter power: 次幂
- (NSString *)yl_raisingToPower:(NSUInteger)power;

/// 小数点取舍处理方法
/// - Parameters:
///   - roundingMode: 取舍方式
///   - scale: 小数点后保留的位数
- (NSString *)yl_decimalWithRoundingMode:(NSRoundingMode)roundingMode scale:(NSInteger)scale;


@end

NS_ASSUME_NONNULL_END
