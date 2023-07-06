//
//  NSArray+YLExtension.h
//  YLCommonKit
//
//  Created by xyanl on 2023/6/25.
//  Copyright © 2023 xyanl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (YLExtension)


/// 将数组反向排序
- (NSArray *)yl_reverseArray;

/// 比较两个数组中的字符串元素是否相同
/// - Parameter aArray: 元素必须都是字符串类型的
- (BOOL)yl_isEquestToArray:(NSArray<NSString *> *)aArray;

@end

NS_ASSUME_NONNULL_END
