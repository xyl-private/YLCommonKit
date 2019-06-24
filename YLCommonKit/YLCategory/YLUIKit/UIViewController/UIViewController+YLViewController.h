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
 * 获取当前页面的控制器
 */
+ (UIViewController *) yl_getCurrentVC;
/**
 * 获取目标页面的控制器
 */
+ (UIViewController *) yl_getTargetVCWithVCCls:(Class)cls;


/**
 *  获得当前VC 获取当前处于activity状态的view controller
 *
 *  @return 返回当前VC
 */
+ (UIViewController *)yl_getActivityViewController;

/**
 *  获得顶级VC
 *
 *  @return 返回顶级VC
 */
+ (UIViewController *)yl_getAppRootViewController;
@end
