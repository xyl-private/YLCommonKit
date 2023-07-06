//
//  NSDictionary+YLDictionary.m
//  YLCommonKit
//
//  Created by xyanl on 2020/11/18.
//  Copyright © 2020 xyanl. All rights reserved.
//

#import "NSDictionary+YLDictionary.h"

@implementation NSDictionary (YLDictionary)

/// 读取本地JSON文件
/// @param name 文件名字
/// @param type 文件类型
+ (NSDictionary *)yl_readLocalFileWithName:(NSString *)name type:(NSString *)type{
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

@end
