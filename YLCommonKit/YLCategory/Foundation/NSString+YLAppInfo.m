//
//  NSString+YLAppInfo.m
//  YLCommonKit
//
//  Created by xyanl on 2020/1/16.
//  Copyright © 2020 xyanl. All rights reserved.
//

#import "NSString+YLAppInfo.h"
#import <sys/utsname.h>
#import <UIKit/UIKit.h>

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

+ (NSDictionary *)yl_getAppInfoWithKey:(NSString *)key {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    if (key.length != 0) {
        return [infoDictionary objectForKey:key];
    }
    return infoDictionary;
}

+ (NSString *)yl_UUID {
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}

#pragma mark -- 判断手机型号
+ (NSString*)yl_phoneModel {
    // 苹果设备 iPhone、iPad 型号
    // https://www.theiphonewiki.com/wiki/Models
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString * identifier = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    NSDictionary *generations = @{
        // Simulator 模拟器
        @"i386": @"iPhone Simulator",
        @"x86_64": @"iPhone Simulator",
        
        // iPhone
        @"iPhone1,1": @"iPhone 2G",
        @"iPhone1,2": @"iPhone 3G",
        @"iPhone2,1": @"iPhone 3GS",
        @"iPhone3,1": @"iPhone 4",
        @"iPhone3,2": @"iPhone 4",
        @"iPhone3,3": @"iPhone 4",
        @"iPhone4,1": @"iPhone 4S",
        @"iPhone5,1": @"iPhone 5",
        @"iPhone5,2": @"iPhone 5",
        @"iPhone5,3": @"iPhone 5c",
        @"iPhone5,4": @"iPhone 5c",
        @"iPhone6,1": @"iPhone 5s",
        @"iPhone6,2": @"iPhone 5s",
        @"iPhone7,1": @"iPhone 6 Plus",
        @"iPhone7,2": @"iPhone 6",
        @"iPhone8,1": @"iPhone 6s",
        @"iPhone8,2": @"iPhone 6s Plus",
        @"iPhone8,4": @"iPhone SE",
        @"iPhone9,1": @"iPhone 7",
        @"iPhone9,3": @"iPhone 7",
        @"iPhone9,2": @"iPhone 7 Plus",
        @"iPhone9,4": @"iPhone 7 Plus",
        @"iPhone10,1": @"iPhone 8",
        @"iPhone10,4": @"iPhone 8",
        @"iPhone10,2": @"iPhone 8 Plus",
        @"iPhone10,5": @"iPhone 8 Plus",
        @"iPhone10,3": @"iPhone X",
        @"iPhone10,6": @"iPhone X",
        @"iPhone11,8": @"iPhone XR",
        @"iPhone11,2": @"iPhone XS",
        @"iPhone11,4": @"iPhone XS Max",
        @"iPhone11,6": @"iPhone XS Max",
        
        @"iPhone12,1": @"iPhone 11",
        @"iPhone12,3": @"iPhone 11 Pro",
        @"iPhone12,5": @"iPhone 11 Pro Max",
        @"iPhone12,8": @"iPhone SE 2nd",
        
        @"iPhone13,1": @"iPhone 12 mini",
        @"iPhone13,2": @"iPhone 12",
        @"iPhone13,3": @"iPhone 12 Pro",
        @"iPhone13,4": @"iPhone 12 Pro Max",
        
        @"iPhone14,4": @"iPhone 13 mini",
        @"iPhone14,5": @"iPhone 13",
        @"iPhone14,2": @"iPhone 13 Pro",
        @"iPhone14,3": @"iPhone 13 Pro Max",
        @"iPhone14,6": @"iPhone SE 3rd",
        
        @"iPhone14,7": @"iPhone 14",
        @"iPhone14,8": @"iPhone 14 Plus",
        @"iPhone15,2": @"iPhone 14 Pro",
        @"iPhone15,3": @"iPhone 14 Pro Max",
        
        // iPad
        @"iPad1,1": @"iPad",
        @"iPad2,1": @"iPad 2",
        @"iPad2,2": @"iPad 2",
        @"iPad2,3": @"iPad 2",
        @"iPad2,4": @"iPad 2",
        
        @"iPad3,1": @"iPad 3",
        @"iPad3,2": @"iPad 3",
        @"iPad3,3": @"iPad 3",
        
        @"iPad3,4": @"iPad 4",
        @"iPad3,5": @"iPad 4",
        @"iPad3,6": @"iPad 4",
        
        @"iPad6,11": @"iPad 5",
        @"iPad6,12": @"iPad 5",
        
        @"iPad7,5": @"iPad 6",
        @"iPad7,6": @"iPad 6",
        
        @"iPad7,11": @"iPad 7",
        @"iPad7,12": @"iPad 7",
        
        @"iPad11,6": @"iPad 8",
        @"iPad11,7": @"iPad 8",
        
        @"iPad12,1": @"iPad 8",
        @"iPad12,2": @"iPad 8",
        
        // iPad Air
        @"iPad4,1": @"iPad Air",
        @"iPad4,2": @"iPad Air",
        @"iPad4,3": @"iPad Air",
        
        @"iPad5,3": @"iPad Air 2",
        @"iPad5,4": @"iPad Air 2",
        
        @"iPad11,3": @"iPad Air 3",
        @"iPad11,4": @"iPad Air 3",
        
        @"iPad13,1": @"iPad Air 4",
        @"iPad13,2": @"iPad Air 4",
        
        @"iPad13,16": @"iPad Air 5",
        @"iPad13,17": @"iPad Air 5",
        
        // iPad Pro
        @"iPad6,7": @"iPad Pro (12.9-inch)",
        @"iPad6,8": @"iPad Pro (12.9-inch)",
        
        @"iPad6,3": @"iPad Pro (9.7-inch)",
        @"iPad6,4": @"iPad Pro (9.7-inch)",
        
        @"iPad7,1": @"iPad Pro 2(12.9-inch)",
        @"iPad7,2": @"iPad Pro 2(12.9-inch)",
        
        @"iPad7,3": @"iPad Pro (10.5-inch)",
        @"iPad7,4": @"iPad Pro (10.5-inch)",
        
        @"iPad8,1": @"iPad Pro (11-inch)",
        @"iPad8,2": @"iPad Pro (11-inch)",
        @"iPad8,3": @"iPad Pro (11-inch)",
        @"iPad8,4": @"iPad Pro (11-inch)",
        
        
        @"iPad8,5": @"iPad Pro 3(12.9-inch)",
        @"iPad8,6": @"iPad Pro 3(12.9-inch)",
        @"iPad8,7": @"iPad Pro 3(12.9-inch)",
        @"iPad8,8": @"iPad Pro 3(12.9-inch)",
        
        @"iPad8,9": @"iPad Pro 2(11-inch)",
        @"iPad8,10": @"iPad Pro 2(11-inch)",
        
        @"iPad8,11": @"iPad Pro 4(12.9-inch)",
        @"iPad8,12": @"iPad Pro 4(12.9-inch)",
        
        @"iPad13,4": @"iPad Pro 3(11-inch)",
        @"iPad13,5": @"iPad Pro 3(11-inch)",
        @"iPad13,6": @"iPad Pro 3(11-inch)",
        @"iPad13,7": @"iPad Pro 3(11-inch)",
        
        @"iPad13,8": @"iPad Pro 5(12.9-inch)",
        @"iPad13,9": @"iPad Pro 5(12.9-inch)",
        @"iPad13,10": @"iPad Pro 5(12.9-inch)",
        @"iPad13,11": @"iPad Pro 5(12.9-inch)",
        
        // iPad mini
        @"iPad2,5": @"iPad mini",
        @"iPad2,6": @"iPad mini",
        @"iPad2,7": @"iPad mini",
        
        @"iPad4,4": @"iPad mini 2",
        @"iPad4,5": @"iPad mini 2",
        @"iPad4,6": @"iPad mini 2",
        
        @"iPad4,7": @"iPad mini 3",
        @"iPad4,8": @"iPad mini 3",
        @"iPad4,9": @"iPad mini 3",
        
        @"iPad5,1": @"iPad mini 4",
        @"iPad5,2": @"iPad mini 4",
        
        @"iPad11,1": @"iPad mini 5",
        @"iPad11,2": @"iPad mini 5",
        
        @"iPad14,1": @"iPad mini 6",
        @"iPad14,2": @"iPad mini 6",
    };
    // 手机型号
    NSString *generation = generations[identifier];
    if (generation.length > 0) {
        return generation;
    }
    return identifier;
}
@end
