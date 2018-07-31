//
//  UIColor+YLColor.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "UIColor+YLColor.h"

static NSString * const colorStrPrefix1 = @"0X";
static NSString * const colorStrPrefix2 = @"#";

@implementation UIColor (YLColor)
/**
 *  十六进制颜色 - 不透明
 */
+ (UIColor *) yl_colorWithHexString:(NSString *)hexColor
{
    return [self yl_colorWithHexString:hexColor alpha:1.0f];
}

/**
 *  十六进制颜色 - 可透明
 */
+ (UIColor *) yl_colorWithHexString:(NSString *)hexColor alpha:(CGFloat)alpha
{
    // 替换空格&统一变大写
    NSString *colorStr = [[hexColor stringByReplacingOccurrencesOfString:@" " withString:@""] uppercaseString];
    // 替换头部
    if ([colorStr hasPrefix:colorStrPrefix1]) {
        colorStr = [colorStr stringByReplacingOccurrencesOfString:colorStrPrefix1 withString:@""];
    }
    if ([colorStr hasPrefix:colorStrPrefix2]) {
        colorStr = [colorStr stringByReplacingOccurrencesOfString:colorStrPrefix2 withString:@""];
    }
    // 检查字符串长度
    if (colorStr.length != 6) {
        NSLog(@"请检查hexColor字符串长度是否正确");
        return [UIColor clearColor];
    }
    NSRange range;
    range.location = 0;
    range.length = 2;
    //red
    NSString *redString = [colorStr substringWithRange:range];
    //green
    range.location = 2;
    NSString *greenString = [colorStr substringWithRange:range];
    //blue
    range.location = 4;
    NSString *blueString= [colorStr substringWithRange:range];
    
    // Scan values
    unsigned int red, green, blue;
    [[NSScanner scannerWithString:redString] scanHexInt:&red];
    [[NSScanner scannerWithString:greenString] scanHexInt:&green];
    [[NSScanner scannerWithString:blueString] scanHexInt:&blue];
    return [UIColor colorWithRed:((CGFloat)red/ 255.0f) green:((CGFloat)green/ 255.0f) blue:((CGFloat)blue/ 255.0f) alpha:alpha];
}

+ (CAGradientLayer *) yl_getGraduallyChangingColor:(NSArray *)colors locations:(NSArray *)locations frame:(CGRect)frame{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    NSMutableArray *CGColorsArr = [NSMutableArray array];
    for (int i = 0 ; i<colors.count; i++) {
        id obj = colors[i];
        if ([[obj class] isKindOfClass:[UIColor class]]) {
            UIColor *color = (UIColor *)obj;
            [CGColorsArr addObject:color];
        }else{
            [CGColorsArr addObject:obj];
        }
    }
    gradientLayer.colors = CGColorsArr;
    
    if (locations.count) {
        gradientLayer.locations = locations;
    }else{
        NSMutableArray * templocations = [NSMutableArray array];
        for (int i = 0 ; i<colors.count; i++) {
            double value = (1.0/colors.count) * i;
            [templocations addObject:@(value)];
        }
        gradientLayer.locations = templocations;
    }
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = frame;
    return gradientLayer;
}
@end
