//
//  UIColor+YLColor.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "UIColor+YLColor.h"
#import "UIImage+YLImage.h"

@implementation UIColor (YLColor)

/// color 转 image
- (UIImage *)image {
    return [UIImage yl_imageWithColor:self];
}

UIColor *YLColor(NSString *hexString) {
    return [UIColor yl_colorWithHexString:hexString];
}

UIColor *YLColorAlpha(NSString *hexString, CGFloat alpha) {
    return [UIColor yl_colorWithHexString:hexString alpha:alpha];
}

/// 十六进制颜色 - 不透明
/// - Parameter hexColor: 十六进制颜色
+ (UIColor *)yl_colorWithHexString:(NSString *)hexString {
    return [self yl_colorWithHexString:hexString alpha:1.0f];
}

/// 十六进制颜色 - 可透明
/// - Parameters:
///   - hexColor: 十六进制颜色
///   - alpha: 透明度
+ (UIColor *)yl_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    // 统一变大写
    NSString *colorString = [hexString uppercaseString];
    // 删除空格
    colorString = [colorString stringByReplacingOccurrencesOfString:@" " withString:@""];
    // 替换头部
    colorString = [colorString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    colorString = [colorString stringByReplacingOccurrencesOfString:@"0X" withString:@""];
    
    // 检查字符串长度
    if (colorString.length != 6) {
        NSLog(@"请检查hexColor字符串长度是否正确");
        return [UIColor clearColor];
    }
    
    //red
    NSString *redString = [colorString substringWithRange:NSMakeRange(0, 2)];
    //green
    NSString *greenString = [colorString substringWithRange:NSMakeRange(2, 2)];
    //blue
    NSString *blueString= [colorString substringWithRange:NSMakeRange(4, 2)];
    
    // Scan values
    unsigned int red, green, blue;
    [[NSScanner scannerWithString:redString] scanHexInt:&red];
    [[NSScanner scannerWithString:greenString] scanHexInt:&green];
    [[NSScanner scannerWithString:blueString] scanHexInt:&blue];
    return [UIColor colorWithRed:((CGFloat)red/ 255.0f) green:((CGFloat)green/ 255.0f) blue:((CGFloat)blue/ 255.0f) alpha:alpha];
}

/// 重新设置颜色的透明度
/// - Parameter alpha: 透明度 0~1
- (UIColor *)alpha:(CGFloat)alpha {
    CGFloat hue; // 色度,颜色
    CGFloat saturation; // 饱和度
    CGFloat brightness; // 亮度
    //获取该颜色的几项值
    [self getHue:&hue saturation:&saturation brightness:&brightness alpha:nil];
    //重新把几项值+新透明度重新组合成新颜色
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

+ (UIColor *)yl_randomColor {
    CGFloat red = random()%255/255.0;
    CGFloat green = random()%255/255.0;
    CGFloat blue = random()%255/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}


/// UIColor 转十六进制(6位:十六进制的颜色字符串  8位:十六进制+2位的透明度)
- (NSString *)yl_hexColor {
    if (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)) != kCGColorSpaceModelRGB) {
        NSLog(@"非RGB");
        if ([self isEqual:[UIColor clearColor]]) {
            return @"000000FF";
        } else if ([self isEqual:[UIColor whiteColor]]) {
            return @"FFFFFF";
        } else {
            return @"000000";
        }
        return [NSString stringWithFormat:@"FFFFFF"];
    }
    
    if (CGColorGetNumberOfComponents(self.CGColor) < 4) {
        NSLog(@"CGColorGetNumberOfComponents < 4");
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        CGFloat r = components[0];//红色
        CGFloat g = components[1];//绿色
        CGFloat b = components[2];//蓝色
        return [NSString stringWithFormat:@"%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255)];
    }
    
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    CGFloat a = components[3];
    if (a == 1) {
        return [NSString stringWithFormat:@"%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255)];
    }
    return [NSString stringWithFormat:@"%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255)];
}

#pragma mark - 动态 暗黑模式

/// 适配暗黑模式颜色
/// - Parameters:
///   - lightColor: 浅色模式颜色(UIColor或者NSString)
///   - darkColor: 深色模式颜色(UIColor或者NSString)
UIColor * YLDynamicColors(id lightColor, id darkColor) {
    
    UIColor *lColor = [UIColor whiteColor];
    UIColor *dColor = [UIColor blackColor];
    
    if ([lightColor isKindOfClass:[UIColor class]]) {
        lColor = (UIColor *)lightColor;
    } else if ([lightColor isKindOfClass:[NSString class]]) {
        lColor = [UIColor yl_colorWithHexString:(NSString *)lightColor];
    } else {
        NSLog(@"浅色模式的颜色类型错误");
        return nil;
    }
    
    if ([darkColor isKindOfClass:[UIColor class]]) {
        dColor = (UIColor *)darkColor;
    } else if ([darkColor isKindOfClass:[NSString class]]) {
        dColor = [UIColor yl_colorWithHexString:(NSString *)darkColor];
    } else {
        NSLog(@"深色模式的颜色类型错误");
        return nil;
    }
    
    return [UIColor yl_dynamicColorsWithLightColor:lColor darkColor:dColor];
}

/// 适配暗黑模式颜色
/// - Parameters:
///   - lightColor: 浅色模式颜色
///   - darkColor: 深色模式颜色
+ (UIColor *)yl_dynamicColorsWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
            if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                return lightColor;
            } else {
                return darkColor;
            }
        }];
    } else {
        return lightColor ? lightColor : (darkColor ? darkColor : [UIColor clearColor]);
    }
}

