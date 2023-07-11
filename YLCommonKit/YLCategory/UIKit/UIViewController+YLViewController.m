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

+ (instancetype)yl_controllerFromXib {
    return [[self alloc] initWithNibName:NSStringFromClass(self) bundle:nil];
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)yl_getCurrentVC {
    UIViewController *rootViewController = UIApplication.yl_keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
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

/// 获取目标页面的控制器
+ (UIViewController *)yl_getTargetVCWithVCCls:(Class)cls {
    UIViewController *rootViewController = UIApplication.yl_keyWindow.rootViewController;
    UIViewController *targetVC = [self getTargetVCFrom:rootViewController targetCls:cls];
    return targetVC;
}

+ (UIViewController *)yl_getTargetVCWithVCName:(NSString *)vcName{
    return [UIViewController yl_getTargetVCWithVCCls:[NSClassFromString(vcName) class]];
}

+ (UIViewController *)getTargetVCFrom:(UIViewController *)rootVC targetCls:(Class)cls {
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

/**
 * 获得当前VC 获取当前处于activity状态的view controller
 *
 * @return 返回当前VC
 */
+ (UIViewController *)yl_getActivityViewController {
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [UIApplication yl_keyWindow];
    if(window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows) {
            if(tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0) {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]]) {
            activityViewController = nextResponder;
        } else {
            activityViewController = window.rootViewController;
        }
    }
    
    return activityViewController;
}

/// 获得根控制器
+ (UIViewController *)yl_getAppRootViewController {
    UIViewController *appRootVC = UIApplication.yl_keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

@end
