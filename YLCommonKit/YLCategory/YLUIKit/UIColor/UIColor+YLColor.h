//
//  UIColor+YLColor.h
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YLColor)

/// 十六进制颜色 - 不透明
+ (UIColor *) yl_colorWithHexString:(NSString *)hexColor;

/// 十六进制颜色 - 可透明
+ (UIColor *) yl_colorWithHexString:(NSString *)hexColor alpha:(CGFloat)alpha;

/// 随机色
+ (UIColor *)yl_randomColor;


/**
 *  设置渐变色 默认从左向右 横向渐变
 *  @param colors 颜色数组,
 *  例:@[[UIColor redColor],[UIColor blackColor]] 或者
 *  @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor blackColor].CGColor] 两者都可以
 *  @param locations 渐变色区间,0~1,可为空,默认平均分配
 *  @param frame view.bouns
 */
+ (CAGradientLayer *)yl_setGradientLayerVerticallyWithColors:(NSArray *)colors
                                                   locations:(NSArray *)locations
                                                       frame:(CGRect)frame;

/**
 *  设置渐变色 默认从上向下 纵向渐变
 *  @param colors 颜色数组,
 *  例:@[[UIColor redColor],[UIColor blackColor]] 或者
 *  @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor blackColor].CGColor] 两者都可以
 *  @param locations 渐变色区间,可为空,默认平均分配
 *  @param frame view.bouns
 */
+ (CAGradientLayer *)yl_setGradientLayerHorizontalWithColors:(NSArray *)colors
                                                   locations:(NSArray *)locations
                                                       frame:(CGRect)frame;

/**
 *  设置渐变色
 *  @param colors 颜色数组,
 *  例:@[[UIColor redColor],[UIColor blackColor]] 或者
 *  @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor blackColor].CGColor] 两者都可以
 *  @param locations 渐变色区间,0~1,可为空,默认平均分配
 *  @param frame view.bouns
 *  @param startPoint  起始位置坐标 以左上角为起始位置 坐标(0,0) 右下角坐标(1,1)
 *  @param endPoint 终止位置坐标
 */
+ (CAGradientLayer *)yl_setGradientLayerWithColors:(NSArray *)colors
                                         locations:(NSArray *)locations
                                             frame:(CGRect)frame
                                        startPoint:(CGPoint)startPoint
                                          endPoint:(CGPoint)endPoint;

@end
