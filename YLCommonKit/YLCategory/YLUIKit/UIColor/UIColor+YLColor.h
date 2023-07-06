//
//  UIColor+YLColor.h
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 渐变色方向
typedef NS_ENUM(NSInteger, YLGradientDirection) {
    /// 水平方向渐变(左->右)
    YLGradientDirectionHorizontal,
    /// 垂直方向渐变(上->下)
    YLGradientDirectionVertical,
    /// 主对角线方向渐变(左上角->右下角)
    YLGradientDirectionUpDiagonalLine,  
    /// 副对角线方向渐变(左下角->右上角)
    YLGradientDirectionDownDiagonalLine,
};

@interface UIColor (YLColor)

/// 十六进制颜色 - 不透明
/// - Parameter hexColor: 十六进制颜色
+ (UIColor *)yl_colorWithHexString:(NSString *)hexString;

/// 十六进制颜色 - 可透明
/// - Parameters:
///   - hexColor: 十六进制颜色
///   - alpha: 透明度
+ (UIColor *)yl_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

/// 重新设置颜色的透明度
/// - Parameter alpha: 透明度 0~1
- (UIColor *)alpha:(CGFloat)alpha;

/// 随机色
+ (UIColor *)yl_randomColor;

/// UIColor 转十六进制(6位:十六进制的颜色字符串  8位:十六进制+2位的透明度)
- (NSString *)yl_hexColor;

#pragma mark - 暗黑模式适配

/**
 * ⚠️⚠️ 这里我们需要特别注意，当模式发生变化的时候，只有在以下情况下才能监听模式发生了变化。⚠️⚠️
 * 第一：在UIView中 以下四个方法
 * draw();  
 * layoutSubview();  
 * traitCollectionDidChange();   
 * tintColorDidChange();
 *
 * 第二：在UIViewController中 以下三个方法中
 * viewWillLayoutSubviews();   
 * viewDidLayoutSubviews();     
 * traitCollectionDidChange();
 *
 * 第三：在UIPresentationController中 以下三个方法
 * containerViewWillLayoutSubviews();    
 * containerViewDidLayoutSubviews(); 
 * traitCollectionDidChange();
 */

/// 适配暗黑模式颜色
/// - Parameters:
///   - lightColor: 浅色模式颜色(UIColor或者NSString)
///   - darkColor: 深色模式颜色(UIColor或者NSString)
UIColor * YLDynamicColors(id lightColor, id darkColor);

/// 适配暗黑模式颜色
/// - Parameters:
///   - lightColor: 浅色模式颜色
///   - darkColor: 深色模式颜色
+ (UIColor *)yl_dynamicColorsWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;

#pragma mark - Gradient 渐变色

/// 渐变色
/// - Parameters:
///   - direction: 渐变色延伸方向
///   - colors: 颜色数组, 例: @[[UIColor redColor], [UIColor blackColor]] 或者 @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blackColor].CGColor] 两者都可以
///   - frame: view.bouns
+ (UIColor *)yl_gradientWithDirection:(YLGradientDirection)direction colors:(NSArray *)colors frame:(CGRect)frame;

/// 渐变色
/// - Parameters:
///   - direction: 渐变色延伸方向
///   - colors: 颜色数组, 例: @[[UIColor redColor], [UIColor blackColor]] 或者 @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blackColor].CGColor] 两者都可以
///   - frame: view.bouns
///   - locations: 渐变色区间,可为空,默认平均分配 @[@0, @1]
+ (UIColor *)yl_gradientWithDirection:(YLGradientDirection)direction colors:(NSArray *)colors frame:(CGRect)frame locations:(NSArray *)locations;

/// 渐变色
/// - Parameters:
///   - direction: 渐变色延伸方向
///   - colors: 颜色数组, 例: @[[UIColor redColor], [UIColor blackColor]] 或者 @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blackColor].CGColor] 两者都可以
///   - frame: view.bouns
///   - locations: 渐变色区间,可为空,默认平均分配 @[@0, @1]
///   - startPoint: 起始位置坐标 以左上角为起始位置 坐标(0,0) 右下角坐标(1,1)
///   - endPoint: 终止位置坐标
+ (UIColor *)yl_gradientWithColors:(NSArray *)colors frame:(CGRect)frame locations:(NSArray *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/// 渐变色
/// - Parameters:
///   - direction: 渐变色延伸方向
///   - colors: 颜色数组, 例: @[[UIColor redColor], [UIColor blackColor]] 或者 @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blackColor].CGColor] 两者都可以
///   - frame: view.bouns
///   - locations: 渐变色区间,可为空,默认平均分配 @[@0, @1]
///   - startPoint: 起始位置坐标 以左上角为起始位置 坐标(0,0) 右下角坐标(1,1)
///   - endPoint: 终止位置坐标
+ (CAGradientLayer *)yl_gradientLayerWithColors:(NSArray *)colors frame:(CGRect)frame locations:(NSArray *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end

NS_ASSUME_NONNULL_END
