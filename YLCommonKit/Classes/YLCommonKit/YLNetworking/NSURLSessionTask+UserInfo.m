//
//  NSURLSessionTask+UserInfo.m
//  Pods
//
//  Created by xyanl on 2018/4/23.
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
