//
//  NSURLSessionTask+UserInfo.h
//  Pods
//
//  Created by xyanl on 2018/4/23.
//

#import <Foundation/Foundation.h>

@interface NSURLSessionTask (UserInfo)
/**
 * 为请求添加一个属性
 */
@property (nonatomic, strong) NSMutableDictionary *userinfo;

@end
