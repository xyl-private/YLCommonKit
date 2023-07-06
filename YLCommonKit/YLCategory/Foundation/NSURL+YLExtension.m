//
//  NSURL+YLExtension.m
//  YLCommonKit
//
//  Created by xyanl on 2023/6/25.
//  Copyright © 2023 xyanl. All rights reserved.
//

#import "NSURL+YLExtension.h"

@implementation NSURL (YLExtension)

/// 获取URL中参数组件
/// NSURL: https://testapp.dylan-saas.com/share/new/dl-order/index.html?key=26ccaad7-5712-46a3-a0f4-bf720c9bbcfa&type=19
/// 返回: @{ @"key": @"26ccaad7-5712-46a3-a0f4-bf720c9bbcfa", @"type": @"19"}
- (NSDictionary *)yl_queryComponents {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc]init];
    //传入url创建url组件类
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:self.absoluteString];
    //回调遍历所有参数，添加入字典
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [parm setObject:obj.value forKey:obj.name];
    }];
    return parm;
}



@end
