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

+ (UIColor *)yl_randomColor{
    CGFloat red = random()%255/255.0;
    CGFloat green = random()%255/255.0;
    CGFloat blue = random()%255/255.0;
   return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

/**
*  设置渐变色 默认从左向右 横向渐变
*  @param colors 颜色数组,
*  例:@[[UIColor redColor],[UIColor blackColor]] 或者
*  @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor blackColor].CGColor] 两者都可以
*  @param locations 渐变色区间,可为空,默认平均分配
*  @param frame view.bouns
*/
+ (CAGradientLayer *)yl_setGradientLayerVerticallyWithColors:(NSArray *)colors
                                                   locations:(NSArray *)locations
                                                       frame:(CGRect)frame
{
    return [UIColor yl_setGradientLayerWithColors:colors locations:locations frame:frame startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1.0, 0)];
}

/**
 *  设置渐变色
 *  @param colors 颜色数组,
 *  例:@[[UIColor redColor],[UIColor blackColor]] 或者
 *  @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor blackColor].CGColor] 两者都可以
 *  @param locations 渐变色区间,可为空,默认平均分配
 *  @param frame view.bouns
 *  @param startPoint  起始位置坐标 以左上角为起始位置 坐标(0,0) 右下角坐标(1,1)
 *  @param endPoint 终止位置坐标
 */
+ (CAGradientLayer *)yl_setGradientLayerWithColors:(NSArray *)colors
                                         locations:(NSArray *)locations
                                             frame:(CGRect)frame
                                        startPoint:(CGPoint)startPoint
                                          endPoint:(CGPoint)endPoint
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    NSMutableArray *colorsMarr = [NSMutableArray array];
    for (int i = 0 ; i<colors.count; i++) {
        id obj = colors[i];
        //获得色值描述
        NSString * describe = [NSString stringWithFormat:@"%@",obj];
        NSArray * arr = [describe componentsSeparatedByString:@" "];
        NSString * colorDescribe = arr.firstObject;
        if ([colorDescribe isEqualToString:@"UIExtendedSRGBColorSpace"] ||
            [colorDescribe isEqualToString:@"UICachedDeviceRGBColor"] ) {
            UIColor * c = (UIColor *)obj;
            [colorsMarr addObject:(__bridge id)c.CGColor];
        }else{
            [colorsMarr addObject:obj];
        }
    }
    gradientLayer.colors = colorsMarr;
    
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
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame = frame;
    return gradientLayer;
}
@end
