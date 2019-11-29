//
//  UIViewController+YLFullScreen.m
//  YLCommonKit
//
//  Created by xyanl on 2019/11/29.
//  Copyright © 2019 xyanl. All rights reserved.
//

#import "UIViewController+YLFullScreen.h"

#import <AppKit/AppKit.h>


@implementation UIViewController (YLFullScreen)

- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationFullScreen;
}

@end
