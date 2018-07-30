//
//  YLNetManager.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "YLNetManager.h"
#import "YLResponseTip.h"
#import <Reachability.h>
#import <AFNetworkReachabilityManager.h>

/** 网络通知 */
NSString * const YLAPPBecomeActiveNotification     = @"YLAPPBecomeActiveNotification";
NSString * const YLAPPBecomeUnActiveNotification   = @"YLAPPBecomeUnActiveNotification";

static YLNetManager *__shareNetManager = nil;

@interface YLNetManager()
@property(nonatomic, strong)AFHTTPSessionManager*  afRequestManager;
@property(nonatomic, copy) NSString* versionName;
@property(nonatomic, copy) NSString* terminal;
@property(nonatomic, copy) NSString* language;

@property (nonatomic, strong) NSMutableArray *arrays;
//网络状态监听参数
@property (nonatomic, strong) Reachability *cellularReachability;
@property (nonatomic, assign) NetworkStatus previousNetworkStatus;

@end

@implementation YLNetManager
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __shareNetManager = [[self alloc] init];
    });
    return __shareNetManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __shareNetManager = [super allocWithZone:zone];
    });
    return __shareNetManager;
}

- (id)copyWithZone:(NSZone *)zone
{
    return __shareNetManager;
}

- (instancetype)init
{
    if (self = [super init]){
        _afRequestManager = [AFHTTPSessionManager manager];
        
        //net indicatior
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        _afRequestManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _afRequestManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _afRequestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
        //超时
        _afRequestManager.requestSerializer.timeoutInterval = 90;
        
        //terminal
        _terminal = @"ios";
        
        //version name
        _versionName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        
        //language
        NSArray *languages = [NSLocale preferredLanguages];
        _language = [languages objectAtIndex:0];
        
        //无网络监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yl_cancelAllRequest) name:YLAPPBecomeUnActiveNotification object:nil];
        //创建网络监听实例
        self.cellularReachability = [Reachability reachabilityForInternetConnection];

    }
    return self;
}

- (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval {
    //超时
    _afRequestManager.requestSerializer.timeoutInterval = timeoutInterval;
    
}

- (BOOL)adjustQueueItemType:(NSInteger)type flag:(NSInteger)flag
{
    __block BOOL isSamed = NO;
    [self.afRequestManager.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
        YLResponseTip *tip = [task.userinfo valueForKeyPath:kResponseTip];
        if (tip && (tip.type == type) && (tip.flag == flag)) {
            isSamed = YES;
            *stop = YES;
        }
    }];
    return isSamed;
}

- (void)cancelRequestWithType:(NSInteger)type
{
    [self.afRequestManager.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
        YLResponseTip *tip = [task.userinfo valueForKeyPath:kResponseTip];
        if (tip && tip.type == type) {
            [task cancel];
            *stop = YES;
        }
    }];
    
}
- (void)cancelRequestWithType:(NSInteger)type flag:(NSInteger)flag
{
    [self.afRequestManager.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
        YLResponseTip *tip = [task.userinfo valueForKeyPath:kResponseTip];
        if (tip && (tip.type == type) && (tip.flag == flag)) {
            [task cancel];
            *stop = YES;
        }
    }];
}

- (void)requestSettings:(NSURLSessionDataTask*)request type:(NSInteger)type flag:(NSInteger)flag tip:(YLResponseTip *)tip
{
    if (!tip) return;
    
    NSMutableDictionary* userinfo = [NSMutableDictionary dictionary];
    tip.type = type;
    tip.flag = flag;
    
    [userinfo setObject:tip forKey:kResponseTip];
    request.userinfo = userinfo;
}

- (NSMutableDictionary*)addBaseParams:(NSDictionary*)params
{
    NSMutableDictionary* dics = nil;
    //    if (params){
    //        dics = [NSMutableDictionary dictionaryWithDictionary:params];
    //    }
    //    else{
    //        dics = [NSMutableDictionary dictionary];
    //    }
    //    //version name
    //    [dics setObject:self.versionName forKey:KVersionName];
    //    //android or ios
    //    [dics setObject:self.terminal forKey:KTerminal];
    
    return dics;
}

- (NSString *)getParamValueFromUrl:(NSString*)url paramName:(NSString *)paramName
{
    if (![paramName hasSuffix:@"="]){
        paramName = [NSString stringWithFormat:@"%@=", paramName];
    }
    
    NSString * str = nil;
    NSString *tmpStr = nil;
    NSRange start = [url rangeOfString:paramName];
    if (start.location != NSNotFound){
        unichar c = '?';
        if (start.location != 0){
            c = [url characterAtIndex:start.location - 1];
        }
        if (c == '?' || c == '&' || c == '#'){
            NSRange end = [[url substringFromIndex:start.location+start.length] rangeOfString:@"&"];
            NSUInteger offset = start.location+start.length;
            str = end.location == NSNotFound ?
            [url substringFromIndex:offset] :
            [url substringWithRange:NSMakeRange(offset, end.location)];
            tmpStr = [NSString stringWithString:str];
            //            str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        }
    }
    
    if(str){
        return str;
    }
    else{
        return tmpStr;
    }
}

- (void)cancelAllRequests
{
    [_afRequestManager.operationQueue cancelAllOperations];
}

/**
 * 取消所有请求
 */
- (void)yl_cancelAllRequest
{
    [self.afRequestManager.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
        [task cancel];
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:YLAPPBecomeUnActiveNotification object:nil];
}

#pragma mark --
#pragma mark - 网络监听
- (BOOL)isReachable
{
    return [self.cellularReachability isReachable];
}

- (void)startNotifier
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    [self.cellularReachability startNotifier];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

#pragma mark --
#pragma mark NSNotification
- (void)reachabilityChanged:(NSNotification*)notification
{
    Reachability* curReach = [notification object];
    if (curReach != self.cellularReachability) return;
    
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    switch (netStatus){
            case NotReachable:{
                [[NSNotificationCenter defaultCenter] postNotificationName:YLAPPBecomeUnActiveNotification object:nil];
                break;
            }
            case ReachableViaWWAN:{
                [[NSNotificationCenter defaultCenter] postNotificationName:YLAPPBecomeActiveNotification object:nil];
                break;
            }
            case ReachableViaWiFi:{
                [[NSNotificationCenter defaultCenter] postNotificationName:YLAPPBecomeActiveNotification object:nil];
                break;
            }
    }
    self.previousNetworkStatus = netStatus;
}
@end
