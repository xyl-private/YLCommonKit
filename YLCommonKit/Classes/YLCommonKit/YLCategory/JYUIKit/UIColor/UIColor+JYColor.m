//
//  UIColor+JYColor.m
//  zhanye
//
//  Created by xyanl on 2017/11/26.
//  Copyright © 2017年 xyanl. All rights reserved.
//

#import "UIColor+JYColor.h"

static NSString * const colorStrPrefix1 = @"0X";
static NSString * const colorStrPrefix2 = @"#";

static const CGFloat redDivisor = 255;
static const CGFloat greenDivisor = 255;
static const CGFloat blueDivisor = 255;

static const CGFloat hueDivisor = 360;
static const CGFloat saturationDivisor = 100;
static const CGFloat brightnessDivisor = 100;

static const CGFloat whiteDivisor = 100;
static const CGFloat alphaDivisor = 100;

#define ADD_RED_MASK        0xFF0000
#define ADD_GREEN_MASK      0xFF00
#define ADD_BLUE_MASK       0xFF
#define ADD_ALPHA_MASK      0xFF000000
#define ADD_COLOR_SIZE      255.0
#define ADD_RED_SHIFT       16
#define ADD_GREEN_SHIFT     8
#define ADD_BLUE_SHIFT      0
#define ADD_ALPHA_SHIFT     24

#define JYC_RGBC         [UIColor clearColor]
#define JYC_RGBS(x,a)    [UIColor colorWithWhite:x/255.0f alpha:a]
#define JYC_HRGB(a)      [UIColor colorWithRGBHexString:a]
#define JYC_HRGBA(a)     [UIColor colorWithRGBAHexString:a]

#define JYC_kScreenWidth [UIScreen mainScreen].bounds.size.width
#define JYC_kScreenHeight [UIScreen mainScreen].bounds.size.height

#define COLOR(NAME, OBJECT) + (instancetype)NAME {\
static UIColor *_NAME;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_NAME = OBJECT;\
});\
return _NAME;\
}\


@implementation UIColor (JYColor)
/**
 *  十六进制颜色 - 不透明
 */
+ (UIColor *)yl_colorWithHexString:(NSString *)hexColor
{
    return [self yl_colorWithHexString:hexColor alpha:1.0f];
}

/**
 *  十六进制颜色 - 可透明
 */
+ (UIColor *)yl_colorWithHexString:(NSString *)hexColor alpha:(CGFloat)alpha
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

#pragma mark --
#pragma mark Grayscale
+ (instancetype)yl_colorWithIntegerWhite:(NSUInteger)white
{
    return [self yl_colorWithIntegerWhite:white
                                 alpha:alphaDivisor];
}

+ (instancetype)yl_colorWithIntegerWhite:(NSUInteger)white alpha:(NSUInteger)alpha
{
    return [self colorWithWhite:white/whiteDivisor
                          alpha:alpha/alphaDivisor];
}


#pragma mark --
#pragma mark RGB
+ (instancetype)yl_colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue
{
    return [self yl_colorWithIntegerRed:red
                               green:green
                                blue:blue
                               alpha:alphaDivisor];
}

+ (instancetype)yl_colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha
{
    return [self colorWithRed:red/redDivisor
                        green:green/greenDivisor
                         blue:blue/blueDivisor
                        alpha:alpha/alphaDivisor];
}


#pragma mark --
#pragma mark HSB
+ (instancetype)yl_colorWithIntegerHue:(NSUInteger)hue saturation:(NSUInteger)saturation brightness:(NSUInteger)brightness
{
    return [self yl_colorWithIntegerHue:hue
                          saturation:saturation
                          brightness:brightness
                               alpha:alphaDivisor];
}

+ (instancetype)yl_colorWithIntegerHue:(NSUInteger)hue saturation:(NSUInteger)saturation brightness:(NSUInteger)brightness alpha:(NSUInteger)alpha
{
    return [self colorWithHue:hue/hueDivisor
                   saturation:saturation/saturationDivisor
                   brightness:brightness/brightnessDivisor
                        alpha:alpha/alphaDivisor];
}


#pragma mark - 渐变色
+ (UIView *)yl_navBackgroudView{
    UIView *navBackgroudView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JYC_kScreenWidth, 64)];
    [navBackgroudView.layer addSublayer:[self yl_getGraduallyChangingColorLayerWithFrame:navBackgroudView.bounds]];
    return navBackgroudView;
}

