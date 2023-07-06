//
//  UIView+YLView.h
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//
//  基础视图扩展
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YLView)

+ (instancetype)yl_viewFromXib;
/// 当前所在的 viewController
- (UIViewController *)yl_viewController;
/// 移除所有子视图
- (void)yl_removeAllSubviews;
///  添加背景图片
- (void)yl_setBackgroundImage:(UIImage *)image;

/// view 转换成 图片
- (UIImage*)yl_snapshotImage;
/// 监听键盘 改变 view 的位置
- (void)yl_observeKeyboardOnChange:(void(^)(CGFloat keyboardTop, CGFloat height))changeHandler;

#pragma mark - UIGestureRecognizer
/// 添加点击手势
/// - Parameters:
///   - target: target
///   - selector: selector
- (UITapGestureRecognizer *)yl_addTapGestureWithTarget:(id)target action:(nullable SEL)selector;
/// 添加长按手势
/// - Parameters:
///   - target: target
///   - selector: selector
- (UILongPressGestureRecognizer *)yl_addLongPressGestureWithTarget:(id)target action:(nullable SEL)selector;
/// 添加拖拽手势
/// - Parameters:
///   - target: target
///   - selector: selector
- (UIPanGestureRecognizer *)yl_addPanGestureWithTarget:(id)target action:(nullable SEL)selector;

#pragma mark - 圆角

/// 添加圆角 (绝对布局)
/// - Parameters:
///   - corners: 需要设置为圆角的角
///   - cornerRadius: 圆角半径
- (void)yl_addRoundedCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius;

/// 设置部分圆角(绝对布局)
/// - Parameters:
///   - corners: 需要设置为圆角的角
///   - cornerRadii: 需要设置的圆角半径 例如 CGSizeMake(20.0f, 20.0f)
- (void)yl_addRoundedCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

/// 设置部分圆角(相对布局)
/// - Parameters:
///   - corners: 需要设置为圆角的角
///   - cornerRadii: 需要设置的圆角半径 例如 CGSizeMake(20.0f, 20.0f)
///   - frame: 需要设置的圆角view的frame
- (void)yl_addRoundedCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii frame:(CGRect)frame;

/// 添加圆角
/// - Parameters:
///   - cornerRadius: 圆角半径
- (void)yl_addLayerRoundedCorners:(CGFloat)cornerRadius;

/// 添加外环线
/// - Parameters:
///   - cornerRadius 圆角半径
///   - borderWidth 线宽度
///   - borderColor 线颜色
- (void)yl_addLayerRoundedCorners:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end

NS_ASSUME_NONNULL_END
