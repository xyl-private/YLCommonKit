//
//  YLAppMacro.h
//  YLCommonKit
//
//  Created by zjmac on 2019/6/23.
//  Copyright © 2019 xyanl. All rights reserved.
//

#ifndef YLAppDefines_h
#define YLAppDefines_h

//App版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
// 当前版本
#define kFSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define kDSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define kSSystemVersion          ([[UIDevice currentDevice] systemVersion])
//获取当前语言
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])



#endif /* YLAppDefines_h */
