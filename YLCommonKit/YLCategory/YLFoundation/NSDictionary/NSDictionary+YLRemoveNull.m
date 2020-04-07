//
//  NSDictionary+YLRemoveNull.m
//  YLCommonKit
//
//  Created by xyanl on 2020/4/7.
//  Copyright © 2020 xyanl. All rights reserved.
//

#import "NSDictionary+YLRemoveNull.h"
#import <objc/runtime.h>

@implementation NSDictionary (YLRemoveNull)

+ (void)load {
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(setObject:forKey:));
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(yl_setObject:forKey:));
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

@end
