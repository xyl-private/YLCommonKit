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

/// 读取本地JSON文件
/// @param name 文件名字
/// @param type 文件类型
+ (NSDictionary *)yl_readLocalFileWithName:(NSString *)name type:(NSString *)type;


@end

NS_ASSUME_NONNULL_END
