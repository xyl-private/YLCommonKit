//
//  UIViewController+YLViewController.h
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (YLViewController)

/**
 * 从与当前类同名的 xib 文件初始化控制器实例。
 * 如果找不到对应的 xib 文件，返回 nil 并输出警告日志。
 *
 * @return 新创建的控制器实例，如果 xib 文件不存在则返回 nil。
 */
+ (instancetype)yl_controllerFromNib;

/**
 * 获取当前屏幕最顶层的可见视图控制器
 * 会从 keyWindow 的 rootViewController 开始查找
 *
 * @return 当前最顶层的可见视图控制器，如果没有 keyWindow 或 rootViewController 则返回 nil
 */
+ (UIViewController *)yl_currentViewController;

/**
 * 在应用当前视图层级中查找指定类型的视图控制器
 * 从 keyWindow 的 rootViewController 开始搜索
 *
 * @param targetClass 要查找的目标视图控制器类
 * @return 找到的第一个匹配类型的视图控制器，如果没有找到或参数无效则返回 nil
 */
+ (UIViewController *)yl_findViewControllerOfClass:(Class)targetClass;

/**
 * 通过类名字符串查找视图控制器
 * 从 keyWindow 的 rootViewController 开始搜索
 *
 * @param className 要查找的目标视图控制器类名
 * @return 找到的第一个匹配类型的视图控制器，如果类名无效或找不到则返回 nil
 */
+ (UIViewController *)yl_findViewControllerWithClassName:(NSString *)className;

@end
