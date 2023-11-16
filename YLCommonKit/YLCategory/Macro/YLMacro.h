//
//  YLMacro.h
//  YLCommonKit
//
//  Created by xyanl on 2023/7/7.
//  Copyright © 2023 xyanl. All rights reserved.
//

#ifndef YLMacro_h
#define YLMacro_h

#pragma mark - ********** 屏幕 **********

#define xScreenBounds [UIScreen mainScreen].bounds //屏幕大小
#define xScreenW [UIScreen mainScreen].bounds.size.width
#define xScreenH [UIScreen mainScreen].bounds.size.height

// 适配以iPhone6为基准(UI妹纸给你的设计图是iPhone6的),
// 当然你也可以改, 但是出图是按照7P(6P)的图片出的, 因为大图压缩还是清晰的, 小图拉伸就不清晰了, 所以只出一套最大的图片即可
#define xiPhone6W 375.0
#define xiPhone6H 667.0
// 计算比例
// 适配x比例
#define xScaleX (xScreenW / xiPhone6W)
// 适配y比例
#define xScaleY (xScreenH / xiPhone6H)
// 适配X坐标
#define xLineX(l) (l * xScaleX)
// 适配Y坐标
#define xLineY(l) (l * xScaleY)


#define xIPhoneX \
({   BOOL isPhoneX = NO;\
    if (@available(iOS 11.0, *)) {\
        isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
    }\
    (isPhoneX);\
})

/*状态栏高度*/
#define X_IPHONE_STATUS_H  [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height
/*导航栏高度*/
#define X_IPHONE_NAV_H (44.0)
/*状态栏和导航栏总高度*/
#define X_IPHONE_NAV_STATUS_H (X_IPHONE_STATUS_H + X_IPHONE_NAV_H)
/*TabBar高度*/
#define X_IPHONE_TAB_H (CGFloat)(49.0 + X_IPHONE_BOTTOM_SAFE_H)
/*顶部安全区域高度*/
#define X_IPHONE_TOP_SAFE_H (CGFloat)(xIPhoneX ? X_IPHONE_NAV_H : 0.0)
/*底部安全区域高度*/
#define X_IPHONE_BOTTOM_SAFE_H (CGFloat)(xIPhoneX ? 34.0 : 0.0)
/*导航条和Tabbar总高度*/
#define X_IPHONE_NAV_TAB_H (X_IPHONE_NAV_STATUS_H + X_IPHONE_TAB_H)


#pragma mark - ********** 颜色 **********
// 十六进制颜色
#define xColor(hex) [UIColor yl_colorWithHexString:hex]
#define xColorAlpha(hex, a) [UIColor yl_colorWithHexString:hex alpha:a]
// 随机色
#define xColorRandom [UIColor yl_randomColor]


#pragma mark - ********** 图片 **********

//获取图片资源
#define xImageNamed(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@", imageName]]


#pragma mark - ********** Block **********

// weakSelf 是为了block不持有self，避免Retain Circle循环引用。在 Block 内如果需要访问 self 的方法、变量，建议使用 weakSelf。
// strongSelf的目的是因为一旦进入block执行， 假设不允许self在这个执行过程中释放，就需要加入strongSelf。 block执行完后这个strongSelf 会自动释放， 没有不会存在循环引用问题。 如果在 Block 内需要多次 访问 self，则需要使用 strongSelf。
/**
 弱引用/强引用
 
 Example:
     @YLWeakSelf(self)
     [self doSomething^{
         @YLStrongSelf(self)
         if (!self) return;
         ...
     }];
 */
#ifndef YLWeakSelf
    #if DEBUG
        #if __has_feature(objc_arc)
            #define YLWeakSelf(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
            #define YLWeakSelf(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define YLWeakSelf(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
            #define YLWeakSelf(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef YLStrongSelf
    #if DEBUG
        #if __has_feature(objc_arc)
            #define YLStrongSelf(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
            #define YLStrongSelf(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define YLStrongSelf(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
            #define YLStrongSelf(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif


#pragma mark - ********** 警告 **********
// 去掉警告的宏
#pragma clang diagnostic push
// 找到警告的类型
#pragma clang diagnostic ignored "警告的类型"
// 被警告的代码
// some code
#pragma clang diagnostic pop

#pragma mark - ********** 日期类型 **********

#define xDateFormat_YMDHMSMS  @"yyyy-MM-dd HH:mm:ss SSS"
#define xDateFormat_YMDHMS  @"yyyy-MM-dd HH:mm:ss"
#define xDateFormat_YMDHM  @"yyyy-MM-dd HH:mm"
#define xDateFormat_YMD  @"yyyy-MM-dd"
#define xDateFormat_YM  @"yyyy-MM"
#define xDateFormat_MDHM  @"MM-dd HH:mm"
#define xDateFormat_MD  @"MM-dd"
#define xDateFormat_HMS  @"HH:mm:ss"
#define xDateFormat_HM  @"HH:mm"



#endif /* YLMacro_h */
