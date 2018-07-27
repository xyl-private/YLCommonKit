//
//  YLNetManager+YLAction.m
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//

#import "YLNetManager+YLAction.h"
#import "YLNetManager.h"
#import "YLAESManager.h"
#import "YLToolMacro.h"
#import <YYModel.h>

static NSInteger const kNorFlag = 2000;

/** 网络加解密Key */
NSString * const AESPWDKey = @"0123456789123456";
/** AES加密请求Key */
NSString * const AESBodyEncrypt = @"aesRequest";
/** AES解密请求Key */
NSString * const AESBodyDecrypt = @"aesResponse";

@implementation YLNetManager (YLAction)
/**
 校验请求
 
 @param params 参数
 @param type 请求类型
 @param flag 请求标识
 @param completeBlock 回调
 @return YES校验失败
 */
- (BOOL)adjustRequestParameters:(NSDictionary *)params type:(YLHttpRequestType)type flag:(YLHttpRequestFlag)flag completeBlock:(CompleteBlock)completeBlock
{
    __block YLHttpResponseTip *tip = [[YLHttpResponseTip alloc] init];
    
    // 校验网络状态
    if (![YLNetManager sharedInstance].isReachable){
        [tip setUpWithRequestErrorType:YLHttpRequestErrorTypeLoseSession requestType:type requestFlag:flag retCode:kResultCodeErrorStr errorDesc:kNoNetworkErrorDescStr];
        YLCOMPLETEBLOCK(tip, nil);
        return YES;
    }
    // 校验是否是相同请求
    if (type != YLHttpRequestTypeNone &&
        type != YLRequestTypeImageShow) {
        if ([self adjustQueueItemType:type flag:flag]){
            [tip setUpWithRequestErrorType:YLHttpRequestErrorTypeSameInQueue requestType:type requestFlag:flag retCode:kResultCodeErrorStr errorDesc:kSameRequestErrorDescStr];
            YLCOMPLETEBLOCK(tip, nil);
            return YES;
        }
    }
    return NO;
}

/**
 post请求
 
 @param url 请求地址
 @param params 参数字典
 @param type 请求类型
 @param completeBlock 请求回调
 */
- (void)yl_postWithUrl:(NSString *)url parameters:(NSDictionary *)params type:(YLHttpRequestType)type completeBlock:(CompleteBlock)completeBlock
{
    [self yl_postWithUrl:url parameters:params type:type flag:(type + kNorFlag) completeBlock:completeBlock];
}

/**
 post请求 带flag请求标识
 
 @param url 请求地址
 @param params 参数字典
 @param type 请求类型
 @param flag flag
 @param completeBlock 请求回调
 */