#pragma mark - Gradient 渐变色
+ (UIColor *)yl_gradientWithDirection:(YLGradientDirection)direction colors:(NSArray *)colors frame:(CGRect)frame {
    return [UIColor yl_gradientWithDirection:direction colors:colors frame:frame locations:@[]];
}

/**
 * 创建渐变颜色
 * @param direction 渐变方向
 * @param colors 颜色数组，可以是UIColor对象或CGColorRef
 * @param frame 渐变区域
 * @param locations 位置数组(可选)，数值范围0-1
 * @return 渐变颜色对象，失败返回nil
 */
+ (UIColor *)yl_gradientWithDirection:(YLGradientDirection)direction
                              colors:(NSArray *)colors
                               frame:(CGRect)frame
                          locations:(NSArray *)locations {
    
    // 参数校验
    if (CGRectIsEmpty(frame) || colors.count == 0) {
        return nil;
    }
    
    // 设置起点和终点
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointZero;
    
    switch(direction) {
        case YLGradientDirectionHorizontal:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        case YLGradientDirectionVertical:
            endPoint = CGPointMake(0.0, 1.0);
            break;
        case YLGradientDirectionUpDiagonalLine:
            endPoint = CGPointMake(1.0, 1.0);
            break;
        case YLGradientDirectionDownDiagonalLine:
            startPoint = CGPointMake(0.0, 1.0);
            endPoint = CGPointMake(1.0, 0.0);
            break;
        default:
            break;
    }
    
    return [self yl_gradientWithColors:colors frame:frame locations:locations startPoint:startPoint endPoint:endPoint];
}

/**
 * 创建渐变颜色
 * @param colors 颜色数组
 * @param frame 渐变区域
 * @param locations 位置数组(可选)
 * @param startPoint 起点(CGPoint)
 * @param endPoint 终点(CGPoint)
 * @return 渐变颜色对象
 */
+ (UIColor *)yl_gradientWithColors:(NSArray *)colors
                            frame:(CGRect)frame
                       locations:(NSArray *)locations
                      startPoint:(CGPoint)startPoint
                        endPoint:(CGPoint)endPoint {
    
    CAGradientLayer *gradientLayer = [self yl_gradientLayerWithColors:colors
                                                              frame:frame
                                                         locations:locations
                                                        startPoint:startPoint
                                                          endPoint:endPoint];
    
    // 使用UIGraphics生成渐变图像
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image ? [UIColor colorWithPatternImage:image] : nil;
}

/**
 * 创建渐变图层
 * @param colors 颜色数组
 * @param frame 渐变区域
 * @param locations 位置数组(可选)
 * @param startPoint 起点
 * @param endPoint 终点
 * @return 配置好的CAGradientLayer
 */
+ (CAGradientLayer *)yl_gradientLayerWithColors:(NSArray *)colors
                                        frame:(CGRect)frame
                                   locations:(NSArray *)locations
                                  startPoint:(CGPoint)startPoint
                                    endPoint:(CGPoint)endPoint {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    NSMutableArray *cgColors = [NSMutableArray arrayWithCapacity:colors.count];
    
    // 处理颜色数组
    for (id colorObj in colors) {
        if ([colorObj isKindOfClass:[UIColor class]]) {
            [cgColors addObject:(__bridge id)[(UIColor *)colorObj CGColor]];
        } else if (CFGetTypeID((__bridge CFTypeRef)colorObj) == CGColorGetTypeID()) {
            [cgColors addObject:colorObj];
        }
        // 忽略无效颜色对象
    }
    
    // 设置颜色
    gradientLayer.colors = cgColors;
    
    // 设置位置
    if (locations.count > 0 && locations.count == cgColors.count) {
        gradientLayer.locations = locations;
    } else {
        // 自动计算均匀分布的位置
        NSMutableArray *defaultLocations = [NSMutableArray arrayWithCapacity:cgColors.count];
        CGFloat step = 1.0f / (cgColors.count - 1);
        for (NSUInteger i = 0; i < cgColors.count; i++) {
            [defaultLocations addObject:@(i * step)];
        }
        gradientLayer.locations = defaultLocations;
    }
    
    // 设置起点、终点和frame
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame = frame;
    
    return gradientLayer;
}
@end
