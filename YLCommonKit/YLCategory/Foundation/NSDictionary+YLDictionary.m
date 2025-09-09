//
//  NSDictionary+YLDictionary.m
//  YLCommonKit
//
//  Created by xyanl on 2020/11/18.
//  Copyright © 2020 xyanl. All rights reserved.
//

#import "NSDictionary+YLDictionary.h"

@implementation NSDictionary (YLDictionary)

/// 读取并解析主Bundle中的本地JSON文件
/// @discussion 该方法会尝试从主Bundle中查找指定名称和扩展名的文件，并将其内容解析为JSON对象（通常是NSDictionary或NSArray）。如果文件不存在、无法读取或不是有效的JSON格式，会返回nil并在控制台输出错误信息。
/// @param name 文件名（不包含扩展名）
/// @param type 文件扩展名（如："json"）
/// @return 解析后的JSON对象（NSDictionary或NSArray），如果出现错误则返回nil
+ (nullable id)yl_readLocalFileWithName:(NSString *)name type:(NSString *)type {
    // 1. 参数检查
    if (name.length == 0 || type.length == 0) {
        NSLog(@"⚠️ 文件名或类型不能为空");
        return nil;
    }
    
    // 2. 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    if (!path) {
        NSLog(@"⚠️ 未找到文件: %@.%@", name, type);
        return nil;
    }
    
    // 3. 读取文件数据
    NSError *dataError = nil;
    NSData *data = [NSData dataWithContentsOfFile:path options:0 error:&dataError];
    if (dataError) {
        NSLog(@"⚠️ 读取文件失败: %@", dataError.localizedDescription);
        return nil;
    }
    
    if (data.length == 0) {
        NSLog(@"⚠️ 文件内容为空: %@.%@", name, type);
        return nil;
    }
    
    // 4. JSON解析
    NSError *jsonError = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
    
    if (jsonError) {
        NSLog(@"⚠️ JSON解析失败: %@", jsonError.localizedDescription);
        return nil;
    }
    
    // 5. 类型检查（可选，根据需求）
    if (![jsonObject isKindOfClass:[NSDictionary class]] && ![jsonObject isKindOfClass:[NSArray class]]) {
        NSLog(@"⚠️ JSON格式异常: 根对象不是字典或数组");
        return nil;
    }
    
    return jsonObject;
}

@end
