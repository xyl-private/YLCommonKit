//
//  UIApplication+YLApplication.h
//  YLCommonKit
//
//  Created by xyanl on 2023/5/19.
//  Copyright © 2023 xyanl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (YLApplication)

/**
 * 获取当前应用的 keyWindow
 * 兼容 iOS 13+ 多窗口场景和旧版本系统
 *
 * @return 当前活动的 keyWindow，如果没有则返回 nil
 */
+ (UIWindow *)yl_keyWindow;

@end

NS_ASSUME_NONNULL_END