- (void)yl_postWithUrl:(NSString *)url parameters:(NSDictionary *)params type:(YLHttpRequestType)type flag:(YLHttpRequestFlag)flag completeBlock:(CompleteBlock)completeBlock
{
    __block YLHttpResponseTip *tip = [[YLHttpResponseTip alloc] init];
    // 校验请求
    if ([self adjustRequestParameters:params type:type flag:flag completeBlock:completeBlock]) return;
    // 加密 - 图片返显不需要加密
    if (params.count > 0 && type != YLRequestTypeImageShow) {
        params = [YLAESManager requestAES:params password:AESPWDKey aesDicKey:AESBodyEncrypt];
    }
    
    // 请求方法
    NSURLSessionDataTask *request = [self.afRequestManager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        NSDictionary *resultDict = nil;
        // 解密
        if (type != YLRequestTypeImageShow) {
            NSString *string = [YLAESManager responseDecrypt:responseObject[AESBodyDecrypt] password:AESPWDKey];
            resultDict = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        } else {
            resultDict = responseObject;
        }
        YLLog(@"%@", resultDict);
        if (resultDict.count == 0) {
            [tip setUpWithRequestErrorType:YLHttpRequestErrorTypeJsonFormat requestType:type requestFlag:flag retCode:kResultCodeErrorStr errorDesc:kResultDataErrorDescStr];
        } else {
            // 转Response模型
            tip = [YLHttpResponseTip yy_modelWithDictionary:resultDict];
        }
        if (tip.isSuccess) {
            YLResponseTip *taskTip = task.userinfo[kResponseTip];
            tip.requestType = taskTip.type;
            tip.requestFlag = taskTip.flag;
            YLCOMPLETEBLOCK(tip, resultDict[kResponseBody]);
        } else {
            if (tip == nil) {
                tip = [[YLHttpResponseTip alloc] init];
                [tip setUpWithRequestErrorType:YLHttpRequestErrorTypeHostNotReach requestType:type requestFlag:flag retCode:kResultCodeErrorStr errorDesc:kNoNetworkErrorDescStr];
            }
            YLCOMPLETEBLOCK(tip, resultDict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //失败回调
        if (error.code == NSURLErrorCancelled) { // 请求取消
            [tip setUpWithRequestErrorType:YLHttpRequestErrorTypeCancel requestType:type requestFlag:flag retCode:kResultCodeErrorStr errorDesc:kNoNetworkErrorDescStr];
        } else if (error.code == NSURLErrorTimedOut){ // 请求超时
            [tip setUpWithRequestErrorType:YLHttpRequestErrorTypeTimeOut requestType:type requestFlag:flag retCode:kResultCodeErrorStr errorDesc:kNoNetworkErrorDescStr];
        } else { // 其他
            [tip setUpWithRequestErrorType:YLHttpRequestErrorTypeHostNotReach requestType:type requestFlag:flag retCode:kResultCodeErrorStr errorDesc:kNoNetworkErrorDescStr];
        }
        YLCOMPLETEBLOCK(tip, nil);
    }];
    // 设置userinfo
    [[YLNetManager sharedInstance] requestSettings:request type:type flag:flag tip:tip];
}

/**
 上传
 
 @param url 地址
 @param fileUrl 文件地址
 @param params 字典参数
 @param type 请求类型
 @param progressBlock 进度回调
 @param completeBlock 请求回调
 */
- (void)yl_uploadWithUrl:(NSString *)url fileUrl:(NSString *)fileUrl parameters:(NSDictionary *)params type:(YLHttpRequestType)type progressBlock:(ProgressBlock)progressBlock completeBlock:(CompleteBlock)completeBlock
{
    [self yl_uploadWithUrl:url fileUrl:fileUrl parameters:params type:type flag:(type + kNorFlag) progressBlock:progressBlock completeBlock:completeBlock];
}

/**
 上传
 
 @param url 地址
 @param fileUrl 文件地址
 @param params 字典参数
 @param type 请求类型
 @param flag flag
 @param progressBlock 进度回调
 @param completeBlock 请求回调
 */
- (void)yl_uploadWithUrl:(NSString *)url fileUrl:(NSString *)fileUrl parameters:(NSDictionary *)params type:(YLHttpRequestType)type flag:(YLHttpRequestFlag)flag progressBlock:(ProgressBlock)progressBlock completeBlock:(CompleteBlock)completeBlock
{
    __block YLHttpResponseTip *tip = [[YLHttpResponseTip alloc] init];
    
    // 校验请求
    if ([self adjustRequestParameters:params type:type flag:flag completeBlock:completeBlock]) return;
    // 请求方法
    NSURLSessionDataTask *request = [self.afRequestManager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSURL *filePath = [NSURL fileURLWithPath:fileUrl];
        if (filePath != nil) {
            [formData appendPartWithFileURL:filePath name:@"zip" error:nil];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 进度
        YLLog(@"%f",uploadProgress.fractionCompleted);
        tip.uploadProgress = uploadProgress.fractionCompleted;
        YLPROGRESSBLOCK(tip);
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        // 解密
        NSDictionary *resultDict = nil;
        if (type == YLRequestTypeUploadFileLHChannelZip) {
            NSString *string = [YLAESManager responseDecrypt:responseObject[AESBodyDecrypt] password:AESPWDKey];
            resultDict = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        } else {
            resultDict = responseObject[kResponseBody];
        }
        YLLog(@"%@", resultDict);
        if (resultDict.count == 0) {
            [tip setUpWithRequestErrorType:YLHttpRequestErrorTypeJsonFormat requestType:type requestFlag:flag retCode:kResultCodeErrorStr errorDesc:kResultDataErrorDescStr];
        } else {
            //转Response模型d
            tip = [YLHttpResponseTip yy_modelWithDictionary:resultDict];
        }
        if (tip.isSuccess) {
            YLResponseTip *taskTip = task.userinfo[kResponseTip];
            tip.requestType = taskTip.type;
            tip.requestFlag = taskTip.flag;
            YLCOMPLETEBLOCK(tip, type == YLRequestTypeUploadFileLHChannelZip ? resultDict[kResponseBody] : resultDict);
        } else {
            if (tip == nil) {
                tip = [[YLHttpResponseTip alloc] init];
                [tip setUpWithRequestErrorType:YLHttpRequestErrorTypeHostNotReach requestType:type requestFlag:flag retCode:kResultCodeErrorStr errorDesc:kNoNetworkErrorDescStr];
            }
            YLCOMPLETEBLOCK(tip, resultDict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //失败回调
        if (error.code == NSURLErrorCancelled) { // 请求取消
            [tip setUpWithRequestErrorType:YLHttpRequestErrorTypeCancel requestType:type requestFlag:flag retCode:kResultCodeErrorStr errorDesc:kNoNetworkErrorDescStr];
        } else if (error.code == NSURLErrorTimedOut){ // 请求超时
            [tip setUpWithRequestErrorType:YLHttpRequestErrorTypeTimeOut requestType:type requestFlag:flag retCode:kResultCodeErrorStr errorDesc:kNoNetworkErrorDescStr];
        } else { // 其他
            [tip setUpWithRequestErrorType:YLHttpRequestErrorTypeHostNotReach requestType:type requestFlag:flag retCode:kResultCodeErrorStr errorDesc:kNoNetworkErrorDescStr];
        }
        YLCOMPLETEBLOCK(tip, nil);
    }];
    // 设置userinfo
    [[YLNetManager sharedInstance] requestSettings:request type:type flag:flag tip:tip];
}

/**
 取消请求
 
 @param type 取消的请求类型
 */
- (void)yl_cancelRequestType:(YLHttpRequestType)type
{
    //取消请求，flag默认为type + kNorFlag
    [self yl_cancelRequestType:type flag:(type + kNorFlag)];
}

/**
 取消请求
 
 @param type 取消的请求类型
 @param flag 取消的请求flag
 */
- (void)yl_cancelRequestType:(YLHttpRequestType)type flag:(YLHttpRequestFlag)flag
{
    [[YLNetManager sharedInstance] cancelRequestWithType:type flag:flag];
}

@end
