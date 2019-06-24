//
//  YLBaseViewController.m
//  YLCommonKit
//
//  Created by xyanl on 2018/8/8.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "YLBaseViewController.h"

#import "UIColor+YLColor.h"
@interface YLBaseViewController ()

@end

@implementation YLBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor yl_colorWithHexString:@"00FF00"];
}



#pragma mark 设置左右键
/**
 *  设置左侧按钮标题
 */
- (void)yl_setUpLeftNavItemWithTitle:(NSString *)title andAction:(SEL)action
{
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:self action:action];
    NSDictionary *att = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [leftBarButtonItem setTitleTextAttributes:att forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}
/**
 *  设置左侧按钮图片
 */
- (void)yl_setUpLeftNavItemWithImage:(UIImage *)image andAction:(SEL)action
{
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:action];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.navigationItem.leftBarButtonItem.imageInsets = UIEdgeInsetsMake(0, -5, 0, 0);
}
/**
 *  设置右侧按钮标题
 */
- (void)yl_setUpRightNavItemWithTitle:(NSString *)title andAction:(SEL)action
{
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:self action:action];
    NSDictionary *att = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [rightBarButtonItem setTitleTextAttributes:att forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
/**
 *  设置右侧按钮图片
 */
- (void)yl_setUpRightNavItemWithImage:(UIImage *)image andAction:(SEL)action
{
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:action];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
/**
 *  设置全局状态栏颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
/**
 * 测试是否释放
 */
- (void)dealloc
{
    NSLog(@"%@ -- dealloc", [self class]);
}


@end
