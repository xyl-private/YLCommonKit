//
//  UIFont+YLFont.m
//  YLCommonKit
//
//  Created by 徐先生 on 2021/5/1.
//  Copyright © 2021 xyanl. All rights reserved.
//

#import "UIFont+YLFont.h"

@implementation UIFont (YLFont)

/// 字体大小, 数字、英文字母是等宽的
/// - Parameters:
///   - weight: 字体类型
///   - size: 字号
+ (UIFont *)yl_fontMonospacedOfWeight:(UIFontWeight)weight size:(NSInteger)size{
    return [UIFont monospacedSystemFontOfSize:size weight:weight];
}

/// 系统字体大小
/// - Parameters:
///   - weight: 字体类型
///   - size: 字号
+ (UIFont *)yl_fontSystemOfWeight:(UIFontWeight)weight size:(NSInteger)size{
    return [UIFont systemFontOfSize:size weight:weight];
}


/// 获取系统所有的字体库名
+ (NSArray *)yl_fontFamilyNames {
    return [UIFont familyNames];
}


/// 字体库中所有字体类型
/// - Parameter familyName: 库名
+ (NSArray *)yl_fontNamesForFamilyName:(NSString *)familyName {
    return [UIFont fontNamesForFamilyName:familyName];
}

+ (UIFont *)yl_systemFontSize:(NSInteger)size{
    return [UIFont fontWithName:[UIFont pingFangSCWithType:YLFontTypePingFangSC_Regular] size:size];
}

+ (UIFont *)yl_fontType:(YLFontType )type size:(NSInteger)size{
    return [UIFont fontWithName:[UIFont pingFangSCWithType:type] size:size];
}

+ (NSString *)pingFangSCWithType:(YLFontType)type{
    NSDictionary * dic = @{
        @(YLFontTypePingFangSC_Ultralight):@"PingFangSC-Ultralight",
        @(YLFontTypePingFangSC_Thin):@"PingFangSC-Thin",
        @(YLFontTypePingFangSC_Light):@"PingFangSC-Light",
        @(YLFontTypePingFangSC_Regular):@"PingFangSC-Regular",
        @(YLFontTypePingFangSC_Medium):@"PingFangSC-Medium",
        @(YLFontTypePingFangSC_Semibold):@"PingFangSC-Semibold",
    };
    return dic[@(type)];
}

@end
