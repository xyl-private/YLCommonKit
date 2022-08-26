//
//  NSString+YLAppInfo.m
//  YLCommonKit
//
//  Created by xyanl on 2020/1/16.
//  Copyright © 2020 xyanl. All rights reserved.
//

#import "NSString+YLAppInfo.h"

@implementation NSString (YLAppInfo)

+ (NSString *)yl_appInfoWithType:(YLBundleType)type {
    NSDictionary * typeKeys = @{
        @(YLBundleTypeName) : @"CFBundleName",
        @(YLBundleTypeShortVersion) : @"CFBundleShortVersionString",
        @(YLBundleTypeBuildVersion) : @"CFBundleVersion",
        @(YLBundleTypeIdentifier) : @"CFBundleIdentifier",
    };
    NSString *typeString = typeKeys[@(type)];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    NSString *appInfo = [infoDictionary objectForKey:typeString];
    
    return appInfo;
}

+ (NSDictionary *)yl_getAppInfoWithKey:(NSString *)key{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    if (key.length != 0) {
        return [infoDictionary objectForKey:key];
    }
    return infoDictionary;
}

@end
