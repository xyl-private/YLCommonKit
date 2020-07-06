//
//  UIViewController+YLFullScreen.m
//  YLCommonKit
//
//  Created by xyanl on 2019/11/29.
//  Copyright © 2019 xyanl. All rights reserved.
//

#import "UIViewController+YLFullScreen.h"
#import <objc/runtime.h>

@implementation UIViewController (YLFullScreen)

//自动调的，不需要单独在导入头文件调用
+ (void)load {
    Method remove = class_getInstanceMethod([UIViewController class], @selector(presentViewController:animated:completion:));
    Method add = class_getInstanceMethod([self class], @selector(myPresentViewController:animated:completion:));
    method_exchangeImplementations(remove,add);
}

- (void)myPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    //设置满屏，不需要小卡片
    if(@available(iOS 13.0, *)) {
        viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self myPresentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
