//
//  YLMacro.h
//  YLCommonKit
//
//  Created by xyanl on 2023/7/7.
//  Copyright © 2023 xyanl. All rights reserved.
//
//  单例宏的创建
// .h文件
#define YLSingletonH(name) +(instancetype)share##name

#if __has_feature(objc_arc)
// ARC
#define YLSingletonM(name) \
static id _shareInstance;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
    _shareInstance = [super allocWithZone:zone];\
    });\
    return _shareInstance;\
}\
\
+ (instancetype)share##name\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _shareInstance = [[self alloc] init];\
    });\
    return _shareInstance;\
}\
\
- (id)copyWithZone:(NSZone *)zone\
{\
    return _shareInstance;\
}\
\
- (id)mutableCopyWithZone:(NSZone *)zone\
{\
    return _shareInstance;\
}
#else
// MRC
#define YLSingletonM(name) \
static id _shareInstance;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
    _shareInstance = [super allocWithZone:zone];\
    });\
    return _shareInstance;\
}\
\
+ (instancetype)share##name\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _shareInstance = [[self alloc] init];\
    });\
    return _shareInstance;\
}\
\
- (id)copyWithZone:(NSZone *)zone\
{\
    return _shareInstance;\
}\
\
- (id)mutableCopyWithZone:(NSZone *)zone\
{\
    return _shareInstance;\
}\
- (oneway void)release\
{\
}\
\
- (instancetype)retain\
{\
    return _shareInstance;\
}\
\
- (NSUInteger)retainCount\
{\
    return MAXFLOAT;\
}
#endif /* YLSingleton_h */