+ (CAGradientLayer *)yl_getLockViewGraduallyChangingColorLayerWithFrame:(CGRect)frame{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[self yl_colorWithHexString:@"51CEBF"].CGColor, (__bridge id)[self yl_colorWithHexString:@"51B0F6"].CGColor, (__bridge id)[self yl_colorWithHexString:@"BF94FF"].CGColor];
    gradientLayer.locations = @[@0, @0.4, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = frame;
    return gradientLayer;
}
+ (CAGradientLayer *)yl_getGraduallyChangingColor:(NSArray *)colors locations:(NSArray *)locations frame:(CGRect)frame{
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
+ (CAGradientLayer *)yl_getGraduallyChangingColorLayerWithFrame:(CGRect)frame{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[self yl_colorWithHexString:@"51CEBF"].CGColor, (__bridge id)[self yl_colorWithHexString:@"51B0F6"].CGColor, (__bridge id)[self yl_colorWithHexString:@"BF94FF"].CGColor];
    gradientLayer.locations = @[@0, @0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = frame;
    return gradientLayer;
}
+ (CAGradientLayer *)yl_getSettingViewGraduallyChangingColorLayerWithFrame:(CGRect)frame
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[self yl_colorWithHexString:@"0C9BFF"].CGColor, (__bridge id)[self yl_colorWithHexString:@"4DA3FF"].CGColor];
    gradientLayer.locations = @[@0.3, @.7];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = frame;
    return gradientLayer;
}
+ (UIColor *)yl_lineColor{
    return [self yl_colorWithHexString:@"C9C8C9"];
}
+ (UIColor *)yl_blueTextColor{
    return [self yl_colorWithHexString:@"#4a90e2"];
}
+ (UIColor *)yl_textGrayColor{
    return [self yl_colorWithHexString:@"#9b9b9b"];
}







+ (instancetype)yl_colorWithRGBHexValue:(NSUInteger)rgbHexValue
{
    return [UIColor colorWithRed:((CGFloat)((rgbHexValue & ADD_RED_MASK) >> ADD_RED_SHIFT))/ADD_COLOR_SIZE
                           green:((CGFloat)((rgbHexValue & ADD_GREEN_MASK) >> ADD_GREEN_SHIFT))/ADD_COLOR_SIZE
                            blue:((CGFloat)((rgbHexValue & ADD_BLUE_MASK) >> ADD_BLUE_SHIFT))/ADD_COLOR_SIZE
                           alpha:1.0];
}

+ (instancetype)yl_colorWithRGBAHexValue:(NSUInteger)rgbaHexValue
{
    return [UIColor colorWithRed:((CGFloat)((rgbaHexValue & ADD_RED_MASK) >> ADD_RED_SHIFT))/ADD_COLOR_SIZE
                           green:((CGFloat)((rgbaHexValue & ADD_GREEN_MASK) >> ADD_GREEN_SHIFT))/ADD_COLOR_SIZE
                            blue:((CGFloat)((rgbaHexValue & ADD_BLUE_MASK) >> ADD_BLUE_SHIFT))/ADD_COLOR_SIZE
                           alpha:((CGFloat)((rgbaHexValue & ADD_ALPHA_MASK) >> ADD_ALPHA_SHIFT))/ADD_COLOR_SIZE];
}

+ (instancetype)yl_colorWithRGBHexString:(NSString*)rgbHexString
{
    NSUInteger rgbHexValue;
    
    NSScanner* scanner = [NSScanner scannerWithString:rgbHexString];
    BOOL successful = [scanner scanHexInt:(unsigned *)&rgbHexValue];
    
    if (!successful)
        return nil;
    
    return [self yl_colorWithRGBHexValue:rgbHexValue];
}

+ (instancetype)yl_colorWithRGBAHexString:(NSString*)rgbaHexString
{
    NSUInteger rgbHexValue;
    
    NSScanner *scanner = [NSScanner scannerWithString:rgbaHexString];
    BOOL successful = [scanner scanHexInt:(unsigned *)&rgbHexValue];
    
    if (!successful)
        return nil;
    
    return [self yl_colorWithRGBAHexValue:rgbHexValue];
}
+ (UIColor *)yl_colorWithHexColorString:(NSString *)hexColorString {
    if ([hexColorString length] <6) {//长度不合法
        return [UIColor blackColor];
    }
    NSString *tempString=[hexColorString lowercaseString];
    if ([tempString hasPrefix:@"0x"]) {//检查开头是0x
        tempString = [tempString substringFromIndex:2];
    }else if ([tempString hasPrefix:@"#"]) {//检查开头是#
        tempString = [tempString substringFromIndex:1];
    }
    if ([tempString length] !=6) {
        return [UIColor blackColor];
    }
    //分解三种颜色的值
    NSRange range;
    range.location =0;
    range.length =2;
    NSString *rString = [tempString substringWithRange:range];
    range.location =2;
    NSString *gString = [tempString substringWithRange:range];
    range.location =4;
    NSString *bString = [tempString substringWithRange:range];
    //取三种颜色值
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString]scanHexInt:&r];
    [[NSScanner scannerWithString:gString]scanHexInt:&g];
    [[NSScanner scannerWithString:bString]scanHexInt:&b];
    return [UIColor colorWithRed:((float) r /255.0f)
                           green:((float) g /255.0f)
                            blue:((float) b /255.0f)
                           alpha:1.0f];
}

