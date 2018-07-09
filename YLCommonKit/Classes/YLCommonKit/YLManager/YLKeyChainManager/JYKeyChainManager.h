//
//  JYKeyChainManage.h
//  LoanInternalPlus
//
//  Created by xyanl on 2018/6/20.
//  Copyright © 2017年 xyanl. All rights reserved.
//  一个轻量级iOS安全存储方式(Manage)

#import <Foundation/Foundation.h>

@interface JYKeyChainManager : NSObject
/**读取或保存*/
+ (id)readOrSaveValueWithIdentifier:(NSString *)identifier;
/**储存*/
+ (void)saveValue:(NSString *)value Identifier:(NSString *)identifier;
/**读取*/
+ (id)readValueWithIdentifier:(NSString *)identifier;
/**删除*/
+ (void)deleteValueWithIdentifier:(NSString *)identifier;
/**删除KEY_IN_KEYCHAIN标示的字典*/
+ (void)deleteAll;
@end
