//
//  YLBaseNavigationController.m
//  YLCommonKit
//
//  Created by xyanl on 2018/8/8.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "YLBaseNavigationController.h"
#import "UIColor+YLColor.h"
#import "UIImage+YLImage.h"

@interface YLBaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation YLBaseNavigationController


#pragma mark - 初始化设置
+ (void)initialize
{
    UINavigationBar *navBar;
    if (@available(iOS 9.0, *)) {
        navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
#pragma clang diagnostic pop
    }
    // 设置导航栏标题颜色
    NSMutableDictionary *navBarAttrs = [NSMutableDictionary dictionary];
    navBarAttrs[NSForegroundColorAttributeName] = [UIColor yl_colorWithHexString:@"FFFFFF"];
    navBarAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [navBar setTitleTextAttributes:navBarAttrs];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加返回手势
    // self.interactivePopGestureRecognizer.delegate = self;
    // 设置导航栏背景图
    [self.navigationBar setBackgroundImage:[UIImage yl_imageWithColor:[UIColor yl_colorWithHexString:@"2772FF"]] forBarMetrics:UIBarMetricsDefault];
}
/**
 *  设置全局状态栏颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 重写PUSH方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        // 隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage yl_imageWithRenderingImage:@"icon_navBack"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
        viewController.navigationItem.leftBarButtonItem.imageInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UIGestureRecognizerDelegate
// 实现代理方法:如果不是第一个控制器就可以滑动
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 手势何时有效 : 当导航控制器的子控制器个数 > 1就有效
    return self.childViewControllers.count > 1;
}

// 解决系统返回手势与scrollView滑动手势冲突问题
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // 首先判断响应gestureRecognizer的view是不是系统UILayoutContainerView
    if ([gestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
        // 如果otherGestureRecognizer的响应者是UIScrollView，
        // 再判断otherGestureRecognizer的state是began，
        // 同时判断scrollView的位置是不是正好在最左边
        // 满足条件即可实现返回手势
        if ([otherGestureRecognizer.view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)otherGestureRecognizer.view;
            if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && scrollView.contentOffset.x == 0) {
                return YES;
            }
        }
    }
    return NO;
}

#pragma mark - 返回按钮
- (void)back
{
    [self popViewControllerAnimated:YES];
}

// 重写系统方法,恢复手势响应
- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    self.interactivePopGestureRecognizer.enabled = YES;
    return  [super popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.interactivePopGestureRecognizer.enabled = YES;
    return [super popToViewController:viewController animated:animated];
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    self.interactivePopGestureRecognizer.enabled = YES;
    return [super popViewControllerAnimated:animated];
}


@end
