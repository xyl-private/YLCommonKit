//
//  UIColor+YLColor.h
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YLColor)

/**
 *  十六进制颜色 - 不透明
 */
+ (UIColor *) yl_colorWithHexString:(NSString *)hexColor;

/**
 *  十六进制颜色 - 可透明
 */
+ (UIColor *) yl_colorWithHexString:(NSString *)hexColor alpha:(CGFloat)alpha;

/**
 获取渐变色Layer
 
 @param colors 颜色值 [UIcolor]
 @param locations 渐变色位置 总长度为1
 @param frame frame
 @return CAGradientLayer
 */
+ (CAGradientLayer *) yl_getGraduallyChangingColor:(NSArray *)colors locations:(NSArray *)locations frame:(CGRect)frame;

@end
