//
//  JYNetManager.h
//  JieYueKit_Example
//
//  Created by xyanl on 2018/4/23.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "AFNetworkActivityIndicatorManager.h"
#import "JYResponseTip.h"
#import "NSURLSessionTask+UserInfo.h"

/** 网络通知 */
UIKIT_EXTERN NSString * const JYAPPBecomeActiveNotification;
UIKIT_EXTERN NSString * const JYAPPBecomeUnActiveNotification;

@interface JYNetManager : NSObject
@property(nonatomic,strong,readonly) AFHTTPSessionManager*  afRequestManager;
@property(nonatomic,copy,readonly) NSString* versionName;
@property(nonatomic,copy,readonly) NSString* terminal;
@property(nonatomic,copy,readonly) NSString* language;

+ (instancetype)sharedInstance;

- (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval;
- (void)cancelAllRequests;

- (BOOL)adjustQueueItemType:(NSInteger)type flag:(NSInteger)flag;

- (void)cancelRequestWithType:(NSInteger)type;
- (void)cancelRequestWithType:(NSInteger)type flag:(NSInteger)flag;
- (void)requestSettings:(NSURLSessionDataTask*)request type:(NSInteger)type flag:(NSInteger)flag tip:(JYResponseTip*)tip;
- (NSMutableDictionary*)addBaseParams:(NSDictionary*)params;
- (NSString *)getParamValueFromUrl:(NSString*)url paramName:(NSString *)paramName;

/**
 * 是否有网络
 */
- (BOOL)isReachable;
/**
 * 开启网络监控
 */
- (void)startNotifier;

@end
