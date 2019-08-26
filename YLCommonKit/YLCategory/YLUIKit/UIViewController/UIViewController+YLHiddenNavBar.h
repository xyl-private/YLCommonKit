//
//  UIViewController+YLHiddenNavBar.h
//  YLCommonKit
//
//  Created by xyanl on 2019/8/26.
//  Copyright © 2019 xyanl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 //注意是 viewWillAppear 方法
 -(void)viewWillAppear:(BOOL)animated{
 [super viewWillAppear:animated];
 //设置代理即可  隐藏 navbar
 self.navigationController.delegate = self;
 }
 //设置代理即可  隐藏 navbar
 // 不隐藏 就不用做任何操作
 */
@interface UIViewController (YLHiddenNavBar)<UINavigationControllerDelegate>

@end

NS_ASSUME_NONNULL_END
