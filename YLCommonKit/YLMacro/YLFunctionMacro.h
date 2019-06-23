//
//  YLFunctionMacro.h
//  YLCommonKit
//
//  Created by zjmac on 2019/6/23.
//  Copyright © 2019 xyanl. All rights reserved.
//
// 全局方法或内敛函数定义
#ifndef YLFunctionMacro_h
#define YLFunctionMacro_h

#define APP_DELEGATE                           [AppDelegate sharedAppDelegate]


// weakself strongself
#define ZQWeak(type)  __weak typeof(type) weak##type = type;
#define ZQStrong(type)  __strong typeof(type) type = weak##type;


/**************************
 * 常用
 **************************/
//UserDefaults保存信息
#define kUserUserDefaults_Save(_value,_key)  [[NSUserDefaults standardUserDefaults] setObject:_value forKey:_key]

//UserDefaults获取信息
#define kUserUserDefaults_Get(_key) [[NSUserDefaults standardUserDefaults] objectForKey:_key]

//UserDefaults删除信息
#define kUserUserDefaults_Remove(_key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:_key]

//获取图片资源
#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
//获取temp
#define kPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]


//设置 view 圆角和边框
#define LRViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

//获取图片资源
#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]


// 日志输出宏定义
#ifdef DEBUG
// 调试状态
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
// 发布状态
#define NSLog(...)
#endif

// 去除调用代理方法的警告
#define SuppressPerformSelectorLeakWarning(Stuff) \
do {\
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#endif /* YLFunctionMacro_h */
