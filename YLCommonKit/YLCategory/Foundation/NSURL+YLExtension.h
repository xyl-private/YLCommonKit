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

/**
 * 解析URL中的查询参数，返回参数字典
 * @discussion 该方法会解析URL中?后面的查询参数，将其转换为键值对字典。
 *              支持重复参数（后出现的值会覆盖先前的值），自动进行URL解码。
 *              如果URL无效或没有查询参数，返回空字典。
 *
 * @return 包含所有查询参数的字典，所有键和值都是解码后的字符串
 */
- (NSDictionary *)yl_queryComponents;

@end

NS_ASSUME_NONNULL_END
