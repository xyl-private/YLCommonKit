//
//  NSURLSessionTask+UserInfo.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "NSURLSessionTask+UserInfo.h"
#import <objc/runtime.h>

@implementation NSURLSessionTask (UserInfo)

static const char *TaskUserinfo = "TaskUserinfo";

- (void)setUserinfo:(NSMutableDictionary *)userinfo
{
    objc_setAssociatedObject(self, TaskUserinfo, userinfo, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableDictionary*)userinfo
{
    return objc_getAssociatedObject(self, TaskUserinfo);
}


@end
