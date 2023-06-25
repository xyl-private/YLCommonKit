//
//  UIColor+YLColor.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "UIColor+YLColor.h"

@implementation UIColor (YLColor)

/// 十六进制颜色 - 不透明
/// - Parameter hexColor: 十六进制颜色
+ (UIColor *)yl_colorWithHexString:(NSString *)hexColor {
    return [self yl_colorWithHexString:hexColor alpha:1.0f];
}

/// 十六进制颜色 - 可透明
/// - Parameters:
///   - hexColor: 十六进制颜色
///   - alpha: 透明度
+ (UIColor *)yl_colorWithHexString:(NSString *)hexColor alpha:(CGFloat)alpha {
    // 统一变大写
    NSString *colorStr = [hexColor uppercaseString];
    // 删除空格
    colorStr = [colorStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    // 替换头部
    colorStr = [colorStr stringByReplacingOccurrencesOfString:@"#" withString:@""];
    colorStr = [colorStr stringByReplacingOccurrencesOfString:@"0X" withString:@""];
    
    // 检查字符串长度
    if (colorStr.length != 6) {
        NSLog(@"请检查hexColor字符串长度是否正确");
        return [UIColor clearColor];
    }
    
    //red
    NSString *redString = [colorStr substringWithRange:NSMakeRange(0, 2)];
    //green
    NSString *greenString = [colorStr substringWithRange:NSMakeRange(2, 2)];
    //blue
    NSString *blueString= [colorStr substringWithRange:NSMakeRange(4, 2)];
    
    // Scan values
    unsigned int red, green, blue;
    [[NSScanner scannerWithString:redString] scanHexInt:&red];
    [[NSScanner scannerWithString:greenString] scanHexInt:&green];
    [[NSScanner scannerWithString:blueString] scanHexInt:&blue];
    return [UIColor colorWithRed:((CGFloat)red/ 255.0f) green:((CGFloat)green/ 255.0f) blue:((CGFloat)blue/ 255.0f) alpha:alpha];
}

+ (UIColor *)yl_randomColor {
    CGFloat red = random()%255/255.0;
    CGFloat green = random()%255/255.0;
    CGFloat blue = random()%255/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}


/// UIColor 转十六进制
- (NSString *)yl_hexadecimalColor {
    if (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)) != kCGColorSpaceModelRGB) {
        NSLog(@"非RGB：");
        if ([self isEqual:[UIColor clearColor]]) {
            return @"#000000FF";
        } else if ([self isEqual:[UIColor whiteColor]]) {
            return @"#FFFFFF";
        } else {
            return @"000000";
        }
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    
    if (CGColorGetNumberOfComponents(self.CGColor) < 4) {
        NSLog(@"CGColorGetNumberOfComponents < 4");
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        CGFloat r = components[0];//红色
        CGFloat g = components[1];//绿色
        CGFloat b = components[2];//蓝色
        return [NSString stringWithFormat:@"#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255)];
        
    }
    
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    CGFloat a = components[3];
    if (a == 1) {
        return [NSString stringWithFormat:@"#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255)] ;
    }
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255)];
}

/**
 *  设置渐变色 默认从左向右 横向渐变
 *  @param colors 颜色数组,
 *  例:@[[UIColor redColor],[UIColor blackColor]] 或者
 *  @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor blackColor].CGColor] 两者都可以
 *  @param locations 渐变色区间,可为空,默认平均分配
 *  @param frame view.bouns
 */
+ (UIColor *)yl_setGradientVerticallyWithColors:(NSArray *)colors locations:(NSArray *)locations frame:(CGRect)frame {
    return [UIColor yl_setGradientWithColors:colors locations:locations frame:frame startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1.0, 0.0)];
}

/**
 *  设置渐变色 默认从上向下 纵向渐变
 *  @param colors 颜色数组,
 *  例:@[[UIColor redColor],[UIColor blackColor]] 或者
 *  @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor blackColor].CGColor] 两者都可以
 *  @param locations 渐变色区间,可为空,默认平均分配
 *  @param frame view.bouns
 */
+ (UIColor *)yl_setGradientHorizontalWithColors:(NSArray *)colors locations:(NSArray *)locations frame:(CGRect)frame {
    return [UIColor yl_setGradientWithColors:colors locations:locations frame:frame startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0.0, 1.0)];
}

/**
 *  设置渐变色
 *  @param colors 颜色数组,
 *  例:@[[UIColor redColor],[UIColor blackColor]] 或者
 *  @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor blackColor].CGColor] 两者都可以
 *  @param locations 渐变色区间,可为空,默认平均分配,例@[0, 0.3, 0.6, 1]
 *  @param frame view.bouns
 *  @param startPoint 左上角起始点 CGPointMake(0, 0);
 *  @param endPoint 右下角是终点 CGPointMake(1, 1);
 */
+ (UIColor *)yl_setGradientWithColors:(NSArray *)colors locations:(NSArray *)locations frame:(CGRect)frame startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    CAGradientLayer *gradientLayer = [UIColor yl_setGradientLayerWithColors:colors locations:locations frame:frame startPoint:startPoint endPoint:endPoint];
    UIGraphicsBeginImageContext(frame.size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];
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
+ (CAGradientLayer *)yl_setGradientLayerWithColors:(NSArray *)colors locations:(NSArray *)locations frame:(CGRect)frame startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
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
    } else {
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
