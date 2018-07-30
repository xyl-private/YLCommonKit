//
//  YLAESManager.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "YLAESManager.h"
#import "AESCrypt.h"

/** 网络解密Key - @"Jy_ApP_0!9i+90&#" */
//static NSString * const AESPWDKey = @"0123456789123456";
/** AES加密请求Key */
//static NSString * const AESBodyEncrypt = @"aesRequest";


@implementation YLAESManager

+ (NSDictionary *)requestAES:(NSDictionary *)dic password:(NSString *)password aesDicKey:(NSString *)aesDicKey
{
    NSString *aesJson = [AESCrypt encrypt:[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding] password:password];
    return @{aesDicKey:aesJson};
}

+ (NSString *)responseDecrypt:(NSString *)base64EncodedString password:(NSString *)password
{
    base64EncodedString  = [AESCrypt decrypt:base64EncodedString password:password];
    return base64EncodedString;
}

@end
