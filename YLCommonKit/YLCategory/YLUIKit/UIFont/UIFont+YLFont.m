//
//  UIFont+YLFont.m
//  YLCommonKit
//
//  Created by 徐先生 on 2021/5/1.
//  Copyright © 2021 xyanl. All rights reserved.
//

#import "UIFont+YLFont.h"

@implementation UIFont (YLFont)

+ (UIFont *)yl_systemFontSize:(NSInteger)size{
    return [UIFont fontWithName:[UIFont pingFangSCWithType:YLFontTypePingFangSC_Regular] size:size];
}

+ (UIFont *)yl_fontType:(YLFontType )type size:(NSInteger)size{
    return [UIFont fontWithName:[UIFont pingFangSCWithType:type] size:size];
}

+ (NSString *)pingFangSCWithType:(QKFontWeightType)type{
    NSDictionary * dic = @{
        @(QKFontWeightTypePingFangSC_Ultralight):@"PingFangSC-Ultralight",
        @(QKFontWeightTypePingFangSC_Thin):@"PingFangSC-Thin",
        @(QKFontWeightTypePingFangSC_Light):@"PingFangSC-Light",
        @(QKFontWeightTypePingFangSC_Regular):@"PingFangSC-Regular",
        @(QKFontWeightTypePingFangSC_Medium):@"PingFangSC-Medium",
        @(QKFontWeightTypePingFangSC_Semibold):@"PingFangSC-Semibold",
    };
    return dic[@(type)];
}

@end
