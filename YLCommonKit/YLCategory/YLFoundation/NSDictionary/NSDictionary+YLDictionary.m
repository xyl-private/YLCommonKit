//
//  NSDictionary+YLDictionary.m
//  YLCommonKit
//
//  Created by xyanl on 2019/8/26.
//  Copyright © 2019 xyanl. All rights reserved.
//

#import "NSDictionary+YLDictionary.h"
#import <objc/runtime.h>
@implementation NSDictionary (YLDictionary)

+ (void)load {
    
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(setObject:forKey:));
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(em_setObject:forKey:));
    method_exchangeImplementations(fromMethod, toMethod);
}

- (void)yl_setObject:(id)emObject forKey:(NSString *)key {
    if (emObject == nil) {
        @try {
            [self yl_setObject:emObject forKey:key];
        }
        @catch (NSException *exception) {
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            emObject = [NSString stringWithFormat:@""];
            [self yl_setObject:emObject forKey:key];
        }
        @finally {}
    }else {
        [self yl_setObject:emObject forKey:key];
    }
}

/**
 读取本地JSON文件
 @param name 文件名字
 @param type 文件类型
 */
+ (NSDictionary *)yl_readLocalFileWithName:(NSString *)name type:(NSString *)type{
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}
@end
