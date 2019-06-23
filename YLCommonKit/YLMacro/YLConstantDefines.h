//
//  YLConstantDefines.h
//  YLCommonKit
//
//  Created by zjmac on 2019/6/23.
//  Copyright © 2019 xyanl. All rights reserved.
//
//
// 常量的定义
/**
 最省事的方式就是宏定义了，但是宏定义本质只是文本替换。在预编译器影响速度、不能声明变量类型、不能使用 const 修饰导致使用中值可以更改，所以常量的定义不推荐。
 
 extern：全局只有一个变量，对一个常量字符串的引用，只会被初始化一次。
 static：全局有多个变量，每个引用的地方的变量都会初始化一次，分配内存空间，对一个常量字符串的引用（所以很多博客和书根本就没提这样写）。
 */
/**
 FOUNDATION_EXTERN 是在Foundation框架里面 NSObjCRuntime.h 中定义的。
 NSString是在Foundation框架里面 NSString.h 中定义的。
 所以用FOUNDATION_EXTERN 修饰 NSString。
 
 UIKIT_EXTERN是在UIKit框架里面UIKitDefines.h中定义的。
 CGFloat在CoreGraphics框架里面CGBase.h中定义的。
 用UIKIT_EXTERN修饰CGFloat。
 
 NSInteger是在usr/include框架里面NSObjCRuntime.h中定义的。
 用UIKIT_EXTERN修饰NSInteger。
 
 */
#import <UIKit/UIKit.h>

// 常量
UIKIT_EXTERN const CGFloat ZQResultCode;
// APP 名字
FOUNDATION_EXTERN NSString *const ZQAppName;
