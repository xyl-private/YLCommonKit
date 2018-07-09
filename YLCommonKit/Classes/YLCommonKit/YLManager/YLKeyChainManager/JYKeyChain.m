//
//  JYKeyChain.m
//  LoanInternalPlus
//
//  Created by xyanl on 2018/6/20.
//  Copyright © 2017年 xyanl. All rights reserved.
//  

#import "JYKeyChain.h"

@implementation JYKeyChain
+ (NSMutableDictionary *)getKeyChainQuery:(NSString *)identifier {
    return  [NSMutableDictionary dictionaryWithObjectsAndKeys:
             (__bridge_transfer id)kSecClassGenericPassword,(__bridge_transfer id)kSecClass,
             identifier, (__bridge_transfer id)kSecAttrService,
             identifier, (__bridge_transfer id)kSecAttrAccount,
             (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,(__bridge_transfer id)kSecAttrAccessible,
             nil];
}

+ (void)saveUserDataKey:(NSString *)identifier dataValue:(id)valueData {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:identifier];
    //Delete old item before add new item
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:valueData] forKey:(__bridge_transfer id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
    //需要手动释放
    if (keychainQuery) {
        CFRelease((__bridge CFTypeRef)(keychainQuery));
    }
    if (keychainQuery) {
        CFRelease((__bridge CFTypeRef)(keychainQuery));
    }
}

+ (id)getUserData:(NSString *)identifier {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:identifier];
    //Configure the search setting
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", identifier, e);
        } @finally {
        }
    }
    //需要手动释放
    if (keychainQuery) {
        CFRelease((__bridge CFTypeRef)(keychainQuery));
    }
    return ret;
}

+ (void)deleteUserData:(NSString *)identifier {
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:identifier];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    //需要手动释放
    if (keychainQuery) {
        CFRelease((__bridge CFTypeRef)(keychainQuery));
    }
}

@end
