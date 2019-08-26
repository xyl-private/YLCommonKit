//
//  NSDictionary+YLDictionary.h
//  YLCommonKit
//
//  Created by xyanl on 2019/8/26.
//  Copyright © 2019 xyanl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (YLDictionary)

/**
 读取本地JSON文件
 @param name 文件名字
 @param type 文件类型
 */
+ (NSDictionary *)yl_readLocalFileWithName:(NSString *)name type:(NSString *)type;
@end

NS_ASSUME_NONNULL_END
