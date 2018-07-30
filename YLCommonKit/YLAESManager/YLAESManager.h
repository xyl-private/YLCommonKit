//
//  YLAESManager.h
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLAESManager : NSObject

/**
 请求参数加密
 @param dic  需要加密的字典
 @param password 秘钥
 @param aesDicKey 加密字典的Key值
 @return 返回加密字典
 */
+ (NSDictionary *)requestAES:(NSDictionary *)dic password:(NSString *)password aesDicKey:(NSString *)aesDicKey;

/**
 解密相关字符串
 @param base64EncodedString 需要解密的字符串
 @param password 密码
 @return 解密后的字符串
 */
+ (NSString*)responseDecrypt:(NSString *)base64EncodedString password:(NSString *)password;
@end
