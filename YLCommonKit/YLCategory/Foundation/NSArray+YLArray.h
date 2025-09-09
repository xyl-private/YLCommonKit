//
//  NSArray+YLArray.h
//  YLCommonKit
//
//  Created by xyanl on 2023/7/7.
//  Copyright © 2023 xyanl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (YLArray)

/**
 * 返回当前数组的反转版本（新数组）
 * 使用系统内置的 reverseObjectEnumerator 方法，效率较高
 * 原数组保持不变
 *
 * @return 元素顺序反转后的新数组
 */
- (NSArray *)yl_reverseArray;

@end

NS_ASSUME_NONNULL_END
