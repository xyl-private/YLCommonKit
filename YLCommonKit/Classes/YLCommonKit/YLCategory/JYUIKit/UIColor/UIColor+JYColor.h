//
//  UIColor+JYColor.h
//  zhanye
//
//  Created by xyanl on 2017/11/26.
//  Copyright © 2017年 xyanl. All rights reserved.
//  颜色扩展

#import <UIKit/UIKit.h>

@interface UIColor (JYColor)
/**
 *  十六进制颜色 - 不透明
 */
+ (UIColor *)yl_colorWithHexString:(NSString *)hexColor;
/**
 *  十六进制颜色 - 可透明
 */
+ (UIColor *)yl_colorWithHexString:(NSString *)hexColor alpha:(CGFloat)alpha;


+ (instancetype)yl_colorWithIntegerWhite:(NSUInteger)white;
+ (instancetype)yl_colorWithIntegerWhite:(NSUInteger)white alpha:(NSUInteger)alpha;

+ (instancetype)yl_colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue;
+ (instancetype)yl_colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha;

+ (instancetype)yl_colorWithIntegerHue:(NSUInteger)hue saturation:(NSUInteger)saturation brightness:(NSUInteger)brightness;
+ (instancetype)yl_colorWithIntegerHue:(NSUInteger)hue saturation:(NSUInteger)saturation brightness:(NSUInteger)brightness alpha:(NSUInteger)alpha;


/**
 导航栏下的背景颜色
 */
+(UIView *)yl_navBackgroudView;
/**
 手势解锁界面
 
 @param frame 手势解锁的渐变layer
 @return 渐变色的layer
 */
+ (CAGradientLayer *)yl_getLockViewGraduallyChangingColorLayerWithFrame:(CGRect)frame;
/**
 设置渐变色
 
 @param frame 渐变的layer大小
 @return 渐变色的layer
 */
+ (CAGradientLayer *)yl_getGraduallyChangingColorLayerWithFrame:(CGRect)frame;

/**
 获取渐变色Layer
 
 @param colors 颜色值 [UIcolor]
 @param locations 渐变色位置 总长度为1
 @param frame frame
 @return CAGradientLayer
 */
+ (CAGradientLayer *)yl_getGraduallyChangingColor:(NSArray *)colors locations:(NSArray *)locations frame:(CGRect)frame;
/**
 设置侧滑界面的渐变色
 
 @param frame 渐变的layer大小
 @return 渐变色的layer
 */
+ (CAGradientLayer *)yl_getSettingViewGraduallyChangingColorLayerWithFrame:(CGRect)frame;

/**
 蓝色字体颜色
 */
+ (UIColor *) yl_blueTextColor;
/**
 灰色颜色字体
 */
+ (UIColor *) yl_textGrayColor;
/**
 线的颜色
 
 @return 线的颜色
 */
+ (UIColor *) yl_lineColor;

+ (instancetype)yl_colorWithRGBHexValue:(NSUInteger)rgbHexValue;
+ (instancetype)yl_colorWithRGBAHexValue:(NSUInteger)rgbaHexValue;
+ (instancetype)yl_colorWithRGBHexString:(NSString*)rgbHexString;
+ (instancetype)yl_colorWithRGBAHexString:(NSString*)rgbaHexString;
+ (UIColor *)yl_colorWithHexColorString:(NSString *)hexColorString;
- (NSString*)yl_stringWithRGBHex;
- (NSString*)yl_stringWithRGBAHex;
@end
