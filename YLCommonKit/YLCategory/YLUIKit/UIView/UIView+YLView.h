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

+ (UIWindow *)yl_keyWindow;

+ (instancetype)yl_viewFromXib;
/// 当前所在的 viewController
- (UIViewController *)yl_viewController;
/// 移除所有子视图
- (void)yl_removeAllSubviews;
///  添加背景图片
- (void)yl_setBackgroundImage:(UIImage *)image;

/// view 转换成 图片
- (UIImage*) yl_snapshotImage;
/// 监听键盘 改变 view 的位置
- (void)yl_observeKeyboardOnChange:(void(^)(CGFloat keyboardTop, CGFloat height))changeHandler;

#pragma mark - UIGestureRecognizer
/// 添加点击手势
- (UITapGestureRecognizer *)yl_addTapGestureWithTarget:(id)target action:(nullable SEL)selector;
/// 添加长按手势
- (UILongPressGestureRecognizer *)yl_addLongPressGestureWithTarget:(id)target action:(nullable SEL)selector;
/// 添加拖拽手势
- (UIPanGestureRecognizer *)yl_addPanGestureWithTarget:(id)target action:(nullable SEL)selector;

#pragma mark - 圆角

+ (CAShapeLayer *)yl_viewClipRect:(CGRect)viewRect rectCorner:(UIRectCorner)rectCorner cornerRadii:(CGSize)cornerRadii;

/// 设置部分圆角(绝对布局)
/// @param corners 圆角的位置
/// @param cornerRadii 需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
- (void)yl_addRoundedCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

/// 设置部分圆角(相对布局)
/// @param corners 圆角的位置
/// @param cornerRadii 需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
/// @param viewRect 需要设置的圆角view的rect
- (void)yl_addRoundedCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii viewRect:(CGRect)viewRect;

- (void)yl_addLayerRoundedCorners:(CGFloat)cornerRadius;

- (void)yl_addLayerRoundedCorners:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

#pragma mark - Frame
/// x
@property (nonatomic, assign) CGFloat yl_x;
/// y
@property (nonatomic, assign) CGFloat yl_y;
/// 宽度
@property (nonatomic, assign) CGFloat yl_width;
/// 高度
@property (nonatomic, assign) CGFloat yl_height;
/// centerX
@property (nonatomic, assign) CGFloat yl_centerX;
/// centerY
@property (nonatomic, assign) CGFloat yl_centerY;
/// size
@property (nonatomic, assign) CGSize  yl_size;
/// point
@property (nonatomic, assign) CGPoint yl_origin;
/// right
@property (nonatomic, assign) CGFloat yl_right;
/// bottom
@property (nonatomic, assign) CGFloat yl_bottom;

@end

NS_ASSUME_NONNULL_END
