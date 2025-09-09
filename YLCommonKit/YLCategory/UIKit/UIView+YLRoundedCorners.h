//
//  UIView+YLRoundedCorners.h
//  YLCommonKit
//
//  Created by xyanl on 2025/9/9.
//  Copyright © 2025 xyanl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (RoundedCorners)

#pragma mark - 圆角

/**
 * 为视图添加指定圆角
 * @param corners 需要添加圆角的位置（可组合使用）
 * @param cornerRadii 圆角半径（宽度和高度）
 */
- (void)yl_addRoundedCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

/**
 * 为视图添加指定圆角（指定frame）
 * @param corners 需要添加圆角的位置
 * @param cornerRadii 圆角半径
 * @param frame 应用圆角的frame
 */
- (void)yl_addRoundedCorners:(UIRectCorner)corners
                 cornerRadii:(CGSize)cornerRadii
                       frame:(CGRect)frame;

/**
 * 为视图添加指定圆角（带动画效果）
 * @param corners 圆角位置
 * @param cornerRadii 圆角半径
 * @param duration 动画时长
 */
- (void)yl_addRoundedCorners:(UIRectCorner)corners
                 cornerRadii:(CGSize)cornerRadii
           animationDuration:(NSTimeInterval)duration;

/**
 * 移除所有圆角效果
 */
- (void)yl_removeRoundedCorners;

/**
 * 检查是否已添加圆角
 */
- (BOOL)yl_hasRoundedCorners;

/// 为视图设置自定义圆角
/// - Parameters:
///   - topLeft: 左上角半径
///   - topRight: 右上角半径
///   - bottomLeft: 左下角半径
///   - bottomRight: 右下角半径
- (void)yl_addCornerRadiusWithTopLeft:(CGFloat)topLeft
                             topRight:(CGFloat)topRight
                           bottomLeft:(CGFloat)bottomLeft
                          bottomRight:(CGFloat)bottomRight;

#pragma mark - 边框

- (void)yl_addLayerRoundedCorners:(CGFloat)cornerRadius
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor;

// 添加圆角和边框（支持动画）
- (void)yl_addLayerRoundedCorners:(CGFloat)cornerRadius
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                        animation:(BOOL)animated
                         duration:(NSTimeInterval)duration;

// 移除圆角和边框
- (void)yl_removeLayerRoundedCorners;


@end

NS_ASSUME_NONNULL_END
