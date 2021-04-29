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

/// Returns the view's view controller (may be nil).
@property (nullable, nonatomic, readonly) UIViewController *viewController;

/// 获取 view 所在的 viewController
- (UIViewController *)yl_viewController;
/// 删除所有Views
- (void) yl_removeAllSubviews;
/// 初始化 xib view
+ (instancetype)yl_viewFromXib;

/// 给 view 添加背景图片
- (void)yl_setBackgroundImage:(UIImage *)image;
/// 监听键盘 改变 view 的位置
- (void)yl_observeKeyboardOnChange:(void(^)(CGFloat keyboardTop, CGFloat height))changeHandler;
/// view 转换成 图片
- (UIImage*)yl_snapshotImage;


#pragma mark - 圆角
/// view 切圆角
/// @param viewRect view.frame
/// @param rectCorner  圆角的位置
/// @param cornerRadii 圆角 的 半径
+ (CAShapeLayer *)yl_viewClipRect:(CGRect)viewRect
                       rectCorner:(UIRectCorner)rectCorner
                      cornerRadii:(CGSize)cornerRadii;
/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param cornerRadii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)yl_addRoundedCorners:(UIRectCorner)corners
                 cornerRadii:(CGSize)cornerRadii;
/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param cornerRadii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param viewRect    需要设置的圆角view的rect
 */
- (void)yl_addRoundedCorners:(UIRectCorner)corners
                 cornerRadii:(CGSize)cornerRadii
                    viewRect:(CGRect)viewRect;
/// layer 切圆角
- (void)yl_addLayerRoundedCorners:(CGFloat)cornerRadius;
/// layer 圆角+边界线
/// @param cornerRadius 圆角
/// @param borderWidth 边界线宽度
/// @param borderColor 边界线颜色
- (void)yl_addLayerRoundedCorners:(CGFloat)cornerRadius
                      borderWidth:(UIRectCorner)borderWidth
                      borderColor:(UIColor *)borderColor;

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
