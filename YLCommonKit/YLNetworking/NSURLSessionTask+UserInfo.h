//
//  NSURLSessionTask+UserInfo.h
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLSessionTask (UserInfo)
/**
 * 为请求添加一个属性
 */
@property (nonatomic, strong) NSMutableDictionary *userinfo;

@end
