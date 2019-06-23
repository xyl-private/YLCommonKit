//
//  YLUIMacro.h
//  YLCommonKit
//
//  Created by zjmac on 2019/6/23.
//  Copyright © 2019 xyanl. All rights reserved.
//
//  UI的宏定义(字体、颜色、适配)
#ifndef YLUIMacro_h
#define YLUIMacro_h

#pragma mark - ----------------------- 屏幕 -----------------------

#define kScreenW                 [UIScreen mainScreen].bounds.size.width
#define KScreenH                 [UIScreen mainScreen].bounds.size.height

#define kAppScreenBounds [UIScreen mainScreen].bounds//屏幕大小

#pragma mark - ----------------------- 颜色相关 -----------------------

//颜色
#define kRGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define kRGB(r,g,b)      kRGBA(r,g,b,1)

#define kColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//RGB
#define kColorWithRGB(_R,_G,_B,_A) [UIColor colorWithRed:_R/255.0 green:_G/255.0 blue:_B/255.0 alpha:_A]

//16进制颜色转换成UIColor
#define kColorWithHexAlph(hex,alph)  [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:(alph)]

#define kColorWithHex(hex)  [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]

//随机色
#define kRandomColor   [UIColor colorWithRed:arc4random()%254/255.0f green:arc4random()%254/255.0f blue:arc4random()%254/255.0f alpha:1]


#endif /* YLUIMacro_h */
