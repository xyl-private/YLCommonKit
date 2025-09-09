//
//  NSDictionary+YLDictionary.h
//  YLCommonKit
//
//  Created by xyanl on 2020/11/18.
//  Copyright © 2020 xyanl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (YLDictionary)

/// 读取并解析主Bundle中的本地JSON文件
/// @discussion 该方法会尝试从主Bundle中查找指定名称和扩展名的文件，并将其内容解析为JSON对象（通常是NSDictionary或NSArray）。如果文件不存在、无法读取或不是有效的JSON格式，会返回nil并在控制台输出错误信息。
/// @param name 文件名（不包含扩展名）
/// @param type 文件扩展名（如："json"）
/// @return 解析后的JSON对象（NSDictionary或NSArray），如果出现错误则返回nil
+ (nullable id)yl_readLocalFileWithName:(NSString *)name type:(NSString *)type;


@end

NS_ASSUME_NONNULL_END
