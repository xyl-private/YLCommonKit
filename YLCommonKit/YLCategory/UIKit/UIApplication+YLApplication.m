//
//  UIApplication+YLApplication.m
//  YLCommonKit
//
//  Created by xyanl on 2023/5/19.
//  Copyright © 2023 xyanl. All rights reserved.
//

#import "UIApplication+YLApplication.h"

@implementation UIApplication (YLApplication)

/**
 * 获取当前应用的 keyWindow
 * 兼容 iOS 13+ 多窗口场景和旧版本系统
 *
 * @return 当前活动的 keyWindow，如果没有则返回 nil
 */
+ (UIWindow *)yl_keyWindow {
    UIWindow *keyWindow = nil;
    
    // iOS 13+ 多窗口场景处理
    if (@available(iOS 13.0, *)) {
        NSSet<UIScene *> *connectedScenes = [UIApplication sharedApplication].connectedScenes;
        for (UIScene *scene in connectedScenes) {
            if (![scene isKindOfClass:[UIWindowScene class]]) {
                continue;
            }
            
            UIWindowScene *windowScene = (UIWindowScene *)scene;
            
            // 检查场景是否处于前台（活跃或非活跃状态）
            BOOL isForeground = (windowScene.activationState == UISceneActivationStateForegroundActive ||
                                 windowScene.activationState == UISceneActivationStateForegroundInactive);
            
            if (!isForeground) {
                continue;
            }
            
            // iOS 15+ 直接使用 keyWindow 属性
            if (@available(iOS 15.0, *)) {
                keyWindow = windowScene.keyWindow;
                if (keyWindow) {
                    return keyWindow;
                }
            }
            
            // iOS 13-14 遍历查找 keyWindow
            for (UIWindow *window in windowScene.windows) {
                if (window.isKeyWindow) {
                    return window;
                }
                
                // 如果没有明确 keyWindow，返回第一个符合条件的窗口
                if (window.windowLevel == UIWindowLevelNormal && window.isHidden == NO) {
                    keyWindow = window;
                }
            }
        }
    } else { // iOS 12 及以下版本处理
        // 去掉警告的宏
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"// 找到警告的类型
        keyWindow = [UIApplication sharedApplication].keyWindow;
        //被警告的代码
#pragma clang diagnostic pop
    }
    
    
    // 最终回退方案
    if (keyWindow == nil) {
        keyWindow = [UIApplication sharedApplication].windows.firstObject;
    }
    
    return keyWindow;
}

@end
