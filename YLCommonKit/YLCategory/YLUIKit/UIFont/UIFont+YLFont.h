//
//  UIFont+YLFont.h
//  YLCommonKit
//
//  Created by 徐先生 on 2021/5/1.
//  Copyright © 2021 xyanl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YLFontType) {
    /// 苹方-简 极细体
    YLFontTypePingFangSC_Ultralight,
    /// 苹方-简 纤细体
    YLFontTypePingFangSC_Thin,
    /// 苹方-简 细体
    YLFontTypePingFangSC_Light,
    /// 苹方-简 常规体
    YLFontTypePingFangSC_Regular,
    /// 苹方-简 中黑体
    YLFontTypePingFangSC_Medium,
    /// 苹方-简 中粗体
    YLFontTypePingFangSC_Semibold
};

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

#pragma mark - 弃用
/// 设置字体 默认:常规体
/// @param size 字体大小
+ (UIFont *)yl_systemFontSize:(NSInteger)size DEPRECATED_MSG_ATTRIBUTE("Use 'yl_fontSystemOfWeight:size:' instead");
/// 设置字体
/// @param type 字重类型
/// @param size 字体大小
+ (UIFont *)yl_fontType:(YLFontType )type size:(NSInteger)size DEPRECATED_MSG_ATTRIBUTE("Use 'yl_fontSystemOfWeight:size:' instead");
@end

NS_ASSUME_NONNULL_END
