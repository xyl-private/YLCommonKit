//
//  NSString+YLAppInfo.m
//  YLCommonKit
//
//  Created by xyanl on 2020/1/16.
//  Copyright © 2020 xyanl. All rights reserved.
//

#import "NSString+YLAppInfo.h"

@implementation NSString (YLAppInfo)

+ (NSDictionary *)yl_getAppInfoWithKey:(NSString *)key{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    if (key.length != 0) {
        return [infoDictionary objectForKey:key];
    }
    return infoDictionary;
}

+ (NSString *)yl_getAppName{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleName"];
    return app_Name;
}

+ (NSString *)yl_getAppVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_version;
}
@end
