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
    //CFShow((__bridge CFTypeRef)(infoDictionary));
    if (key.length != 0) {
        return [infoDictionary objectForKey:key];
    }
    return infoDictionary;
}

@end