- (BOOL)yl_getRGBHexValue:(NSUInteger*)rgbHex
{
    size_t numComponents = CGColorGetNumberOfComponents(self.CGColor);
    CGFloat const * components = CGColorGetComponents(self.CGColor);
    
    if (numComponents == 4){
        CGFloat rFloat = components[0]; // red
        CGFloat gFloat = components[1]; // green
        CGFloat bFloat = components[2]; // blue
        
        NSUInteger r = (NSUInteger)roundf(rFloat*ADD_COLOR_SIZE);
        NSUInteger g = (NSUInteger)roundf(gFloat*ADD_COLOR_SIZE);
        NSUInteger b = (NSUInteger)roundf(bFloat*ADD_COLOR_SIZE);
        
        *rgbHex = (r << ADD_RED_SHIFT) + (g << ADD_GREEN_SHIFT) + (b << ADD_BLUE_SHIFT);
        
        return YES;
    }
    else if (numComponents == 2){
        CGFloat gFloat = components[0]; // gray
        NSUInteger g = (NSUInteger)roundf(gFloat*ADD_COLOR_SIZE);
        *rgbHex = (g << ADD_RED_SHIFT) + (g << ADD_GREEN_SHIFT) + (g << ADD_BLUE_SHIFT);
        return YES;
    }
    
    return NO;
}

- (BOOL)yl_getRGBAHexValue:(NSUInteger*)rgbaHex;
{
    size_t numComponents = CGColorGetNumberOfComponents(self.CGColor);
    CGFloat const * components = CGColorGetComponents(self.CGColor);
    
    if (numComponents == 4){
        CGFloat rFloat = components[0]; // red
        CGFloat gFloat = components[1]; // green
        CGFloat bFloat = components[2]; // blue
        CGFloat aFloat = components[3]; // alpha
        
        NSUInteger r = (NSUInteger)roundf(rFloat*ADD_COLOR_SIZE);
        NSUInteger g = (NSUInteger)roundf(gFloat*ADD_COLOR_SIZE);
        NSUInteger b = (NSUInteger)roundf(bFloat*ADD_COLOR_SIZE);
        NSUInteger a = (NSUInteger)roundf(aFloat*ADD_COLOR_SIZE);
        
        *rgbaHex = (r << ADD_RED_SHIFT) + (g << ADD_GREEN_SHIFT) + (b << ADD_BLUE_SHIFT) + (a << ADD_ALPHA_SHIFT);
        
        return YES;
    }
    else if (numComponents == 2){
        CGFloat gFloat = components[0]; // gray
        CGFloat aFloat = components[1]; // alpha
        
        NSUInteger g = (NSUInteger)roundf(gFloat*ADD_COLOR_SIZE);
        NSUInteger a = (NSUInteger)roundf(aFloat *ADD_COLOR_SIZE);
        
        *rgbaHex = (g << ADD_RED_SHIFT) + (g << ADD_GREEN_SHIFT) + (g << ADD_BLUE_SHIFT) + (a << ADD_ALPHA_SHIFT);
        
        return YES;
    }
    
    return NO;
}

- (NSString*)yl_stringWithRGBHex
{
    NSUInteger value = 0;
    BOOL compatible = [self yl_getRGBHexValue:&value];
    
    if (!compatible)
        return nil;
    
    return [NSString stringWithFormat:@"%x", (unsigned)value];
}

- (NSString*)yl_stringWithRGBAHex
{
    NSUInteger value = 0;
    BOOL compatible = [self yl_getRGBAHexValue:&value];
    
    if (!compatible)
        return nil;
    
    return [NSString stringWithFormat:@"%x", (unsigned)value];
}
@end
