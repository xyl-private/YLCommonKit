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

#define WeakSelf __weak typeof(self) weakSelf = self;

//weakSelf 是为了block不持有self，避免Retain Circle循环引用。在 Block 内如果需要访问 self 的方法、变量，建议使用 weakSelf。
//strongSelf的目的是因为一旦进入block执行，假设不允许self在这个执行过程中释放，就需要加入strongSelf。block执行完后这个strongSelf 会自动释放，没有不会存在循环引用问题。如果在 Block 内需要多次 访问 self，则需要使用 strongSelf。
#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif



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

// 日志输出宏定义
#ifdef DEBUG
// 调试状态
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
// 发布状态
#define NSLog(...)
#endif

// 去掉警告的宏
#pragma clang diagnostic push
#pragma clang diagnostic ignored "警告的类型"// 找到警告的类型
//被警告的代码
#pragma clang diagnostic pop


#endif /* YLFunctionMacro_h */
