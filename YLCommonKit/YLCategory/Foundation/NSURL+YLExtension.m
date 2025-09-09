//
//  NSURL+YLExtension.m
//  YLCommonKit
//
//  Created by xyanl on 2023/6/25.
//  Copyright © 2023 xyanl. All rights reserved.
//

#import "NSURL+YLExtension.h"

@implementation NSURL (YLExtension)

/**
 * 解析URL中的查询参数，返回参数字典
 * @discussion 该方法会解析URL中?后面的查询参数，将其转换为键值对字典。
 *              支持重复参数（后出现的值会覆盖先前的值），自动进行URL解码。
 *              如果URL无效或没有查询参数，返回空字典。
 *
 * @return 包含所有查询参数的字典，所有键和值都是解码后的字符串
 */
- (NSDictionary *)yl_queryComponents {
    // 1. 安全检查
    if (!self.absoluteString || self.absoluteString.length == 0) {
        return @{};
    }
    
    // 2. 使用NSURLComponents解析（更安全的方式）
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:NO];
    if (!urlComponents.queryItems || urlComponents.queryItems.count == 0) {
        return @{};
    }
    
    // 3. 创建参数字典
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    // 4. 遍历查询项，并自动解码
    for (NSURLQueryItem *queryItem in urlComponents.queryItems) {
        if (queryItem.name && queryItem.value) {
            // 自动处理URL编码的解码
            NSString *decodedValue = [queryItem.value stringByRemovingPercentEncoding] ?: queryItem.value;
            parameters[queryItem.name] = decodedValue;
        }
    }
    
    return [parameters copy];
}



@end
