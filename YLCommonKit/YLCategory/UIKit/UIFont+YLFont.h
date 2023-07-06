//
//  UIFont+YLFont.h
//  YLCommonKit
//
//  Created by 徐先生 on 2021/5/1.
//  Copyright © 2021 xyanl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (YLFont)

/// 字体大小, 数字、英文字母是等宽的
/// - Parameters:
///   - weight: 字体类型
///   - size: 字号
+ (UIFont *)yl_fontMonospacedOfWeight:(UIFontWeight)weight size:(NSInteger)size;

/// 系统字体大小
/// - Parameters:
///   - weight: 字体类型
///   - size: 字号
+ (UIFont *)yl_fontSystemOfWeight:(UIFontWeight)weight size:(NSInteger)size;


/// 获取系统所有的字体库名
+ (NSArray *)yl_fontFamilyNames;


/// 字体库中所有字体类型
/// - Parameter familyName: 库名
+ (NSArray *)yl_fontNamesForFamilyName:(NSString *)familyName;

@end

NS_ASSUME_NONNULL_END
