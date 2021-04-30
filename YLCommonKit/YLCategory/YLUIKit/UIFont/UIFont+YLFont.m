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

+ (NSString *)pingFangSCWithType:(YLFontType)type{
    NSDictionary * dic = @{
        @(YLFontTypePingFangSC_Ultralight):@"PingFangSC-Regular",
        @(YLFontTypePingFangSC_Thin):@"PingFangSC-Regular",
        @(YLFontTypePingFangSC_Light):@"PingFangSC-Regular",
        @(YLFontTypePingFangSC_Regular):@"PingFangSC-Regular",
        @(YLFontTypePingFangSC_Medium):@"PingFangSC-Regular",
        @(YLFontTypePingFangSC_Semibold):@"PingFangSC-Regular",
    };
    return dic[@(type)];
}

@end
