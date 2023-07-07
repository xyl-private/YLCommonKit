//
//  NSObject+YLGCD.h
//  YLCommonKit
//
//  Created by xyanl on 2023/7/7.
//  Copyright © 2023 xyanl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^XComplete)(void);

@interface NSObject (YLGCD)

/// GCD - 延时执行
/// - Parameters:
///   - afterSecond: n 秒后执行
///   - complete: 完成回调
- (void)yl_afterSecond:(NSTimeInterval)afterSecond complete:(XComplete)complete;

@end

NS_ASSUME_NONNULL_END
