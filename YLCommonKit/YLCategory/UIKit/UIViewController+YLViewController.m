//
//  UIViewController+YLViewController.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "UIViewController+YLViewController.h"
#import "UIApplication+YLApplication.h"

@implementation UIViewController (YLViewController)

/**
 * 从与当前类同名的 xib 文件初始化控制器实例。
 * 如果找不到对应的 xib 文件，返回 nil 并输出警告日志。
 *
 * @return 新创建的控制器实例，如果 xib 文件不存在则返回 nil。
 */
+ (instancetype)yl_controllerFromNib {
    NSString *nibName = NSStringFromClass(self);
    NSBundle *bundle = [NSBundle bundleForClass:self];
    
    if (![bundle pathForResource:nibName ofType:@"nib"]) {
        NSLog(@"⚠️ Warning: Could not find nib file named '%@' in bundle", nibName);
        return nil;
    }
    
    return [[self alloc] initWithNibName:nibName bundle:bundle];
}

/**
 * 获取当前屏幕最顶层的可见视图控制器
 * 会从 keyWindow 的 rootViewController 开始查找
 *
 * @return 当前最顶层的可见视图控制器，如果没有 keyWindow 或 rootViewController 则返回 nil
 */
+ (UIViewController *)yl_currentViewController {
    // 1. 获取 keyWindow（兼容 iOS 13+ 多场景情况）
    UIWindow *keyWindow = UIApplication.yl_keyWindow;
    if (keyWindow == nil) {
        NSLog(@"⚠️ Warning: No key window available");
        return nil;
    }
    
    // 2. 检查 rootViewController
    UIViewController *rootViewController = keyWindow.rootViewController;
    if (rootViewController == nil) {
        NSLog(@"⚠️ Warning: Key window has no root view controller");
        return nil;
    }
    
    // 3. 查找顶层视图控制器
    return [self yl_topmostViewControllerFrom:rootViewController];
}

/**
 * 获取给定视图控制器层级中的当前活跃视图控制器
 *
 * @param rootViewController 查找的起始视图控制器
 * @return 当前最顶层的可见视图控制器
 */
+ (UIViewController *)yl_topmostViewControllerFrom:(UIViewController *)rootViewController {
    // 1. 处理 presented 视图控制器
    while (rootViewController.presentedViewController != nil) {
        rootViewController = rootViewController.presentedViewController;
    }
    
    // 2. 根据不同类型处理
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self yl_topmostViewControllerFrom:tabBarController.selectedViewController];
    }
    else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        return [self yl_topmostViewControllerFrom:navigationController.visibleViewController];
    }
    
    // 3. 普通视图控制器直接返回
    return rootViewController;
}

/**
 * 在应用当前视图层级中查找指定类型的视图控制器
 * 从 keyWindow 的 rootViewController 开始搜索
 *
 * @param targetClass 要查找的目标视图控制器类
 * @return 找到的第一个匹配类型的视图控制器，如果没有找到或参数无效则返回 nil
 */
+ (UIViewController *)yl_findViewControllerOfClass:(Class)targetClass {
    // 1. 参数检查
    if (targetClass == nil) {
        NSLog(@"⚠️ Warning: Target class is nil when finding view controller");
        return nil;
    }
    
    // 2. 获取有效的 rootViewController
    UIWindow *keyWindow = UIApplication.yl_keyWindow;
    if (keyWindow == nil) {
        NSLog(@"⚠️ Warning: No key window available when finding view controller");
        return nil;
    }
    
    UIViewController *rootViewController = keyWindow.rootViewController;
    if (rootViewController == nil) {
        NSLog(@"⚠️ Warning: Key window has no root view controller");
        return nil;
    }
    
    // 3. 执行搜索
    return [self yl_findViewControllerOfClass:targetClass fromViewController:rootViewController];
}

/**
 * 通过类名字符串查找视图控制器
 * 从 keyWindow 的 rootViewController 开始搜索
 *
 * @param className 要查找的目标视图控制器类名
 * @return 找到的第一个匹配类型的视图控制器，如果类名无效或找不到则返回 nil
 */
+ (UIViewController *)yl_findViewControllerWithClassName:(NSString *)className {
    // 1. 参数检查
    if (className.length == 0) {
        NSLog(@"⚠️ Warning: Empty class name when finding view controller");
        return nil;
    }
    
    // 2. 获取类对象
    Class targetClass = NSClassFromString(className);
    if (targetClass == nil) {
        NSLog(@"⚠️ Warning: Invalid class name '%@' when finding view controller", className);
        return nil;
    }
    
    // 3. 使用类查找方法
    return [self yl_findViewControllerOfClass:targetClass];
}


/**
 * 在视图控制器层级中查找指定类型的视图控制器
 *
 * @param rootViewController 查找的起始视图控制器
 * @param targetClass 要查找的目标视图控制器类
 * @return 找到的第一个匹配类型的视图控制器，如果没有找到则返回 nil
 */
+ (UIViewController *)yl_findViewControllerOfClass:(Class)targetClass
                                fromViewController:(UIViewController *)rootViewController {
    if (rootViewController == nil || targetClass == nil) {
        return nil;
    }
    
    // 处理 presented 视图控制器
    if (rootViewController.presentedViewController != nil) {
        UIViewController *result = [self yl_findViewControllerOfClass:targetClass
                                                   fromViewController:rootViewController.presentedViewController];
        if (result != nil) {
            return result;
        }
    }
    
    // 处理 UITabBarController
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self yl_findViewControllerOfClass:targetClass
                              fromViewController:tabBarController.selectedViewController];
    }
    
    // 处理 UINavigationController
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        for (UIViewController *viewController in navigationController.viewControllers) {
            if ([viewController isKindOfClass:targetClass]) {
                return viewController;
            }
        }
    }
    
    // 检查当前视图控制器是否匹配
    if ([rootViewController isKindOfClass:targetClass]) {
        return rootViewController;
    }
    
    // 检查子视图控制器
    for (UIViewController *childViewController in rootViewController.childViewControllers) {
        UIViewController *result = [self yl_findViewControllerOfClass:targetClass
                                                  fromViewController:childViewController];
        if (result != nil) {
            return result;
        }
    }
    
    return nil;
}


@end
