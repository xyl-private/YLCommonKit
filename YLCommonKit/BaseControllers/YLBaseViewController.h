//
//  YLBaseViewController.h
//  YLCommonKit
//
//  Created by xyanl on 2018/8/8.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLBaseViewController : UIViewController

/**
 *  设置左侧按钮标题
 */
- (void)yl_setUpLeftNavItemWithTitle:(NSString *)title andAction:(SEL)action;

/**
 *  设置左侧按钮图片
 */
- (void)yl_setUpLeftNavItemWithImage:(UIImage *)image andAction:(SEL)action;

/**
 *  设置右侧按钮标题
 */
- (void)yl_setUpRightNavItemWithTitle:(NSString *)title andAction:(SEL)action;

/**
 *  设置右侧按钮图片
 */
- (void)yl_setUpRightNavItemWithImage:(UIImage *)image andAction:(SEL)action;

@end
