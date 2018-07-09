//
//  JYKeyChain.h
//  LoanInternalPlus
//
//  Created by xyanl on 2018/6/20.
//  Copyright © 2017年 xyanl. All rights reserved.
//  一个轻量级iOS安全存储方式

#import <Foundation/Foundation.h>

@interface JYKeyChain : NSObject
/** */
+ (NSMutableDictionary *)getKeyChainQuery:(NSString *)identifier;
/** 根据标示保存数据 */
+ (void)saveUserDataKey:(NSString *)identifier dataValue:(id)valueData;
/** 根据标示获取数据 */
+ (id)getUserData:(NSString *)identifier;
/** 根据标示删除数据 */
+ (void)deleteUserData:(NSString *)identifier;
@end
