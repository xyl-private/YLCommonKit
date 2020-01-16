//
//  NSString+YLAppInfo.h
//  YLCommonKit
//
//  Created by xyanl on 2020/1/16.
//  Copyright © 2020 xyanl. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YLAppInfo)

/// 获取 APP 信息
/// @param key 参考返回值输出内容
/// CFBundleName:APP 名字
/// CFBundleShortVersionString:APP 版本号
+ (NSDictionary *)yl_getAppInfoWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
