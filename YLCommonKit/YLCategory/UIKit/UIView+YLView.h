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

/**
 * 从与当前类同名的 xib 文件加载视图
 *
 * @return 新创建的视图实例，如果加载失败则返回 nil
 */
+ (instancetype)yl_viewFromNib;

/**
 * 通过遍历响应者链，查找并返回当前视图所属的视图控制器。
 * 此方法利用UIResponder的nextResponder属性向上查找，直到找到UIViewController实例。
 *
 * @return 当前视图所属的视图控制器，如果未找到则返回nil。
 */
- (UIViewController *)yl_viewController;

/// 移除所有子视图
- (void)yl_removeAllSubviews;

/// view 转换成 图片
- (UIImage*)yl_snapshotImage;


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

#pragma mark - 监听键盘

/**
 * @method yl_observeKeyboardOnChange:
 * @brief 注册一个键盘帧变化通知的观察者
 * @discussion 该方法通过监听系统发出的 `UIKeyboardWillChangeFrameNotification` 通知，
 *              在键盘的frame即将发生变化时（包括显示、隐藏、大小改变、位置改变等）执行回调。
 *              回调中提供了键盘最终的顶部Y坐标和高度信息，便于调用者调整UI布局，避免键盘遮挡。
 *              该方法内部会自动处理通知的注册、线程安全、动画同步及观察者的存储，确保与键盘动画同步更新UI。
 *              注意：返回的观察者对象必须被强引用持有，并在适当时机（如视图控制器销毁时）调用 `removeObserver:` 方法移除，以避免内存泄漏。
 *
 * @param changeHandler 当键盘帧变化时执行的回调块
 *                      - keyboardTop: 键盘最终的顶部Y坐标（在屏幕坐标系中）
 *                      - height: 键盘的最终高度
 * @return 注册的键盘通知观察者对象（类型为 `id`），需要由调用者管理其生命周期，或在不再需要时使用 `yl_removeKeyboardObserver:` 移除。
 * @warning 务必在视图控制器或持有该观察者的对象销毁前移除观察者，否则可能导致内存泄漏或不可预期的行为。
 */
- (id)yl_observeKeyboardOnChange:(void (^)(CGFloat keyboardTop, CGFloat height))changeHandler;

+ (void)yl_removeKeyboardObserver:(id)observer;

- (void)yl_removeAllKeyboardObservers;
    
@end

NS_ASSUME_NONNULL_END
