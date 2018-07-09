//
//  UIViewController+JYHelper.h
//  YLCommonKit
//
//  Created by xyanl on 2018/3/2.
//  Copyright © 2018年 JieyueUnion. All rights reserved.
//  基础控制器扩展

#import <UIKit/UIKit.h>

@interface UIViewController (JYHelper)
/**
 * 获取当前页面的控制器
 */
+ (UIViewController *)yl_getCurrentVC;
/**
 * 获取目标页面的控制器
 */
+ (UIViewController *)yl_getTargetVCWithVCCls:(Class)cls;

@end
