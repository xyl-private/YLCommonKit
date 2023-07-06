//
//  NSURL+YLExtension.h
//  YLCommonKit
//
//  Created by xyanl on 2023/6/25.
//  Copyright © 2023 xyanl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (YLExtension)

/// 获取URL中参数组件
/// NSURL: https://testapp.dylan-saas.com/share/new/dl-order/index.html?key=26ccaad7-5712-46a3-a0f4-bf720c9bbcfa&type=19
/// 返回: @{ @"key": @"26ccaad7-5712-46a3-a0f4-bf720c9bbcfa", @"type": @"19"}
- (NSDictionary *)yl_queryComponents;

@end

NS_ASSUME_NONNULL_END
