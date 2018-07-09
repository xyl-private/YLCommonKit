//
//  JYKeyChainManage.m
//  LoanInternalPlus
//
//  Created by xyanl on 2018/6/20.
//  Copyright © 2017年 xyanl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYKeyChainManager.h"
#import "JYKeyChain.h"

///项目标示
static NSString * const KEY_IN_KEYCHAIN = @"com.jieyuechina.app.allinfo";

@implementation JYKeyChainManager
/**读取或保存*/
+ (id)readOrSaveValueWithIdentifier:(NSString *)identifier
{
    id value = [JYKeyChainManager readValueWithIdentifier:identifier];
    if ([value isEqualToString:@""]) {
        value = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [JYKeyChainManager saveValue:value Identifier:identifier];
    }
    return value;
}
/**储存*/
+ (void)saveValue:(NSString *)value Identifier:(NSString *)identifier{
    id dataValue = [JYKeyChain getUserData:KEY_IN_KEYCHAIN];
    if([dataValue isKindOfClass:NULL] || (dataValue == nil)){
//        [self savePassWord:@"与你同在!!"];
        NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
        [usernamepasswordKVPairs setObject:value forKey:identifier];
        [JYKeyChain saveUserDataKey:KEY_IN_KEYCHAIN dataValue:usernamepasswordKVPairs];
    }else{
        NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[JYKeyChain getUserData:KEY_IN_KEYCHAIN];
        [usernamepasswordKVPairs setObject:value forKey:identifier];
        [JYKeyChain saveUserDataKey:KEY_IN_KEYCHAIN dataValue:usernamepasswordKVPairs];
    }
}

/**读取*/
+ (id)readValueWithIdentifier:(NSString *)identifier{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[JYKeyChain getUserData:KEY_IN_KEYCHAIN];
    id dataValue = [usernamepasswordKVPair objectForKey:identifier];
    if([dataValue isEqualToString:@""] || [dataValue isKindOfClass:NULL] || (dataValue == nil)){
        return @"";
    }else{
        return dataValue;
    }
}

/**删除*/
+ (void)deleteValueWithIdentifier:(NSString *)identifier{
    NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[JYKeyChain getUserData:KEY_IN_KEYCHAIN];
    [usernamepasswordKVPairs setObject:@"" forKey:identifier];
    [JYKeyChain saveUserDataKey:KEY_IN_KEYCHAIN dataValue:usernamepasswordKVPairs];
}

/**删除KEY_IN_KEYCHAIN标示的字典*/
+ (void)deleteAll{
    [JYKeyChain deleteUserData:KEY_IN_KEYCHAIN];
}
@end
