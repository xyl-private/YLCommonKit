//
//  JYUIMacro.h
//  Pods
//
//  Created by xyanl on 2018/5/15.
//  UI方面的宏定义

#ifndef JYUIMacro_h
#define JYUIMacro_h

#define kDeviceWidth           [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight          [UIScreen mainScreen].bounds.size.height

#define kAppScreenBounds [UIScreen mainScreen].bounds//屏幕大小

#define iPhone4         CGRectGetHeight([[UIScreen mainScreen] bounds])==480
#define iPhone5         CGRectGetHeight([[UIScreen mainScreen] bounds])==568
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

/*** 是否是iPhoneX ***/
#define isIPhoneX ([[UIApplication sharedApplication] statusBarFrame].size.height>20?YES:NO) // 适配iPhone x 底栏高度

#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4S (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0)
#define IS_IPHONE_5 (IS_IPHONE && ([[UIScreen mainScreen] bounds].size.height == 568.0) && ((IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale == [UIScreen mainScreen].scale) || !IS_OS_8_OR_LATER))
#define IS_STANDARD_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0  && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale == [UIScreen mainScreen].scale)
#define IS_ZOOMED_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0 && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale > [UIScreen mainScreen].scale)
#define IS_STANDARD_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define IS_ZOOMED_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0 && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale < [UIScreen mainScreen].scale)

#define kTabbarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49) // 适配iPhone x 底栏高度
/***************************************************************************
 * 颜色相关
 **************************/
//颜色
#define kRGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define kRGB(r,g,b)      kRGBA(r,g,b,1)


#define kColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//app 主配宏
#define kMainColor      kRGB(37,113,201)  //主配颜色

//RGB
#define kColorWithRGB(_R,_G,_B,_A) [UIColor colorWithRed:_R/255.0 green:_G/255.0 blue:_B/255.0 alpha:_A]

//16进制颜色转换成UIColor
#define kColorWithHexAlph(hex,alph)  [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:(alph)]

#define kColorWithHex(hex)  [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]

//随机色
#define kRandomColor   [UIColor colorWithRed:arc4random()%254/255.0f green:arc4random()%254/255.0f blue:arc4random()%254/255.0f alpha:1]

//常用的颜色
#define kClearColor  [UIColor clearColor]
#define kWhiteColor  [UIColor whiteColor]
#define kBlackColor  [UIColor blackColor]
#define kRedColor    [UIColor redColor]

/***************************************************************************
 * 字号相关
 **************************/
#define kFont(_size)       [UIFont systemFontOfSize:_size]
#define kBlodFont(_size)   [UIFont boldSystemFontOfSize:_size]

#define kFont09 kFont(9)
#define kFont10 kFont(10)
#define kFont11 kFont(11)
#define kFont12 kFont(12)
#define kFont13 kFont(13)
#define kFont14 kFont(14)
#define kFont15 kFont(15)
#define kFont16 kFont(16)
#define kFont17 kFont(17)
#define kFont18 kFont(18)
#define kFont20 kFont(20)
#define kFont26 kFont(26)
#define kFont36 kFont(36)

#define kBFont10 kBlodFont(10)
#define kBFont12 kBlodFont(12)
#define kBFont13 kBlodFont(13)
#define kBFont15 kBlodFont(15)
#define kBFont16 kBlodFont(16)
#define kBFont17 kBlodFont(17)
#define kBFont18 kBlodFont(18)
#define kBFont20 kBlodFont(20)
#define kBFont26 kBlodFont(26)
#define kBFont36 kBlodFont(36)

#define kFONT(x)  [UIFont systemFontOfSize:x]
#define kFONTB(x) [UIFont boldSystemFontOfSize:x]

#define kFONT10   kFONT(10.0f)
#define kFONTB10  kFONTB(10.0f)

#define kFONT11   kFONT(11.0f)
#define kFONTB11  kFONTB(11.0f)

#define kFONT12   kFONT(12.0f)
#define kFONTB12  kFONTB(12.0f)

#define kFONT13   kFONT(13.0f)
#define kFONTB13  kFONTB(13.0f)

#define kFONT14   kFONT(14.0f)
#define kFONTB14  kFONTB(14.0f)

#define kFONT15   kFONT(15.0f)
#define kFONTB15  kFONTB(15.0f)

#define kFONT16   kFONT(16.0f)
#define kFONTB16  kFONTB(16.0f)

#define kFONT17   kFONT(17.0f)
#define kFONTB17  kFONTB(17.0f)

#define kFONT18   kFONT(18.0f)
#define kFONTB18  kFONTB(18.0f)

#define kFONT19   kFONT(19.0f)
#define kFONTB19  kFONTB(19.0f)

#define kFONT20   kFONT(20.0f)
#define kFONTB20  kFONTB(20.0f)

#define kFONT21   kFONT(21.0f)
#define kFONTB21  kFONTB(21.0f)

#define kFONT22   kFONT(22.0f)
#define kFONTB22  kFONTB(22.0f)

#define kFONT23   kFONT(23.0f)
#define kFONTB23  kFONTB(23.0f)

#endif /* JYUIMacro_h */
