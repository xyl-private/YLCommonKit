//
//  UIViewController+YLViewController.h
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (YLViewController)

/// 获取当前页面的控制器
+ (UIViewController *) yl_getCurrentVC;

/// 获取目标页面的控制器
+ (UIViewController *) yl_getTargetVCWithVCCls:(Class)cls;
+ (UIViewController *) yl_getTargetVCWithVCName:(NSString *)vcName;

/// 获得当前VC 获取当前处于activity状态的view controller
+ (UIViewController *)yl_getActivityViewController;

/// 获得顶级VC
+ (UIViewController *)yl_getAppRootViewController;
@end
