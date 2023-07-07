//
//  NSArray+YLArray.m
//  YLCommonKit
//
//  Created by xyanl on 2023/7/7.
//  Copyright © 2023 xyanl. All rights reserved.
//

#import "NSArray+YLArray.h"

@implementation NSArray (YLArray)

- (NSArray *)yl_reverseArray {
    NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator) {
        [arrayTemp addObject:element];
    }
    return arrayTemp;
}

/// 比较两个数组中的字符串元素是否相同
/// - Parameter aArray: 元素必须都是字符串类型的
- (BOOL)yl_isEquestToArray:(NSArray<NSString *> *)aArray {
    
    if (self.count != aArray.count) {
        return NO;
    }
    
    for (NSString *string in self) {
        if (![aArray containsObject:string]) {
            return NO;
        }
    }
    return YES;
}


@end
