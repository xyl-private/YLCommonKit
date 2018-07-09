//
//  UIViewController+JYHelper.m
//  Zhanye
//
//  Created by xyanl on 2018/3/2.
//  Copyright © 2018年 JieyueUnion. All rights reserved.
//

#import "UIViewController+JYHelper.h"

@implementation UIViewController (JYHelper)
/**
 * 获取当前页面的控制器
 */
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)yl_getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}
/**
 * 获取目标页面的控制器
 */
+ (UIViewController *)yl_getTargetVCWithVCCls:(Class)cls
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *targetVC = [self getTargetVCFrom:rootViewController targetCls:cls];
    return targetVC;
}

+ (UIViewController *)getTargetVCFrom:(UIViewController *)rootVC targetCls:(Class)cls
{
    __block UIViewController *targetVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        targetVC = [self getTargetVCFrom:[(UITabBarController *)rootVC selectedViewController] targetCls:cls];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        [rootVC.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:cls]) {
                targetVC = obj;
                *stop = YES;
            }
        }];
    } else {
        // 根视图为非导航类
        targetVC = rootVC;
    }
    
    return targetVC;
}

@end
